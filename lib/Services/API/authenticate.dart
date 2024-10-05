import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:paradise_sri_lanka/Services/API/Exceptions/authentication_exception.dart';

class ParadiseAuthenticate {
  static const String _baseurl = 'http://10.10.13.11:4000/api/auth';

  static String _accessToken = '';
  static String _refreshToken = '';
  static AuthUser? _currentUser;

  static Future<void> init() async {
    _refreshToken = GetStorage().read('refreshToken') ?? '';
    if (_refreshToken.isNotEmpty) {
      await getAccessToken();
      if(_accessToken.isNotEmpty){
        await _getCurrentUser();
      }
    }
  }

  static Future<AuthUser?> get currentUser async {
    if (!(await isLoggedIn)) {
      return null;
    }
    if (_currentUser != null) return _currentUser;
    await _getCurrentUser();
    return _currentUser;
  }

  static Future<void> _getCurrentUser() async {
    if (_refreshToken != '' && _accessToken != '') {
      final response = await http.post(
        Uri.parse('$_baseurl/getCurrentUserDetails'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': _accessToken,
        }),
      );
      if (response.statusCode == 200) {
        _currentUser = AuthUser.fromJson(jsonDecode(response.body)['user']);
      }
    }
  }

  static Future<void> login(AuthUser authLoginUser) async {
    String? validationMessage = validateLogin(authLoginUser);
    if (validationMessage != null) {
      throw AuthenticationException(validationMessage);
    }
    final response = await http.post(
      Uri.parse('$_baseurl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': authLoginUser.email,
        'password': authLoginUser.password,
      }),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _accessToken = jsonDecode(response.body)['accessToken'];
      _refreshToken = jsonDecode(response.body)['refreshToken'];
      _currentUser = AuthUser.fromJson(jsonDecode(response.body)['user']);
      await GetStorage().write('refreshToken', _refreshToken);
    } else if (response.statusCode == 404) {
      throw AuthenticationException('User not found');
    } else if (response.statusCode == 403) {
      throw AuthenticationException('Invalid email or password');
    } else if (response.statusCode == 500) {
      throw AuthenticationException('Server Error! Try again later.');
    }
  }

  static Future<void> register(AuthUser authRegisterUser) async {
    String? validationMessage = validateRegister(authRegisterUser);
    if (validationMessage != null) {
      throw AuthenticationException(validationMessage);
    }
    final response = await http.post(
      Uri.parse('$_baseurl/registerEmailPassword'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': authRegisterUser.email,
        'password': authRegisterUser.password,
        'firstName': authRegisterUser.firstName,
        'lastName': authRegisterUser.lastName,
        'countryId': authRegisterUser.countryId,
      }),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _accessToken = jsonDecode(response.body)['accessToken'];
      _refreshToken = jsonDecode(response.body)['refreshToken'];
      _currentUser = AuthUser.fromJson(jsonDecode(response.body)['user']);
      await GetStorage().write('refreshToken', _refreshToken);
    } else if (response.statusCode == 409) {
      throw AuthenticationException('Email already exists');
    } else if (response.statusCode == 500) {
      throw AuthenticationException('Server Error! Try again later.');
    }
  }

  static Future<void> logout() async {
    final response = await http.post(
      Uri.parse('$_baseurl/logout'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': _refreshToken}),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 204) {
      _accessToken = '';
      _refreshToken = '';
      _currentUser = null;
      print('Logged out');
      GetStorage().remove('refreshToken');
    } else if (response.statusCode == 500) {
      throw AuthenticationException('Server Error! Try again later.');
    }
  }

  static Future<void> getAccessToken() async {
    if (_refreshToken == '') return;

    final response = await http.post(
      Uri.parse('$_baseurl/token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': _refreshToken}),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      _accessToken = jsonDecode(response.body)['accessToken'];
    }
    else if (response.statusCode == 403) {
      _accessToken = '';
      _refreshToken = '';
      _currentUser = null;
      GetStorage().remove('refreshToken');
    }
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    final response = await http.post(
      Uri.parse('$_baseurl/resetPasswordRequest'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return;
    } else if(response.statusCode == 400){
      throw AuthenticationException('Email needed');
  } else if (response.statusCode == 404) {
      throw AuthenticationException('User not found');
    } else if (response.statusCode == 500) {
      throw AuthenticationException('Server Error! Try again later.');
    }
  }

  static Future<void> resetPassword(String email, String password, String otp) async {
    final response = await http.post(
      Uri.parse('$_baseurl/resetPassword'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'otp': otp,
      }),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 205) {
      return;
    } else if(response.statusCode == 400){
      throw AuthenticationException('Email, password and OTP needed');
    } else if (response.statusCode == 401) {
      throw AuthenticationException('OTP is invalid or expired');
    } else if (response.statusCode == 500) {
      throw AuthenticationException('Server Error! Try again later.');
    }
  }








  static addAuthorizationHeader(Map<String, String> headers) async {
    if(await isLoggedIn){
      headers['Authorization'] = 'Bearer $_accessToken';
      return;
    }
    throw AuthenticationException('User not logged in');
  }

  static Future<bool> get isLoggedIn async {
    if (_accessToken.isNotEmpty) return true;
    if (_refreshToken.isEmpty) {
      _refreshToken = GetStorage().read('refreshToken') ?? '';
    }
    if (_refreshToken.isNotEmpty) {
      await getAccessToken();
      return _accessToken.isNotEmpty;
    }
    _currentUser = null;
    return false;
  }

  static Future<String?> get accessToken async {
    if (await isLoggedIn) return _accessToken;
    return null;
  }

  static String? validateLogin(AuthUser authUser) {
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(authUser.email)) {
      return 'Invalid email format';
    }

    if (authUser.password == null ||
        authUser.password!.length < 8 ||
        authUser.password!.length > 30) {
      return 'Password must be between 8 and 30 characters';
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])')
        .hasMatch(authUser.password!)) {
      return 'Password must contain at least one lowercase letter, one uppercase letter, one number, and one special character';
    }

    return null; // Valid input
  }

  static String? validateRegister(AuthUser authUser) {
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(authUser.email)) {
      return 'Invalid email format';
    }

    if (authUser.password == null ||
        authUser.password!.length < 8 ||
        authUser.password!.length > 30) {
      return 'Password must be between 8 and 30 characters';
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])')
        .hasMatch(authUser.password!)) {
      return 'Password must contain at least one lowercase letter, one uppercase letter, one number, and one special character';
    }

    if (authUser.firstName.isEmpty ||
        authUser.firstName.length < 2 ||
        authUser.firstName.length > 50) {
      return 'First name must be between 2 and 50 characters';
    }

    if (authUser.lastName.isEmpty ||
        authUser.lastName.length < 2 ||
        authUser.lastName.length > 50) {
      return 'Last name must be between 2 and 50 characters';
    }

    if (authUser.countryId == null || authUser.countryId?.length != 3) {
      return 'Invalid country';
    }

    return null; // Valid input
  }
}

class AuthUser {
  late final int? userId;
  late final String email, firstName, lastName;
  late final String? password, countryId;

  AuthUser.forLogin({required this.email, required this.password});

  AuthUser.forRegister({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.countryId,
  });

  AuthUser.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    countryId = json['countryId'];
  }
}

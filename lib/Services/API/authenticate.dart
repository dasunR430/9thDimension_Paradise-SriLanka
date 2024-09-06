import 'dart:convert';
import 'package:http/http.dart' as http;

class ParadiseAuthenticate {
  static const String _baseurl = 'http://10.10.13.11:4000/api/auth';

  static String _accessToken = '';
  static String _refreshToken = '';
  static int _userId = 0;
  static String get userId => _userId.toString();

  static Future<void> login(AuthUser authLoginUser) async {
    String? validationMessage = validateLogin(authLoginUser);
    if (validationMessage != null) {
      throw Exception(validationMessage);
    }
    final response = await http.post(
        Uri.parse('$_baseurl/login'),
        headers: {
          'Content-Type': 'application/json'
        },
      body: jsonEncode({
        'email': authLoginUser.email,
        'password': authLoginUser.password,
      }),
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      _accessToken = jsonDecode(response.body)['accessToken'];
      _refreshToken = jsonDecode(response.body)['refreshToken'];
      _userId = jsonDecode(response.body)['userId'];
    }
  }

  static Future<void> register(AuthUser authRegisterUser) async {
    String? validationMessage = validateRegister(authRegisterUser);
    if (validationMessage != null) {
      throw Exception(validationMessage);
    }
    final response = await http.post(
        Uri.parse('$_baseurl/registerEmailPassword'),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'email': authRegisterUser.email,
          'password': authRegisterUser.password,
          'firstName': authRegisterUser.firstName,
          'lastName': authRegisterUser.lastName,
          'countryCode': authRegisterUser.countryCode,
          'phoneNo': authRegisterUser.phoneNumber
        }),
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      _accessToken = jsonDecode(response.body)['accessToken'];
      _refreshToken = jsonDecode(response.body)['refreshToken'];
      _userId = jsonDecode(response.body)['userId'];
    }
  }

  static Future<void> logout() async {
    final response = await http.post(
        Uri.parse('$_baseurl/logout'),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'token': _refreshToken
        }),
    );
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      _accessToken = '';
      _refreshToken = '';
      _userId = 0;
    }
  }

  static Future<void> _getAccessToken() async {
    final response = await http.post(
        Uri.parse('$_baseurl/token'),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'token': _refreshToken
        }),
    );
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      _accessToken = jsonDecode(response.body)['accessToken'];
    }
    else if(response.statusCode == 403){
      _accessToken = '';
      _refreshToken = '';
      _userId = 0;
    }
  }

  static Future<bool> get isLoggedIn async{
    if(_accessToken.isNotEmpty) return true;
    if(_refreshToken.isNotEmpty) {
      await _getAccessToken();
      return _accessToken.isNotEmpty;
    }
    return false;
  }

  static Future<String?> get accessToken async {
    if(await isLoggedIn) return _accessToken;
    return null;
  }




  static String? validateLogin(AuthUser authUser) {
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(authUser.email)) {
      return 'Invalid email format';
    }

    if (authUser.password.length < 8 || authUser.password.length > 30) {
      return 'Password must be between 8 and 30 characters';
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])').hasMatch(authUser.password)) {
      return 'Password must contain at least one lowercase letter, one uppercase letter, one number, and one special character';
    }

    return null; // Valid input
  }

  static String? validateRegister(AuthUser authUser) {
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(authUser.email)) {
      return 'Invalid email format';
    }

    if (authUser.password.length < 8 || authUser.password.length > 30) {
      return 'Password must be between 8 and 30 characters';
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])').hasMatch(authUser.password)) {
      return 'Password must contain at least one lowercase letter, one uppercase letter, one number, and one special character';
    }

    if (authUser.firstName.isEmpty || authUser.firstName.length < 2 || authUser.firstName.length > 50) {
      return 'First name must be between 2 and 50 characters';
    }

    if (authUser.lastName.isEmpty || authUser.lastName.length < 2 || authUser.lastName.length > 50) {
      return 'Last name must be between 2 and 50 characters';
    }

    if (authUser.countryCode != null && !RegExp(r"^[+][0-9]{1,3}$").hasMatch(authUser.countryCode!)) {
      return 'Invalid country code format';
    }

    if (authUser.phoneNumber != null && !RegExp(r'^[0-9]{7,15}$').hasMatch(authUser.phoneNumber!)) {
      return 'Phone number must be between 7 and 15 digits';
    }

    return null; // Valid input
  }


}



class AuthUser{
  late final  String email, password, firstName, lastName;
  late final String? countryCode, phoneNumber;

  AuthUser.forLogin({required this.email, required this.password});

  AuthUser.forRegister({required this.email, required this.password, required this.firstName, required this.lastName, this.countryCode, this.phoneNumber});
}
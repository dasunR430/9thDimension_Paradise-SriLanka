import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:paradise_sri_lanka/Utils/helpers/image_format.dart';


class FirebaseAuthentication {
  static FirebaseAuthentication instance = FirebaseAuthentication._internal();
  FirebaseAuthentication._internal();

  factory FirebaseAuthentication() => instance;


  //TODO: Change this and un comment the code below
  // fresh_pick_user.User? _currentUserData;
  //
  // Future<fresh_pick_user.User?> get currentUserData async{
  //   String? uid = currentUser?.uid;
  //   if(_currentUserData == null && uid != null){
  //     _currentUserData = await LocalDatabase().getUser(uid);
  //     if(_currentUserData == null){
  //       _currentUserData = await FirebaseDatabase().getUser(uid);
  //       if (_currentUserData != null) {
  //         await LocalDatabase().deleteUser(uid);
  //         LocalDatabase().insertUser(uid, _currentUserData!);
  //       }
  //     }
  //   }
  //   return _currentUserData;
  // }

  // for testing
  get userStateStream => null;

  Future<String?> createUserWithEmailAndPassword(
      Credentials credentials) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: credentials._email, password: credentials._password);
      sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "Email Already Exists!";
      } else if (e.code == 'invalid-email') {
        return "Invalid Email Address!";
      } else if (e.code == 'weak-password') {
        return "Weak Password!";
      } else if (e.code == 'network-request-failed') {
        return "Registration Failed! Check your internet connection.";
      }
    } catch (e) {
      return "Registration Failed! Check your internet connection.";
    }
    return null;
  }

  Future<String?> signInWithEmailAndPassword(Credentials credentials) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: credentials._email, password: credentials._password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return "Invalid Email Address!";
      } else if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        return "Invalid Email or Password";
      } else if (e.code == 'user-disabled') {
        return "Account has been disabled!";
      }
    } catch (e) {
      return "Sign In Failed! Check your internet connection.";
    }
    return null;
  }

  Future<String?> continueWithGoogle() async {
    // Create a new provider
    try {
      GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
      final googleAuth = await googleAccount?.authentication;

      final googleCredentials = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(googleCredentials);
      if(userCredential.additionalUserInfo!.isNewUser){
        List<String> names = userCredential.user!.displayName!.split(" ");
        String firstName = names.first;
        String lastName = names.last;
        String? phone = userCredential.user!.phoneNumber;
        String? picURL = userCredential.user!.photoURL;
        String pic = "";
        final response = await http.get(Uri.parse(userCredential.user!.photoURL!));
        Uint8List bytes = response.bodyBytes;
        pic = ImageFormat.encodeBytesToBase64(bytes);
              //TODO: Change this and un comment the code below
        //await FirebaseDatabase().addUser(fresh_pick_user.User(firstName, lastName, phone ?? "", picString: pic));
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return "Account already exists with a different log in method!";
      } else if (e.code == 'invalid-credential') {
        return "Invalid Credential!";
      } else if (e.code == 'user-disabled') {
        return "Account has been disabled!";
      }
    } catch (e) {
      return "Sign In Failed! Check your internet connection.";
    }
    return null;
  }

  void signOut() async{
    String? uid = currentUser?.uid;
    await FirebaseAuth.instance.signOut();
    //TODO: Change this and un comment the code below
    // _currentUserData = null;
    // Get.offAll(()=> const Selector());
  }

  Future<bool> deleteAccount() async{
    try{
      await FirebaseAuth.instance.currentUser?.delete();
      return true;
    } on FirebaseAuthException catch(e){
      if(e.code == 'requires-recent-login'){
        return false;
      }
    }
    return false;
  }

  Future<bool> get isEmailVerified async {
    if (currentUser == null) return false;
    if (!currentUser!.emailVerified) {
      await reloadCurrentUser();
      return currentUser!.emailVerified;
    }
    return true;
  }

  Future<bool> sendEmailVerification() async {
    if (currentUser == null) return false;
    currentUser!.sendEmailVerification();
    return true;
  }

  Future<String?> sendForgotPasswordPasswordReset(
      Credentials credentials) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: credentials._email);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-email') {
        return "Invalid Email Address!";
      } else if (e.code == 'user-not-found') {
        return "No user found with this email!";
      }
    } catch (e) {
      print(e.toString());
      return "Failed to send password reset email!";
    }
    return null;
  }

  Future<void> reloadCurrentUser() async {
    await currentUser?.reload();
  }

  User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }

  // Stream<User?> get userStateStream {
  //   return FirebaseAuth.instance.authStateChanges();
  // }
}

class Credentials {
  late final String _email, _password;

  Credentials(this._email, this._password);
}

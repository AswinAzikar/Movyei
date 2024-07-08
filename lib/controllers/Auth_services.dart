//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String verifyId = "";

  //to sent OTP to user
  static Future sentOTP({
    required String phone,
    required Function errorStep,
    required Function nextStep,
  }) async {
    await _firebaseAuth
        .verifyPhoneNumber(
            timeout: Duration(seconds: 30),
            phoneNumber: "+91$phone",
            verificationCompleted: (PhoneAuthCredential) async {
              return;
            },
            verificationFailed: (error) async {
              print(error);
              return;
            },
            codeSent: (verficationId, forceResendingToken) async {
              verifyId = verficationId;
              nextStep(verifyId);

              return;
            },
            codeAutoRetrievalTimeout: (verificationId) async {
              return;
            })
        .onError(
      (error, stackTrace) {
        print(error);
        errorStep();
      },
    );
  }

// verify and login
  static Future loginWithOTP({required String otp}) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
    try {
      final user = await _firebaseAuth.signInWithCredential(cred);
      if (user.user != null) {
        return "success";
      } else {
        return "Error in Otp login";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //logout
  static Future logout() async {
    await _firebaseAuth.signOut();
  }

//check if the user is logged in
  static Future<bool> isLoggedIn() async {
    final user = await _firebaseAuth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}

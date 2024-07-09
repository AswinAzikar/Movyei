import 'package:flutter/material.dart';
import 'package:moviyee/constants.dart';
import 'package:moviyee/controllers/Auth_services.dart';
import 'package:moviyee/controllers/otpVerificationPage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final _formKeyPhone = GlobalKey<FormState>();
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    _phoneController = TextEditingController(text: "9876543210");
  }

  @override
  void dispose() {
    _controller.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void switchtoVerification(String verificationId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OtpVerificationPage(phoneNumber: _phoneController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeTransition(
              opacity: _animation,
              child: Image.network(
                'https://img.freepik.com/free-photo/computer-security-with-login-password-padlock_107791-16191.jpg?t=st=1720426503~exp=1720430103~hmac=795d81b1cc34d3aa112bdd93319024995bccb929b86936bbfc57ea044eeb2c88&w=996',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  FadeTransition(
                    opacity: _animation,
                    child: const Text(
                      "Welcome back !",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.buttoncolor),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeTransition(
                    opacity: _animation,
                    child: const Text(
                      "Enter your phone number to continue.",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: AppConstants.textButtonColor),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 55,
                    child: Form(
                      key: _formKeyPhone,
                      child: TextFormField(
                        cursorColor: Colors.black,
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: AppConstants.buttoncolor,
                          prefix: const Text(
                            "+91 ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          labelText: "Your phone number here.",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your phone number.";
                          } else if (value.length != 10) {
                            return "Please enter a 10-digit number.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKeyPhone.currentState!.validate()) {
                    AuthService.sentOTP(
                      phone: _phoneController.text,
                      errorStep: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Error sending OTP',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      nextStep: switchtoVerification,
                    );
                  }
                },
                style: ButtonStyleConstants.elevatedButtonStyle,
                child: const Text(
                  "Send OTP",
                  style: TextStyle(
                    color: AppConstants.buttontext,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

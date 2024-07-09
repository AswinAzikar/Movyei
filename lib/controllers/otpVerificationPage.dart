import 'package:flutter/material.dart';
import 'package:moviyee/constants.dart';
import 'package:moviyee/controllers/Auth_services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({super.key, required this.phoneNumber});

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  late TextEditingController _otpController;
  final _formKeyOTP = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void verifyOTP() async {
    if (_formKeyOTP.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      String otp = _otpController.text.trim();
      String result = await AuthService.loginWithOTP(otp: otp);

      setState(() {
        _isLoading = false;
      });

      if (result == "success") {
        // Handle successful login
        print("OTP Verified successfully");
        // Navigate to the next page or show a success message
      } else {
        // Handle error
        setState(() {
          _errorMessage = result;
        });
        print("Error verifying OTP: $result");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  'https://socialnetworking.solutions/wp-content/themes/handel-child/images/otp/step2.png'),
              const SizedBox(height: 50),
              const Text(
                'SMS Verification',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 34, 14, 179),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter the OTP sent to ${widget.phoneNumber}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKeyOTP,
                child: Column(
                  children: [
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: AppConstants.buttoncolor,
                        selectedFillColor:
                            const Color.fromARGB(255, 227, 17, 17),
                        inactiveFillColor: AppConstants.buttoncolor,
                        activeColor: const Color.fromARGB(255, 34, 14, 179),
                        selectedColor: const Color.fromARGB(255, 34, 14, 179),
                        inactiveColor: Colors.grey,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: false,
                      onCompleted: (value) {
                        verifyOTP();
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter OTP';
                        } else if (value.length != 6) {
                          return 'OTP should be 6 digits';
                        }
                        return null;
                      },
                    ),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const CircularProgressIndicator(
                      color: Color.fromARGB(255, 34, 14, 179),
                    )
                  : ElevatedButton(
                      onPressed: verifyOTP,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.buttoncolor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(
                          color: AppConstants.buttontext,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Verify',
                        style: TextStyle(color: AppConstants.buttontext),
                      ),
                    ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  print(widget.phoneNumber);
                  await AuthService.resendOTP(
                    phone: widget.phoneNumber,
                    errorStep: () {
                      setState(() {
                        _isLoading = false;
                        _errorMessage = 'Error resending OTP';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Error resending OTP',
                            style: TextStyle(color: AppConstants.errorColor),
                          ),
                        ),
                      );
                    },
                    nextStep: (verifyId) {
                      setState(() {
                        _isLoading = false;
                      });

                      print('OTP resent successfully');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'OTP send successfully.',
                            style: TextStyle(color: AppConstants.successColor),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text(
                  'Resend OTP',
                  style: TextStyle(
                    color: AppConstants.textButtonColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

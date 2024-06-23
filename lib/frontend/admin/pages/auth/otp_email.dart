import 'package:animate_do/animate_do.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:lottie/lottie.dart';
import 'package:rafay_portfolio/frontend/admin/view/dashboard.dart';

class OtpEmailVerifyScreen extends StatefulWidget {
  const OtpEmailVerifyScreen({super.key, required this.myauth});
  final EmailOTP myauth;
  @override
  _OtpEmailVerifyScreenState createState() => _OtpEmailVerifyScreenState();
}

class _OtpEmailVerifyScreenState extends State<OtpEmailVerifyScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  String _code = '';

  int _currentIndex = 0;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex++;

        if (_currentIndex == 3) {
          _currentIndex = 0;
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                child: Lottie.asset("assets/animation/otp.json"),
              ),
              const SizedBox(
                height: 30,
              ),
              FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    "Verification",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 500),
                child: Text(
                  "Please enter the 4 digit code sent to \n Your Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 500),
                child: VerificationCode(
                  length: 4,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  underlineColor: Theme.of(context).colorScheme.inversePrimary,
                  keyboardType: TextInputType.number,
                  underlineUnfocusedColor:
                      Theme.of(context).colorScheme.primary,
                  onCompleted: (value) {
                    setState(() {
                      _code = value;
                    });
                  },
                  onEditing: (value) {},
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 50,
              ),
              FadeInDown(
                  delay: const Duration(milliseconds: 800),
                  duration: const Duration(milliseconds: 500),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (await widget.myauth.verifyOTP(otp: _code) == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          content: Text(
                            "OTP is verified",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          content: Text(
                            "Invalid OTP",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ));
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.orange),
                      minimumSize: WidgetStateProperty.all<Size>(
                          Size(MediaQuery.of(context).size.width * 0.2, 50)),
                      // Width 50
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                    ),
                    child: const Text(
                      "Verify",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

//Old code for stack images 

// child: Stack(
                //   children: [
                //     Positioned(
                //       top: 0,
                //       left: 0,
                //       right: 0,
                //       bottom: 0,
                //       child: AnimatedOpacity(
                //         opacity: _currentIndex == 0 ? 1 : 0,
                //         duration: const Duration(
                //           seconds: 1,
                //         ),
                //         curve: Curves.linear,
                //         child: Image.network(
                //           'https://ouch-cdn2.icons8.com/eza3-Rq5rqbcGs4EkHTolm43ZXQPGH_R4GugNLGJzuo/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNjk3/L2YzMDAzMWUzLTcz/MjYtNDg0ZS05MzA3/LTNkYmQ0ZGQ0ODhj/MS5zdmc.png',
                //         ),
                //       ),
                //     ),
                //     Positioned(
                //       top: 0,
                //       left: 0,
                //       right: 0,
                //       bottom: 0,
                //       child: AnimatedOpacity(
                //         opacity: _currentIndex == 1 ? 1 : 0,
                //         duration: const Duration(seconds: 1),
                //         curve: Curves.linear,
                //         child: Image.network(
                //           'https://ouch-cdn2.icons8.com/pi1hTsTcrgVklEBNOJe2TLKO2LhU6OlMoub6FCRCQ5M/rs:fit:784:666/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMzAv/MzA3NzBlMGUtZTgx/YS00MTZkLWI0ZTYt/NDU1MWEzNjk4MTlh/LnN2Zw.png',
                //         ),
                //       ),
                //     ),
                //     Positioned(
                //       top: 0,
                //       left: 0,
                //       right: 0,
                //       bottom: 0,
                //       child: AnimatedOpacity(
                //         opacity: _currentIndex == 2 ? 1 : 0,
                //         duration: const Duration(seconds: 1),
                //         curve: Curves.linear,
                //         child: Image.network(
                //           'https://ouch-cdn2.icons8.com/ElwUPINwMmnzk4s2_9O31AWJhH-eRHnP9z8rHUSS5JQ/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNzkw/Lzg2NDVlNDllLTcx/ZDItNDM1NC04YjM5/LWI0MjZkZWI4M2Zk/MS5zdmc.png',
                //         ),
                //       ),
                //     )
                //   ],
                // ),
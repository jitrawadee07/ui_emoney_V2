import 'package:flutter/material.dart';
import 'package:get/Get.dart';

import '../../../controller/otp_controller.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String identifier;
  final bool isEmail;

  const OtpVerificationScreen({
    super.key,
    required this.identifier,
    required this.isEmail,
  });

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController());

// Mask identifier (phone: +6684946xxxx, email: us***@gmail.com)
    String maskedIdentifier = isEmail
        ? (identifier.length >= 5
            ? '${identifier.substring(0, 2)}***${identifier.substring(identifier.indexOf('@'))}'
            : identifier)
        : (identifier.length >= 8
            ? '${identifier.substring(0, 8)}xxxx'
            : identifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
// Close button
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close, color: Colors.black),
              ),
            ),
// Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  const Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We have sent an OTP to $maskedIdentifier',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 32),
// OTP input fields
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 40,
                          child: TextField(
                            onChanged: (value) {
                              controller.updateOtp(index, value);
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              }
                              if (controller.otp.join().length == 6) {
                                controller.verifyOtp();
                              }
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: controller.isError.value
                                      ? Colors.red
                                      : const Color(0xFF92CA68),
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF92CA68)),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(fontSize: 24),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
// Error message
                  Obx(
                    () => controller.isError.value
                        ? const Text(
                            'The OTP is incorrect. Please try again.',
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 16),
// Referral code
                  const Text(
                    'Referral: we3f8',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
// Resend OTP
                  Obx(
                    () => Column(
                      children: [
                        Text(
                          'Didn’t receive the OTP? Try again in ${controller.resendSeconds} secs',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: controller.canResend.value
                              ? controller.resendOtp
                              : null,
                          child: Text(
                            'Resend OTP',
                            style: TextStyle(
                              fontSize: 14,
                              color: controller.canResend.value
                                  ? Colors.blue
                                  : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

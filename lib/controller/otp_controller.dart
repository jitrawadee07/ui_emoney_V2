import 'package:flutter/material.dart';
import 'package:get/Get.dart';

import '../screen/auth/common/create_pin_screen.dart';

class OtpController extends GetxController {
  var otp = List.filled(6, '').obs; // Stores 6-digit OTP
  var isError = false.obs; // Tracks if OTP is incorrect
  var resendSeconds = 59.obs; // Countdown timer for resend
  var canResend = false.obs; // Enables/disables resend button

  final String correctOtp = '123456'; // Hardcoded correct OTP for demo

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
  }

// Update OTP digit at specific index
  void updateOtp(int index, String value) {
    if (value.length <= 1) {
      otp[index] = value;
      otp.refresh();
    }
  }

// Verify OTP
  void verifyOtp() {
    String enteredOtp = otp.join();
    if (enteredOtp.length == 6 && enteredOtp == correctOtp) {
      isError.value = false;
      Get.to(() => const CreatePinScreen());
    } else {
      isError.value = true;
    }
  }

// Start countdown timer for resend
  void startResendTimer() {
    canResend.value = false;
    resendSeconds.value = 59;
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      resendSeconds.value--;
      if (resendSeconds.value <= 0) {
        canResend.value = true;
        return false;
      }
      return true;
    });
  }

// Resend OTP
  void resendOtp() {
    if (canResend.value) {
      otp.value = List.filled(6, '');
      isError.value = false;
      Get.snackbar('OTP', 'New OTP sent');
      startResendTimer();
    }
  }
}

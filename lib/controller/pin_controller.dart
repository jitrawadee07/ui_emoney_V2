import 'package:get/Get.dart';

class PinController extends GetxController {
  var pin = List.filled(6, '').obs; // Stores 6-digit PIN

// Add digit to PIN
  void addDigit(String digit) {
    int index = pin.indexWhere((element) => element.isEmpty);
    if (index != -1) {
      pin[index] = digit;
      pin.refresh();
      if (index == 5) {
// PIN complete
        Get.snackbar('Success', 'PIN created: ${pin.join()}');
// Navigate to next screen (e.g., home) when implemented
      }
    }
  }

// Delete last digit
  void deleteDigit() {
    int index = pin.lastIndexWhere((element) => element.isNotEmpty);
    if (index != -1) {
      pin[index] = '';
      pin.refresh();
    }
  }

// Clear PIN
  void clearPin() {
    pin.value = List.filled(6, '');
  }
}

import 'package:flutter/material.dart';
import 'package:get/Get.dart';

import '../../../controller/pin_controller.dart';

class CreatePinScreen extends StatelessWidget {
  const CreatePinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PinController controller = Get.put(PinController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              const Text(
                'Create a PIN code',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'For safety in use',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 32),
// PIN indicator circles
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.pin[index].isNotEmpty
                            ? const Color(0xFF92CA68)
                            : Colors.transparent,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),
// Forget PIN link
              GestureDetector(
                onTap: () {
                  Get.snackbar('PIN', 'Forget PIN tapped');
                },
                child: const Text(
                  'Forget PIN?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(flex: 1),
// Numeric keypad
              Expanded(
                flex: 2,
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
// Digits 1-9
                    for (int i = 1; i <= 9; i++)
                      _KeypadButton(
                        label: '$i',
                        onPressed: () => controller.addDigit('$i'),
                      ),
// Smiley (disabled)
                    _KeypadButton(
                      label: '😊',
                      onPressed: null,
                      disabled: true,
                    ),
// Digit 0
                    _KeypadButton(
                      label: '0',
                      onPressed: () => controller.addDigit('0'),
                    ),
// Delete
                    _KeypadButton(
                      label: 'X',
                      onPressed: controller.deleteDigit,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// Keypad button widget
class _KeypadButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool disabled;

  const _KeypadButton({
    required this.label,
    this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: disabled ? Colors.grey.shade200 : Colors.transparent,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 24,
              color: disabled ? Colors.grey : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

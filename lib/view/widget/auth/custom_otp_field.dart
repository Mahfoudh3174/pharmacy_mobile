import 'package:flutter/material.dart';
import 'package:ecommerce/core/constant/color.dart';

class CustomOtpField extends StatefulWidget {
  final int length;
  final Function(String) onChanged;
  final Function(String) onSubmit;
  final bool enabled;

  const CustomOtpField({
    Key? key,
    this.length = 6,
    required this.onChanged,
    required this.onSubmit,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  String otp = '';

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.length; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(String value, int index) {
    if (value.length == 1) {
      otp = '';
      for (int i = 0; i < controllers.length; i++) {
        otp += controllers[i].text;
      }
      widget.onChanged(otp);

      if (otp.length == widget.length) {
        widget.onSubmit(otp);
      } else if (index < widget.length - 1) {
        focusNodes[index + 1].requestFocus();
      }
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.length,
        (index) => Container(
          width: 45,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            enabled: widget.enabled,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.primary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.primary, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.lightGrey),
              ),
            ),
            onChanged: (value) => _onCodeChanged(value, index),
          ),
        ),
      ),
    );
  }
}

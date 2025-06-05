import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final Color color;
  const CustomIconButton({super.key,
    required this.onPressed,
    required this.icon ,
    required this.color ,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon:  Icon(icon, color: color),
      onPressed: onPressed,
    );
  }
}

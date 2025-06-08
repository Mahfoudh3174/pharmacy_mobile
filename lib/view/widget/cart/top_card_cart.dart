import 'package:ecommerce/core/constant/color.dart';

import 'package:flutter/material.dart';

class TopCardCart extends StatelessWidget {
  final String message ; 
  const TopCardCart({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.only(bottom: 5),
              margin: EdgeInsets.symmetric(horizontal: 20),
              // height: 20,
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColor.background, fontSize: 16)),
            ) ; 
  }
}
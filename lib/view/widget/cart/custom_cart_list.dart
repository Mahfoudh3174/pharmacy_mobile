
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/imageasset.dart';
import 'package:flutter/material.dart';

class CustomItemsCartList extends StatelessWidget {
  final String name ; 
  final String price  ; 
  final String count   ; 
  const CustomItemsCartList({super.key, required this.name, required this.price, required this.count , });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: [
        Expanded(
            flex: 2,
            child: Image.asset(
              Imageasset.logo,
              height: 90,
              fit: BoxFit.cover,
            )),
        Expanded(
            flex: 3,
            child: ListTile(
              title: Text(name, style: TextStyle(fontSize: 15)),
              subtitle: Text(price,
                  style:
                      TextStyle(color: AppColor.primary, fontSize: 17)),
            )),
        Expanded(
            child: Column(
          children: [
            SizedBox(
                height: 35,
                child: IconButton(onPressed: () {}, icon: Icon(Icons.add))),
            SizedBox(
                height: 30,
                child: Text(
                  count,
                  style: TextStyle(fontFamily: "sans"),
                )),
            SizedBox(
                height: 25,
                child: IconButton(onPressed: () {}, icon: Icon(Icons.remove)))
          ],
        ))
      ]),
    );
  }
}
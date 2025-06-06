
import 'package:ecommerce/controller/settings_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.put(SettingsController());
    return ListView(
      children: [
        Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(height: Get.width / 3, color: AppColor.primary),
              Positioned(
                  top: Get.width / 3.9,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[100],
                      child: Icon(
                        Icons.settings,
                        size: 50,
                        color: AppColor.primary,
                      ),
                    ),
                  )),
            ]),
        SizedBox(height: 100),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              ListTile(
                // onTap: () {},  
                trailing:  Switch(onChanged: (val){} ,value: true ),
                title: Text("Dark Mode"),
              ),
              ListTile(
                onTap: () {},
                trailing: Icon(Icons.location_on_outlined),
                title: Text("Address"),
              ),
              ListTile(
                onTap: () {},
                trailing: Icon(Icons.help_outline_rounded),
                title: Text("About us"),
              ),
              ListTile(
                onTap: () {},
                trailing: Icon(Icons.phone_callback_outlined),
                title: Text("Contact us"),
              ),
              ListTile(
                onTap: () {
                  controller.logout();
                },
                title: Text("Logout"),
                trailing: Icon(Icons.exit_to_app),
              ),
            ]),
          ),
        )
      ],
    );
  }
}
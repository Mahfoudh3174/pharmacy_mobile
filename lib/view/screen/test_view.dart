
import 'package:ecommerce/controller/test_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {

final TestController controller = Get.put(TestController());
@override
void initState() {
  super.initState();
  controller.getData();
}

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello, World!',
      style: TextStyle(fontSize: 24),
    );
  }
}
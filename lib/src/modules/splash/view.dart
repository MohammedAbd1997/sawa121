import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SplashPage extends StatefulWidget {

  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashLogic logic = Get.put(SplashLogic());

  @override
  void initState() {
    logic.delay();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            Image.asset("assets/images/logo.png"),
            const Spacer(),
            Image.asset("assets/images/image_developers.png"),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}

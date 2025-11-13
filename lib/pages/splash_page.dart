import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_comtroller.dart';
import '../route/route.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final authC = Get.put(AuthController());
  @override
  void initState() {
    super.initState();

    jumpToNextPage();
  }

  jumpToNextPage() {
    Future.delayed(Duration(seconds: 3), () {
      if (authC.user != null) {
        Get.toNamed(RoutePages.homePage);
      } else {
        Get.toNamed(RoutePages.loginPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/Checkmark.png',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 10),
          Center(child: Text("Taskify", style: TextStyle(fontSize: 28))),
        ],
      ),
    );
  }
}

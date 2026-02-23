import 'package:flutter/material.dart';
import 'package:newsapp/core/routes/PageRoutNames.dart';

import '../core/gen/assets.gen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, PageRouteNames.homeScreen);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Image.asset(Assets.images.lightSplash.keyName, fit: BoxFit.cover);
  }
}

import 'package:flutter/material.dart';

import '../core/gen/assets.gen.dart';
import '../core/themes/ColorPalette.dart';

class Customdrawer extends StatelessWidget {
   final void Function() onTap;
  const Customdrawer({super.key, required this.onTap,});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          color: ColorPalette.white,
          child: Center(
            child: Text("News App", style: textTheme.headlineSmall),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Assets.icons.homeIcn.svg(),
                SizedBox(width: 10),
                Text("Go To Home", style: textTheme.titleLarge),
              ],
            ),
          ),
        ),
        Divider(
          color: ColorPalette.white,
          indent: 10,
          endIndent: 10,
          thickness: 2,
        ), Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 8,
            children: [
              Assets.icons.themeIcn.svg(),
              Text("Theme", style: textTheme.titleLarge),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 8),
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.transparent,
            border: Border.all(color: ColorPalette.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dark", style: textTheme.titleLarge),
              Assets.icons.arrowDown.svg(),
            ],
          ),
        ),
        SizedBox(height: 20),
        Divider(
          color: ColorPalette.white,
          indent: 10,
          endIndent: 10,
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Assets.icons.languageIcn.svg(),
              SizedBox(width: 8),
              Text("Language", style: textTheme.titleLarge),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 8),
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.transparent,
            border: Border.all(color: ColorPalette.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("English", style: textTheme.titleLarge),
              Assets.icons.arrowDown.svg(),
            ],
          ),
        ),
      ],
    );
  }
}

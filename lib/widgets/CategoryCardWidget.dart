import 'package:flutter/material.dart';
import 'package:newsapp/models/Category_Data_Model.dart';

import '../core/gen/assets.gen.dart';
import '../core/themes/ColorPalette.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
class Categorycardwidget extends StatefulWidget {
  final CategoryDataModel categoryDataModel;
  final bool isLeft;
  final void Function(CategoryDataModel) onTap;
  const Categorycardwidget({
    super.key,
    required this.categoryDataModel,
    required this.isLeft, required this.onTap,
  });

  @override
  State<Categorycardwidget> createState() => _CategorycardwidgetState();
}

class _CategorycardwidgetState extends State<Categorycardwidget> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      alignment: widget.isLeft == true
          ? Alignment.centerRight
          : Alignment.centerLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            width: double.infinity,
            fit: BoxFit.cover,
            widget.categoryDataModel.image,
          ),
        ),
        Align(
          alignment: widget.isLeft==true?Alignment.centerRight:Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              spacing: 29,
              children: [
                Text(
                  widget.categoryDataModel.title,
                  style: textTheme.headlineMedium,
                ),
                Bounceable(
                  onTap:() {
                    widget.onTap(widget.categoryDataModel);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: ColorPalette.grey,
                      borderRadius: BorderRadius.circular(64),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("View All", style: textTheme.headlineSmall),
                        ),
                        CircleAvatar(
                          radius: 27,
                          backgroundColor: ColorPalette.white,
                          child: Assets.icons.arrowIcn.svg(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

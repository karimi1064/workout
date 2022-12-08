import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:workout/data/set_data.dart';

import '../../../core/constants/color_constants.dart';
import 'panel/set_details_panel.dart';
import 'set_details_body.dart';

class SetDetailsContent extends StatelessWidget {
  final SetData setData;
  final bool isReplace;

  const SetDetailsContent(
      {super.key, required this.setData, required this.isReplace});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: _createSlidingUpPanel(context),
    );
  }

  Widget _createSlidingUpPanel(BuildContext context) {
    return SlidingUpPanel(
      panel: SetDetailsPanel(setData: setData, isReplace: isReplace),
      body: SetDetailsBody(setData: setData),
      minHeight: MediaQuery
          .of(context)
          .size
          .height * 0.65,
      maxHeight: MediaQuery
          .of(context)
          .size
          .height * 0.87,
      isDraggable: true,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    );
  }
}
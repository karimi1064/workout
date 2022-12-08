import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/data/set_data.dart';
import 'package:workout/screens/set_details_screen/bloc/set_details_bloc.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/path_constants.dart';

class SetDetailsBody extends StatelessWidget {
  final SetData setData;

  const SetDetailsBody({super.key, required this.setData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: Stack(
        children: [
          _createImage(),
          _createBackButton(context),
        ],
      ),
    );
  }

  Widget _createImage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 100),
      child: const Image(
        image: AssetImage(PathConstants.set),
        fit: BoxFit.cover,
      ),
    );
  }
}

Widget _createBackButton(BuildContext context) {
  final bloc = BlocProvider.of<SetDetailsBloc>(context);
  return Positioned(
    left: 20,
    top: 14,
    child: SafeArea(
      child: BlocBuilder<SetDetailsBloc, SetDetailsState>(
        builder: (context, state) {
          return GestureDetector(
            child: const SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage(PathConstants.back),
              ),
            ),
            onTap: () {
              bloc.add(BackTappedEvent());
            },
          );
        },
      ),
    ),
  );
}

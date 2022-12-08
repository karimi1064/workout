import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/core/constants/data_constants.dart';
import 'package:workout/data/set_data.dart';
import 'package:workout/screens/common_widgets/app_text_field.dart';
import 'package:workout/screens/set_details_screen/bloc/set_details_bloc.dart';

import '../../../../core/constants/path_constants.dart';
import '../../../../core/constants/text_constants.dart';
import '../../../common_widgets/app_dropdown_button.dart';

class SetDetailsPanel extends StatefulWidget {
  final SetData setData;
  final bool isReplace;

  const SetDetailsPanel(
      {super.key, required this.setData, required this.isReplace});

  @override
  State<SetDetailsPanel> createState() => _SetDetailsPanelState();
}

class _SetDetailsPanelState extends State<SetDetailsPanel> {
  final TextEditingController _setNameEditingController =
      TextEditingController();
  final TextEditingController _setRepetitionsEditingController =
      TextEditingController();
  final TextEditingController _setWeightEditingController =
      TextEditingController();

  final exercises = DataConstants.exercises;
  int exerciseValue = 0;

  @override
  void initState() {
    _setNameEditingController.text = widget.setData.title ?? '';
    _setRepetitionsEditingController.text =
        (widget.setData.repetitions ?? 0).toString();
    _setWeightEditingController.text =
        (widget.setData.weight ?? 0.0).toString();
    super.initState();
  }

  @override
  void dispose() {
    _setNameEditingController.dispose();
    _setRepetitionsEditingController.dispose();
    _setWeightEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _createPanelData(context);
  }

  Widget _createPanelData(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        _createRectangle(),
        const SizedBox(height: 20),
        _createSetData(context),
      ],
    );
  }

  Widget _createRectangle() {
    return const Image(image: AssetImage(PathConstants.rectangle));
  }

  Widget _createSetData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            title: TextConstants.setName,
            placeholder: TextConstants.workoutNamePlaceholder,
            controller: _setNameEditingController,
            onTextChanged: () => onTextChanged(),
            errorText: TextConstants.workoutNameEmptyError,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(TextConstants.exercise),
          ),
          Container(
            height: 55,
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
            child: AppDropDownButton(
              value: exerciseValue,
              onChanged: (dynamic newValue) {
                setState(() => exerciseValue = newValue);
                onTextChanged();
              },
              dropdownMenuItemList: exercises
                  .map((e) => DropdownMenuItem(
                        value: e.value,
                        child: Text(e.title),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 15),
          AppTextField(
            title: TextConstants.repetitions,
            placeholder: TextConstants.repetitions,
            controller: _setRepetitionsEditingController,
            onTextChanged: () => onTextChanged(),
            errorText: '',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 15),
          AppTextField(
            title: TextConstants.weight,
            placeholder: TextConstants.weight,
            controller: _setWeightEditingController,
            onTextChanged: () => onTextChanged(),
            errorText: '',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
    );
  }

  void onTextChanged() {
    BlocProvider.of<SetDetailsBloc>(context).add(
      UpdateSetEvent(
          newSet: SetData(
            id: widget.setData.id,
            title: _setNameEditingController.text,
            repetitions:
                int.tryParse(_setRepetitionsEditingController.text) ?? 0,
            weight: double.tryParse(_setWeightEditingController.text) ?? 0.0,
            exercise: exercises[exerciseValue].title,
          ),
          isReplace: widget.isReplace),
    );
  }
}

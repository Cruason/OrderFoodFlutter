import 'package:flutter/material.dart';
import 'package:messanger/core/constants/constants.dart';

class CustomDropDown extends StatefulWidget {
  final ProfileColor color;
  final Function(ProfileColor) colorSelected;
  const CustomDropDown(this.color, {super.key, required this.colorSelected});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late ProfileColor selectedColor;
  @override
  void initState() {
    selectedColor = widget.color;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedColor,
      isDense: true,
      items: ProfileColor.values.map((color) {
        return DropdownMenuItem<ProfileColor>(
          value: color,
          child: Text(
            color.toString().substring(13),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedColor = value!;
          widget.colorSelected(selectedColor);
        });
      },
    );
  }
}

import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    required this.image,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String image;
  final String title;
  final String value;
  final String groupValue;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("change");
        onChanged(value);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged!,
          ),
          Image.asset(image,width: 30,height: 30,),

          SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }
}

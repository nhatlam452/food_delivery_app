import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

import '../util/colors.dart';
import '../util/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';


class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BigText(
        size: Dimension.font26,
        text: text,
        color: Colors.black,
      ),
      SizedBox(height: Dimension.height10),
      Row(
        children: [
          Wrap(
            children: List.generate(
                5,
                (index) => Icon(
                      Icons.star,
                      color: AppColors.mainColor,
                    )),
          ),
          SizedBox(
            width: Dimension.width10,
          ),
          SmallText(text: "4.5"),
          SizedBox(
            width: Dimension.width10,
          ),
          SmallText(text: "1287"),
          SizedBox(
            width: Dimension.width10,
          ),
          SmallText(text: "comment")
        ],
      ),
      SizedBox(
        height: Dimension.height20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndText(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1),
          IconAndText(
              icon: Icons.location_on,
              text: "1.7 km",
              iconColor: AppColors.mainColor),
          IconAndText(
              icon: Icons.access_time_rounded,
              text: "32 min",
              iconColor: AppColors.iconColor2)
        ],
      )
    ]);
  }
}

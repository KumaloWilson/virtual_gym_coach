import 'package:flutter/material.dart';
import 'package:virtual_gym_coach/global/global.dart';


class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/onboarding3.jpg'),
            fit: BoxFit.fitHeight
        ),
        color: Colors.black,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.65,
          left: MediaQuery.of(context).size.width * 0.07,
          right: MediaQuery.of(context).size.width * 0.07,
        ),
        child: Text(
          "Achieve a well-rounded approach to fitness with nutrition guidance and meal planning from our virtual gym coach. They'll provide expert advice, delicious recipes, and nutritional tips to fuel your body for optimal performance.",
          style: TextStyle(
              color: textColor,
              fontSize: MediaQuery.of(context).size.width * 0.045,
              fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

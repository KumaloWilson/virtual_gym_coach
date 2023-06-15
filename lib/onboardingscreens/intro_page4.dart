import 'package:flutter/material.dart';
import 'package:virtual_gym_coach/global/global.dart';

String introText = "Welcome to arti-eyes, an app for people with low vision, or blind-ness. Arti-eyes uses your camera to find objects, read text and detect bank notes.";
String nextTip = "Please swipe the screen to the left to go Next";

class IntroPage4 extends StatelessWidget {
  const IntroPage4({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/imgF.jpg'),
            fit: BoxFit.fitWidth
        ),
        color: Colors.black,
      ),
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.width*0.25,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "ALL SET!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width*0.07,
                    color: textColor,
                    fontWeight: FontWeight.bold

                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.width*0.4,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  introText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width*0.045,
                      color: textColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

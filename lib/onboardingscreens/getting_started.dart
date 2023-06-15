import 'package:flutter/material.dart';
import 'package:virtual_gym_coach/onboardingscreens/useronboarding_screen.dart';

import '../global/global.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key? key}) : super(key: key);

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height*0.03
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
                "images/imgE.jpg"
            ),
          fit: BoxFit.fitWidth
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Gym-Genie',
            style: TextStyle(
              color: Colors.blueAccent
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body:Stack(
          children: [
            Positioned(
                top: MediaQuery.of(context).size.height*0.03,
                left: 0,
                right: 0,
                child: const Text(
                  'Unlock Your Fitness Potential. Be Your Best Self.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.center,
                ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height*0.1,
              left: 0,
              right: 0,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const UserOnBoardingPage()
                        )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const StadiumBorder(),
                    side: BorderSide(
                        color: primaryColor,
                        width: 2
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
            ),
          ],
        ),

      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:virtual_gym_coach/global/global.dart';
import '../splashScreen/splash_screen.dart';
import 'intro_page1.dart';
import 'intro_page2.dart';
import 'intro_page3.dart';
import 'intro_page4.dart';
import 'intro_page5.dart';


class UserOnBoardingPage extends StatefulWidget {
  const UserOnBoardingPage({super.key});

  @override
  _UserOnBoardingPageState createState() => _UserOnBoardingPageState();
}



class _UserOnBoardingPageState extends State<UserOnBoardingPage> {
  final PageController _controller = PageController();


  bool onLastPage = false;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                if(index == 3)
                  {
                    onLastPage = true;
                  }
                else
                  {
                    onLastPage = false;
                  }
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
              IntroPage4(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      child: Text(
                          'Skip',
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold

                        ),

                      ),
                      onTap: (){
                          _controller.jumpToPage(3);
                      },
                  ),
                  SmoothPageIndicator(
                      controller: _controller,
                      count: 4,
                      effect:  ScaleEffect(
                        spacing:  5.0,
                        radius:  4.0,
                          dotColor:  Colors.white,
                          activeDotColor:  primaryColor,
                      ),
                  ),
                  if (onLastPage == true) GestureDetector(
                    child: Text(
                        'Done',
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold

                      ),
                    ),
                    onTap: () async{

                      final showSelectUserTypeAndOnBoardingScreenPrefs =await SharedPreferences.getInstance();
                      showSelectUserTypeAndOnBoardingScreenPrefs.setBool("ON_BOARDING", false);

                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
                    },
                  ) else GestureDetector(
                    child: Text('Next',
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold

                      ),

                    ),
                    onTap: (){
                       _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubicEmphasized);
                      },
                  )
                  ,
                ],
              )
          )
        ],
      ),
    );
  }
}

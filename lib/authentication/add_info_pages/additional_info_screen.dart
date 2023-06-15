import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_gym_coach/authentication/add_info_pages/age_selection.dart';
import 'package:virtual_gym_coach/authentication/add_info_pages/user_metrics.dart';
import 'package:virtual_gym_coach/authentication/add_info_pages/selectgender.dart';
import 'package:virtual_gym_coach/authentication/add_info_pages/selectgoal.dart';
import '../../global/global.dart';
import '../../splashScreen/splash_screen.dart';

class AdditionalUserInfoScreen extends StatefulWidget {
  const AdditionalUserInfoScreen({super.key});

  @override
  State<AdditionalUserInfoScreen> createState() => _AdditionalUserInfoScreenState();
}

class _AdditionalUserInfoScreenState extends State<AdditionalUserInfoScreen> {

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
              SelectGender(),
              AgeSelectionScreen(),
              UserMetrics(),
              SelectGoal(),

            ],
          ),
          Container(
              alignment: const Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 45,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2, color: primaryColor),
                      ),
                      child: Center(
                        child: Text(
                          onLastPage? 'Done' : 'Next',
                          style: TextStyle(
                              color: secColor,
                              fontWeight: FontWeight.bold

                          ),
                        ),
                      ),
                    ),
                    onTap: () async{

                      if(onLastPage == true){

                        if(selectedGoal == null){
                          Fluttertoast.showToast(msg: 'Please Select Your Goal');
                        }

                        else if(userGender == null || userAge == null || userHeight == null){
                          Fluttertoast.showToast(msg: 'Please Slide back to see missing details you did not provide');
                        }
                        else{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool('addInfor', true);


                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
                        }
                      }
                      else{
                        if(userGender == null && _controller.page == 0){
                          Fluttertoast.showToast(msg: 'Please Select Your Gender');
                        }

                        if(userAge == null && _controller.page == 1){
                          Fluttertoast.showToast(msg: 'Please Enter your Age');
                        }
                        if((userHeight == null || userWeight == null || bodyMassIndex == null) && _controller.page == 2){
                          Fluttertoast.showToast(msg: 'Please enter your body measurements');
                        }
                        if(selectedGoal == null && _controller.page == 3){
                          Fluttertoast.showToast(msg: 'Please select a user goal');
                        }
                        else{
                          _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubicEmphasized);
                        }

                      }
                    },
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}

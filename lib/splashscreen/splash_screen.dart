import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_gym_coach/assistant_methods/assistants.dart';
import 'package:virtual_gym_coach/authentication/add_info_pages/additional_info_screen.dart';
import 'package:virtual_gym_coach/mainscreen/mainscreen.dart';
import '../authentication/login_screen.dart';
import '../global/global.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  late double _loading_progressValue;
  late Timer _timer;

  void _updateProgress() {
    const oneSec = Duration(milliseconds: 600);
    _timer = Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _loading_progressValue += 0.1;
        if (_loading_progressValue.toStringAsFixed(1) == '1.0') {
          t.cancel();
          return;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the state object is disposed
    super.dispose();
  }

  void getUserMode() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isMaleMode = (prefs.getBool('male') ?? false);
    isFemaleMode = (prefs.getBool('female') ?? false);

    if(isMaleMode == true){
      userGender = UserGender.males;

      asUser = 'Male';
      print("THE CURRENT USER TYPE IS $userGender");
    }

    if(isFemaleMode == true){
      userGender = UserGender.females;

      asUser = 'Female';
      print("THE CURRENT USER TYPE IS $userGender");
    }

  }

  void getAdditionalDetailsStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAdditionalDetailsProvided = (prefs.getBool('addInfor') ?? false);

    if(isAdditionalDetailsProvided == true){
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement( context, MaterialPageRoute(builder: (c) => const MainScreen()));
    }
    else{
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement( context, MaterialPageRoute(builder: (c) => AdditionalUserInfoScreen()));
    }
  }



  startTimer() {

    Timer(const Duration(seconds: 6), () async {
      if (fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        AssistantMethod.readCurrentOnlinePassengerInfo();
        getAdditionalDetailsStatus();

      }
      else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
    _updateProgress();
  }


  void getUserAge() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userAge = prefs.getInt('age');
    });
  }

  void getUserGender() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isMaleMode = (prefs.getBool('male') ?? false);
    isFemaleMode = (prefs.getBool('female') ?? false);

    if(isMaleMode == true){
      setState(() {
        userGender = UserGender.males;
      });

    }

    if(isFemaleMode == true){
      setState(() {
        userGender = UserGender.females;
      });
    }

    if(isFemaleMode == false && isMaleMode == false){
      userGender = null;
      print("THE CURRENT USER TYPE IS $userGender");
    }
  }

  void getUserGoal() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFitMode = (prefs.getBool('getFit') ?? false);
    isFlexibleMode = (prefs.getBool('getFlexible') ?? false);
    isBodyBuildingMode = (prefs.getBool('bodyBuilding') ?? false);
    isLoseWeightMode = (prefs.getBool('loseWeight') ?? false);

    if(isFitMode == true){
      setState(() {
        selectedGoal = UserGoal.getFit;
      });
    }

    if(isFlexibleMode == true){
      setState(() {
        selectedGoal = UserGoal.getFlexible;
      });
    }

    if(isBodyBuildingMode == true){
      setState(() {
        selectedGoal = UserGoal.bodyBuilding;
      });
    }

    if(isLoseWeightMode == true){
      setState(() {
        selectedGoal = UserGoal.loseWeight;
      });
    }

    if(isLoseWeightMode == false && isBodyBuildingMode == false && isFlexibleMode == false && isFitMode == false){
      selectedGoal = null;
      print("THE CURRENT USER TYPE IS $selectedGoal");
    }
  }

  void getUserHeight() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userHeight = prefs.getInt('height');
    });
  }

  void getUserBMI() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bodyMassIndex = prefs.getDouble('BMI');
    });

  }

  void loadCompletedWorkoutSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      completedWorkoutSessions = prefs.getInt('completedWorkoutSessions') ?? 0;
    });
  }

  void loadTotalTravelledDistance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalTravelledDistance = prefs.getDouble('totalTravelledDistance') ?? 0;
    });
  }

  void getUserWeight() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userWeight = prefs.getInt('weight');
    });


  }

  Future<int> _loadCompletedExercises() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      completedExercises = prefs.getInt('completedExercises') ?? 0;
    });

    return completedExercises;
  }

  @override
  void initState() {
    super.initState();
    _loadCompletedExercises();
    getUserBMI();
    getUserHeight();
    getUserAge();
    getUserGender();
    getUserGoal();
    getUserWeight();
    loadCompletedWorkoutSessions();
    startTimer();
    _loading_progressValue = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                        "images/splash_screen2.jpg"
                      ),
              fit: BoxFit.cover
          ),
        ),
        child:Stack(
          children: [
            Positioned(
              bottom: MediaQuery.of(context).size.width * 0.3,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: LinearProgressIndicator(
                      color: primaryColor,
                      minHeight: 10,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      value: _loading_progressValue,
                    ),
                  ),
                  Text(
                    '${(_loading_progressValue * 100).round()}%',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}

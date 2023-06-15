import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_gym_coach/global/global.dart';

class SelectGoal extends StatefulWidget {
  const SelectGoal({Key? key}) : super(key: key);

  @override
  State<SelectGoal> createState() => _SelectGoalState();
}

class _SelectGoalState extends State<SelectGoal> {


  void setFlexibleUser() async{
    SharedPreferences signPrefs = await SharedPreferences.getInstance();
    signPrefs.setBool('getFlexible', true);
    signPrefs.setBool('getFit', false);
    signPrefs.setBool('loseWeight', false);
    signPrefs.setBool('bodyBuilding', false);

    getUserGoal();
  }

  void setFitUser() async{
    SharedPreferences signPrefs = await SharedPreferences.getInstance();
    signPrefs.setBool('getFlexible', false);
    signPrefs.setBool('getFit', true);
    signPrefs.setBool('loseWeight', false);
    signPrefs.setBool('bodyBuilding', false);

    getUserGoal();
  }
  void setLoseWeight() async{
    SharedPreferences signPrefs = await SharedPreferences.getInstance();
    signPrefs.setBool('getFlexible', false);
    signPrefs.setBool('getFit', false);
    signPrefs.setBool('loseWeight', true);
    signPrefs.setBool('bodyBuilding', false);

    getUserGoal();
  }

  void setBodyBuilding() async{
    SharedPreferences signPrefs = await SharedPreferences.getInstance();
    signPrefs.setBool('getFlexible', false);
    signPrefs.setBool('getFit', false);
    signPrefs.setBool('loseWeight', false);
    signPrefs.setBool('bodyBuilding', true);

    getUserGoal();
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

      print("THE CURRENT USER Goal IS $selectedGoal");

      proceedToSplashOnBoardingScreensIfUserModeIsSet();
    }

    if(isFlexibleMode == true){
      setState(() {
        selectedGoal = UserGoal.getFlexible;
      });

      print("THE CURRENT USER Goal IS $selectedGoal");

      proceedToSplashOnBoardingScreensIfUserModeIsSet();
    }

    if(isBodyBuildingMode == true){
      setState(() {
        selectedGoal = UserGoal.bodyBuilding;
      });

      print("THE CURRENT USER Goal IS $selectedGoal");

      proceedToSplashOnBoardingScreensIfUserModeIsSet();
    }

    if(isLoseWeightMode == true){
      setState(() {
        selectedGoal = UserGoal.loseWeight;
      });

      print("THE CURRENT USER Goal IS $selectedGoal");

      proceedToSplashOnBoardingScreensIfUserModeIsSet();
    }

    if(isLoseWeightMode == false && isBodyBuildingMode == false && isFlexibleMode == false && isFitMode == false){
      selectedGoal = null;
      print("THE CURRENT USER TYPE IS $selectedGoal");
    }
  }

  void proceedToSplashOnBoardingScreensIfUserModeIsSet() async{
    print('ALL CLEAR NOW READY TO MOVE FORWARD THE USER Goal IS $selectedGoal');
  }



  @override
  void initState() {
    super.initState();

    getUserGoal();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/add_info_bg.jpg'),
            fit: BoxFit.fill
        ),
        color: Colors.black,
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text(
            'Choose your Goal',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width*0.1,
                color: textColor,
                fontWeight: FontWeight.bold

            ),
          ),
          Text(
            "Don't worry you can always change these later",
            style: TextStyle(
                color: secColor
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.05,
          ),

          Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setFlexibleUser();
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height*0.3,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage('images/add_info_bg.jpg'),
                                  fit: BoxFit.cover
                              ),
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: selectedGoal == UserGoal.getFlexible ?primaryColor : Colors.black,
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: Offset(5, 5),
                                ),
                                BoxShadow(
                                  color: selectedGoal == UserGoal.getFlexible ?primaryColor : Colors.black,
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: Offset(-5, -5),
                                )
                              ]
                          ),
                        child: isFemaleMode ? Image.asset('images/female_flexible.jpg') : Image.asset('images/male_flexible.jpg')
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setFitUser();
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height*0.3,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage('images/add_info_bg.jpg'),
                                  fit: BoxFit.cover
                              ),
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow:  [
                                BoxShadow(
                                  color: selectedGoal == UserGoal.getFit ?Colors.redAccent : Colors.black,
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: Offset(5, 5),
                                ),
                                BoxShadow(
                                  color: selectedGoal == UserGoal.getFit ?Colors.redAccent : Colors.black,
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: Offset(-5, -5),
                                )
                              ]
                          ),
                          child: isFemaleMode ? Image.asset('images/female_getfit.jpg') : Image.asset('images/male_getfit.jpg')
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setLoseWeight();
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height*0.3,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage('images/add_info_bg.jpg'),
                                  fit: BoxFit.cover
                              ),
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow:  [
                                BoxShadow(
                                  color: selectedGoal == UserGoal.loseWeight ?Colors.green : Colors.black,
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: Offset(5, 5),
                                ),
                                BoxShadow(
                                  color: selectedGoal == UserGoal.loseWeight ?Colors.green : Colors.black,
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: Offset(-5, -5),
                                )
                              ]
                          ),
                          child: isFemaleMode ? Image.asset('images/female_Weight.jpg') : Image.asset('images/male_Weight.jpg')
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setBodyBuilding();
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height*0.3,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage('images/add_info_bg.jpg'),
                                  fit: BoxFit.cover
                              ),
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: isMaleMode ? (selectedGoal == UserGoal.bodyBuilding ?Colors.amber : Colors.black) : (selectedGoal == UserGoal.bodyBuilding ?Colors.purpleAccent : Colors.black),
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: Offset(5, 5),
                                ),
                                BoxShadow(
                                  color: isMaleMode ? (selectedGoal == UserGoal.bodyBuilding ?Colors.amber : Colors.black) : (selectedGoal == UserGoal.bodyBuilding ?Colors.purpleAccent : Colors.black),
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: Offset(-5, -5),
                                )
                              ]
                          ),
                          child: isFemaleMode ? Image.asset('images/female_body_bulding.jpg',) : Image.asset('images/male_body_bulding.jpg',)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

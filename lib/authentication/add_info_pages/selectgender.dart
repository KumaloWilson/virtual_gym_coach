import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_gym_coach/global/global.dart';

String introText = "To give you a better experience and results we need to know your gender";

class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {


  void setMaleUser() async{
    SharedPreferences signPrefs = await SharedPreferences.getInstance();
    signPrefs.setBool('male', true);
    signPrefs.setBool('female', false);

    getUserGender();
  }

  void setFemale() async{
    SharedPreferences signPrefs = await SharedPreferences.getInstance();
    signPrefs.setBool('female', true);
    signPrefs.setBool('male', false);

    getUserGender();
  }

  void getUserGender() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isMaleMode = (prefs.getBool('male') ?? false);
    isFemaleMode = (prefs.getBool('female') ?? false);

    if(isMaleMode == true){
      setState(() {
        userGender = UserGender.males;
      });

      print("THE CURRENT USER TYPE IS $userGender");

      proceedToSplashOnBoardingScreensIfUserModeIsSet();
    }

    if(isFemaleMode == true){
      setState(() {
        userGender = UserGender.females;
      });

      print("THE CURRENT USER TYPE IS $userGender");

      proceedToSplashOnBoardingScreensIfUserModeIsSet();
    }

    if(isFemaleMode == false && isMaleMode == false){
      userGender = null;
      print("THE CURRENT USER TYPE IS $userGender");
    }
  }

  void proceedToSplashOnBoardingScreensIfUserModeIsSet() async{
    print('ALL CLEAR NOW READY TO MOVE FORWARD THE USERGENDER IS $userGender');
  }



  @override
  void initState() {
    super.initState();

    getUserGender();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/add_info_bg.jpg'),
            fit: BoxFit.fill
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
                "Tell Us About Yourself",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width*0.1,
                    color: textColor,
                    fontWeight: FontWeight.bold

                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      setMaleUser();
                    });
                  },
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.width*0.3,

                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('images/selectmale.jpg'),
                              fit: BoxFit.fill
                          ),
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 2,
                              blurRadius: 15,
                              offset: Offset(5, 5),
                            ),
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 2,
                              blurRadius: 15,
                              offset: Offset(-5, -5),
                            )
                          ]
                      ),
                      child: Center(
                          child: userGender == UserGender.males ? Icon(Icons.male, color: primaryColor, size: 100,) : null
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setFemale();
                  },

                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.width*0.3,

                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('images/selectfemale.jpg'),
                              fit: BoxFit.fill
                          ),
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 2,
                              blurRadius: 15,
                              offset: Offset(5, 5),
                            ),
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 2,
                              blurRadius: 15,
                              offset: Offset(-5, -5),
                            )
                          ]
                      ),
                      child: Center(
                        child: userGender == UserGender.females ? Icon(Icons.female, color: primaryColor, size: 100,) : null
                      ),
                    ),
                  ),
                ),

              ],
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

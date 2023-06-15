import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_gym_coach/global/global.dart';

String introText = "Age in years. this will help us to personalize an exercise program plan that suits you.";

class AgeSelectionScreen extends StatefulWidget {
  const AgeSelectionScreen({super.key});

  @override
  State<AgeSelectionScreen> createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {


  void setUserAge() async{
    SharedPreferences signPrefs = await SharedPreferences.getInstance();
    signPrefs.setInt('age', selectedAge!);

    getUserAge();
  }

  void getUserAge() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userAge = prefs.getInt('age');
    });


    if(userAge != null){

      print("THE CURRENT USER AGE IS $userAge");

      proceedToSplashOnBoardingScreensIfUserModeIsSet();
    }

  }

  void proceedToSplashOnBoardingScreensIfUserModeIsSet() async{
    print('ALL CLEAR NOW READY TO MOVE FORWARD THE CURRENT USER AGE IS $userAge');
  }


  int? selectedAge;

  void _showAgeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
      backgroundColor: Colors.black,
      title: Center(child: Text('Select Age', style: TextStyle(color: secColor),)),
      content: Container(
        height: 300,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('images/add_info_bg.jpg'),
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
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 100,
          itemBuilder: (context, index) {
            final age = index + 1;
            return ListTile(
              title: Center(
                child: Text(
                  age.toString(),
                  style: TextStyle(fontSize: 30.0, color: Colors.white), // Set the font color to white
                ),
              ),
              onTap: () {
                setState(() {
                  selectedAge = age;
                  setUserAge();
                });
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    ),
    );
  }


  @override
  void initState() {
    super.initState();

    getUserAge();
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
                "How Old Are You?",
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
            child: Center(
              child: GestureDetector(
                onTap: _showAgeDialog,
                child:  Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  width: MediaQuery.of(context).size.width*0.6,

                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('images/add_info_bg.jpg'),
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
                    child: Text(
                      userAge != null ? userAge.toString() : 'Tap\nTo\nSelect Age',
                      style: TextStyle(
                        fontSize: userAge != null ? MediaQuery.of(context).size.width*0.3 : MediaQuery.of(context).size.width*0.08,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
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

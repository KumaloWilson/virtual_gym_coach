import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_gym_coach/global/global.dart';

class UserMetrics extends StatefulWidget {
  const UserMetrics({Key? key}) : super(key: key);

  @override
  State<UserMetrics> createState() => _UserMetricsState();
}

class _UserMetricsState extends State<UserMetrics> {

  int? selectedHeight;
  int? selectedWeight;
  bool _isObese = false;

  double? _bmi;


  void setUserHeight() async{
    SharedPreferences signPrefs = await SharedPreferences.getInstance();
    signPrefs.setInt('height', selectedHeight!);

    getUserHeight();
  }

  void getUserHeight() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userHeight = prefs.getInt('height');
    });


    if(userHeight != null){

      print("THE CURRENT USER Height IS $userHeight");

      proceedToSplashOnBoardingScreensIfUserModeIsSet();
    }

  }

  void proceedToSplashOnBoardingScreensIfUserModeIsSet() async{
    print('ALL CLEAR NOW READY TO MOVE FORWARD THE CURRENT USER Height IS $userHeight');

    print('ALL CLEAR NOW READY TO MOVE FORWARD THE CURRENT USER Weight IS $userWeight');
    print('ALL CLEAR NOW READY TO MOVE FORWARD THE CURRENT USER BMI IS $bodyMassIndex');
  }

  void setUserWeight() async{
    SharedPreferences signPrefs = await SharedPreferences.getInstance();
    signPrefs.setInt('weight', selectedWeight!);

    getUserWeight();
  }

  void getUserWeight() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userWeight = prefs.getInt('weight');
    });


    if(userWeight != null){

      print("THE CURRENT USER Weight IS $userWeight");

      proceedToSplashOnBoardingScreensIfUserModeIsSet();
    }

  }



  void _showHeightDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Center(child: Text('Select Height', style: TextStyle(color: secColor),)),
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
            itemCount: 250,
            itemBuilder: (context, index) {
              final height = (index+80) + 1;
              return ListTile(
                title: Center(
                  child: Text(
                    height.toString(),
                    style: const TextStyle(fontSize: 30.0, color: Colors.white), // Set the font color to white
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedHeight = height;
                    setUserHeight();
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

  void _showWeightDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Center(child: Text('Select Weight', style: TextStyle(color: secColor),)),
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
            itemCount: 300,
            itemBuilder: (context, index) {
              final weight = (index+20) + 1;
              return ListTile(
                title: Center(
                  child: Text(
                    weight.toString(),
                    style: const TextStyle(fontSize: 30.0, color: Colors.white), // Set the font color to white
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedWeight = weight;
                    setUserWeight();
                    _calculateBMI(userWeight!, userHeight! );
                    setUserBMI();
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

  void _calculateBMI(int weight, int height) {
    if (weight > 0 && height > 0) {
      double heightInMeters = (height / 100).toDouble();
      double bmi = (weight / (heightInMeters * heightInMeters)).toDouble();
      setState(() {
        _bmi = bmi;
        setState(() {
          _isObese = bmi >= 31;
        });
      });
    }
    else{
      print('null');
    }
  }

  void setUserBMI() async{
    SharedPreferences signPrefs = await SharedPreferences.getInstance();
    if(userWeight != null && userHeight != null){
      signPrefs.setDouble('BMI', _bmi!);
    }


    getUserBMI();
  }

  void getUserBMI() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bodyMassIndex = prefs.getDouble('BMI');
    });


    if(bodyMassIndex != null){

      print("THE CURRENT USER Weight IS $bodyMassIndex");

      proceedToSplashOnBoardingScreensIfUserModeIsSet();
    }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserHeight();
    getUserWeight();
    getUserBMI();
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
            'User Metrics',
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
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Center(
            child: GestureDetector(
              onTap: _showHeightDialog,
              child:  Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                height: MediaQuery.of(context).size.height*0.1,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('images/add_info_bg.jpg'),
                        fit: BoxFit.cover
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                     'Height',
                      style: TextStyle(
                          color: secColor,
                          fontSize: MediaQuery.of(context).size.width*0.05,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      userHeight == null ?'-- CMs' : '$userHeight CMs',
                      style: TextStyle(
                        color: secColor,
                        fontSize: MediaQuery.of(context).size.width*0.05
                      ),
                    )
                  ],
                )
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Center(
            child: GestureDetector(
              onTap: _showWeightDialog,
              child:  Container(
                  height: MediaQuery.of(context).size.height*0.1,
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('images/add_info_bg.jpg'),
                          fit: BoxFit.cover
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Weight',
                        style: TextStyle(
                            color: secColor,
                            fontSize: MediaQuery.of(context).size.width*0.05,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        userWeight == null ? '--  KGs' : '$userWeight KGs',
                        style: TextStyle(
                            color: secColor,
                            fontSize: MediaQuery.of(context).size.width*0.05
                        ),
                      )
                    ],
                  )
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Center(
            child: Container(
                height: _isObese ? MediaQuery.of(context).size.height*0.38 : MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('images/add_info_bg.jpg'),
                        fit: BoxFit.cover
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
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                        child: Text(
                         'Body Mass Index',
                          style: TextStyle(
                            color: secColor,
                              fontSize: MediaQuery.of(context).size.width*0.05,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height*0.2,
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage('images/add_info_bg.jpg'),
                                  fit: BoxFit.cover
                              ),
                              color: Colors.grey.shade900,
                              shape: BoxShape.circle,
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
                            bodyMassIndex == null ?'- -': bodyMassIndex!.toStringAsFixed(2),
                            style: TextStyle(
                              color: secColor,
                              fontSize: MediaQuery.of(context).size.width*0.1,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      if(_isObese)Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
                        child: Text(
                          'TIP : Please Note that you have a high BMI and this means that you are obese\nRECOMMENDED: Make sure you choose lose Weight as your Goal',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: MediaQuery.of(context).size.width*0.025,
                              fontWeight: FontWeight.w300
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}

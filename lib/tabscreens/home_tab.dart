import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/global.dart';
import '../mainscreen/jog_screen.dart';
import '../mainscreen/motivationalquotes.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);


  @override
  State<HomeTab> createState() => _HomeTabState();
}


class _HomeTabState extends State<HomeTab> {

  void loadTotalTravelledDistance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalTravelledDistance = prefs.getDouble('totalTravelledDistance') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();

    loadTotalTravelledDistance();
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/add_info_bg.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
            ),
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.26,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: userGender == UserGender.males
                          ? const AssetImage('images/male_profile_background.jpg')
                          : const AssetImage('images/female_profile_background.jpg'),
                      fit: BoxFit.fill,
                    ),
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(20),
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight* 0.01,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: screenWidth * 0.02,
                          child: Container(
                            width: screenHeight * 0.12,
                            height: screenHeight * 0.12,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.fitness_center,
                                  size: 30,
                                  color: Colors.purple,
                                ),
                                Text(
                                  '$userWeight KGs',
                                  style: TextStyle(
                                    color: secColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: screenWidth * 0.3,
                          child: Container(
                            width: screenHeight * 0.12,
                            height: screenHeight * 0.12,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.height,
                                  size: 30,
                                  color: Colors.green,
                                ),
                                Text(
                                  '$userHeight CMs',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: secColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: screenWidth * 0.16,
                          child: Container(
                            width: screenHeight * 0.12,
                            height: screenHeight * 0.12,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calculate,
                                  size: 30,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  bodyMassIndex!.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: secColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Container(
                  height: screenWidth * 0.20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 3, color: primaryColor),
                    image: const DecorationImage(
                      image: AssetImage('images/active_days.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.01),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: screenWidth * 0.05,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 3, color: primaryColor),
                            ),
                            child: Center(
                              child: Text(
                                '$activeDays',
                                style: TextStyle(
                                  color: secColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: screenWidth * 0.05,
                          child: Center(
                            child: Text(
                              'Days\nActive',
                              style: TextStyle(
                                color: secColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Container(
                  height: screenWidth * 0.20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 3, color: primaryColor),
                    image: const DecorationImage(
                      image: AssetImage('images/active_days.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.01),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: screenWidth * 0.05,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 3, color: primaryColor),
                            ),
                            child: Center(
                              child: Text(
                                '$completedWorkoutSessions',
                                style: TextStyle(
                                  color: secColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: screenWidth * 0.05,
                          child: Center(
                            child: Text(
                              'Completed\nWorkOuts',
                              style: TextStyle(
                                color: secColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c)=> JogScreen()));
                      },
                      child: Container(
                        height: screenHeight * 0.25,
                        width: screenWidth * 0.425,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: userGender == UserGender.males
                                ? const AssetImage('images/male_running_official.jpg')
                                : const AssetImage('images/female_running_official.jpg'),
                            fit: BoxFit.fill,
                          ),
                            color: Colors.grey.shade900,
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
                        child: Stack(
                          children: [
                            Positioned(
                              top: screenHeight * 0.01,
                              right: screenWidth * 0.01,
                              child: Center(
                                child: Text(
                                  'Jog\nTracker',
                                  style: TextStyle(
                                    color: secColor,
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: screenWidth * 0.01,
                              right: 0,
                              left: 0,
                              child: Center(
                                child: Text(
                                  '${totalTravelledDistance.toStringAsFixed(2)} Km',
                                  style: TextStyle(
                                    color: secColor,
                                    fontSize: screenWidth * 0.06,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.03,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c)=> QuoteScreen()));
                      },
                      child: Container(
                        height: screenHeight * 0.25,
                        width: screenWidth * 0.425,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),

                          image: const DecorationImage(
                            image: AssetImage('images/motivation.jpg'),
                            fit: BoxFit.fill,
                          ),
                            color: Colors.grey.shade900,
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
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

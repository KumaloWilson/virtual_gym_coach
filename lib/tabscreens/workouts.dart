import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:virtual_gym_coach/mainscreen/dummyexercisescreen.dart';
import 'package:virtual_gym_coach/mainscreen/photo_progress.dart';
import '../global/global.dart';
import '../mainscreen/view_archiements.dart';

class WorkOuts extends StatefulWidget {
  const WorkOuts({Key? key}) : super(key: key);

  @override
  State<WorkOuts> createState() => _WorkOutsState();
}

class _WorkOutsState extends State<WorkOuts> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
          image:  DecorationImage(
              image: AssetImage(
                  'images/add_info_bg.jpg'
              ),
              fit: BoxFit.fill
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenHeight * 0.015,
            ),
            child: Column(
              children: [

                SizedBox(
                  height: screenHeight * 0.009,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const GymCoachApp()));
                        },
                        child: Container(
                          height: screenHeight * 0.25,
                          width: screenWidth * 0.425,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('images/workout_bg.jpg'),
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
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProgressPhotoScreen()));
                        },
                        child: Container(
                          height: screenHeight * 0.25,
                          width: screenWidth * 0.425,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('images/progressphoto.jpg'),
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
                        ),
                      ),
                    ],
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                GestureDetector(
                  child: Container(
                    height: screenWidth * 0.20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 3, color: Colors.orangeAccent),
                      image: const DecorationImage(
                        image: AssetImage('images/calories burnt.jpg'),
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
                            child: Center(
                              child: Text(
                                '$totalBurntCalories Kcal',
                                style: TextStyle(
                                  color: secColor,
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.bold,
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
                                'Calories\nBurnt',
                                style: TextStyle(
                                  color: secColor,
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.009,
                ),
                GestureDetector(
                  child: Container(
                    height: screenWidth * 0.20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 3, color: Colors.green),
                      image: const DecorationImage(
                        image: AssetImage('images/distance_covered.jpg'),
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
                            child: Center(
                              child: Text(
                                '${totalTravelledDistance.toStringAsFixed(2)} Kms',
                                style: TextStyle(
                                  color: secColor,
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.bold,
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
                                'Distance\nCovered',
                                style: TextStyle(
                                  color: secColor,
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.025,
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const AchievementsScreen()));
                  },
                  child: Container(
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.425,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('images/achievements_bg.jpg'),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

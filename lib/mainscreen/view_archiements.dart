import 'package:flutter/material.dart';
import 'package:virtual_gym_coach/global/global.dart';

import '../models/achievement.dart';
import '../models/category.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  double? screenHeight;
  double? screenWidth;

  List<AchievementCategory> categories = [
    AchievementCategory(
      name: 'Workouts',
      achievements: [
        Achievement(
          name: '10',
          completed: completedWorkoutSessions >= 10,
        ),
        Achievement(
          name: '50',
          completed: completedWorkoutSessions >= 50,
        ),
        Achievement(
          name: '100',
          completed: completedWorkoutSessions >= 100,
        ),
        Achievement(
          name: '500',
          completed: completedWorkoutSessions >= 500,
        ),
        Achievement(
          name: '1 000',
          completed: completedWorkoutSessions >= 1000,
        ),
        Achievement(
          name: '5 000',
          completed: completedWorkoutSessions >= 5000,
        ),
        Achievement(
          name: '10 000',
          completed: completedWorkoutSessions >= 10000,
        ),
        Achievement(
          name: '25 000',
          completed: completedWorkoutSessions >= 25000,
        ),
        Achievement(
          name: '50 000',
          completed: completedWorkoutSessions >= 50000,
        ),
        Achievement(
          name: '75 000',
          completed: completedWorkoutSessions >= 75000,
        ),
        Achievement(
          name: '100 000',
          completed: completedWorkoutSessions >= 100000,
        ),
        Achievement(
          name: '250 000',
          completed: completedWorkoutSessions >= 250000,
        ),
        Achievement(
          name: '500 000',
          completed: completedWorkoutSessions >= 500000,
        ),
        Achievement(
          name: '1 000 000',
          completed: completedWorkoutSessions >= 1000000,
        ),
        Achievement(
          name: '2 500 000',
          completed: completedWorkoutSessions >= 2500000,
        ),
      ],
    ),
    AchievementCategory(
      name: 'Calories Burned',
      achievements: [
        Achievement(
          name: '500 Kcal',
          completed: totalBurntCalories >= 500,
        ),
        Achievement(
          name: '1 000 Kcal',
          completed: totalBurntCalories >= 1000,
        ),
        Achievement(
          name: '5 000 Kcal',
          completed: totalBurntCalories >= 5000,
        ),
        Achievement(
          name: '10 000 Kcal',
          completed: totalBurntCalories >= 10000,
        ),
        Achievement(
          name: '50 000 Kcal',
          completed: totalBurntCalories >= 50000,
        ),
        Achievement(
          name: '100 000 Kcal',
          completed: totalBurntCalories >= 100000,
        ),
        Achievement(
          name: '500 000 Kcal',
          completed: totalBurntCalories >= 500000,
        ),
        Achievement(
          name: '1 000 000 Kcal',
          completed: totalBurntCalories >= 1000000,
        ),
        Achievement(
          name: '5 000 000 Kcal',
          completed: totalBurntCalories >= 5000000,
        ),
        Achievement(
          name: '10 000 000 Kcal',
          completed: totalBurntCalories >= 10000000,
        ),
        Achievement(
          name: '50 000 000 Kcal',
          completed: totalBurntCalories >= 50000000,
        ),
        Achievement(
          name: '100 000 000 Kcal',
          completed: totalBurntCalories >= 100000000,
        ),
      ],
    ),
    AchievementCategory(
      name: 'Distance Traveled',
      achievements: [
        Achievement(
          name: '10 Kms',
          completed: totalTravelledDistance >= 10,
        ),
        Achievement(
          name: '25 Kms',
          completed: totalTravelledDistance >= 25,
        ),
        Achievement(
          name: '50 Kms',
          completed: totalTravelledDistance >= 50,
        ),
        Achievement(
          name: '100 Kms',
          completed: totalTravelledDistance >= 100,
        ),
        Achievement(
          name: '250 Kms',
          completed: totalTravelledDistance >= 250,
        ),
        Achievement(
          name: '500 Kms',
          completed: totalTravelledDistance >= 500,
        ),
        Achievement(
          name: '1 000 Kms',
          completed: totalTravelledDistance >= 1000,
        ),
        Achievement(
          name: '5 000 Kms',
          completed: totalTravelledDistance >= 5000,
        ),
        Achievement(
          name: '10 000 Kms',
          completed: totalTravelledDistance >= 10000,
        ),
        Achievement(
          name: '50 000 Kms',
          completed: totalTravelledDistance >= 50000,
        ),
        Achievement(
          name: '100 000 Kms',
          completed: totalTravelledDistance >= 100000,
        ),
        Achievement(
          name: '200 000 Kms',
          completed: totalTravelledDistance >= 200000,
        ),
        Achievement(
          name: '500 000 Kms',
          completed: totalTravelledDistance >= 500000,
        ),
      ],
    ),
    AchievementCategory(
      name: 'Steps',
      achievements: [
        Achievement(
          name: '10 000',
          completed: totalSteps >= 10000,
        ),
        Achievement(
          name: '50 000',
          completed: totalSteps >= 50000,
        ),
        Achievement(
          name: '100 000',
          completed: totalSteps >= 100000,
        ),
        Achievement(
          name: '250 000',
          completed: totalSteps >= 250000,
        ),
        Achievement(
          name: '500 000',
          completed: totalSteps >= 500000,
        ),
        Achievement(
          name: '1 000 000',
          completed: totalSteps >= 1000000,
        ),
        Achievement(
          name: '2 500 000',
          completed: totalSteps >= 2500000,
        ),
        Achievement(
          name: '5 000 000',
          completed: totalSteps >= 5000000,
        ),
        Achievement(
          name: '10 000 000',
          completed: totalSteps >= 10000000,
        ),
        Achievement(
          name: '25 000 000',
          completed: totalSteps >= 25000000,
        ),
        Achievement(
          name: '50 000 000',
          completed: totalSteps >= 50000000,
        ),
        Achievement(
          name: '100 000 000',
          completed: totalSteps >= 100000000,
        ),
      ],
    ),
    AchievementCategory(
      name: 'Days Active',
      achievements: [
        Achievement(
          name: '7 Days',
          completed: activeDays >= 7,
        ),
        Achievement(
          name: '14 Days',
          completed: activeDays >= 14,
        ),
        Achievement(
          name: '30 Days',
          completed: activeDays >= 30,
        ),
        Achievement(
          name: '60 Days',
          completed: activeDays >= 60,
        ),
        Achievement(
          name: '100 Days',
          completed: activeDays >= 100,
        ),
        Achievement(
          name: '250 Days',
          completed: activeDays >= 250,
        ),
        Achievement(
          name: '500 Days',
          completed: activeDays >= 500,
        ),
        Achievement(
          name: '750 Days',
          completed: activeDays >= 750,
        ),
        Achievement(
          name: '1000 Days',
          completed: activeDays >= 1000,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/add_info_bg.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Achievements',
            style: TextStyle(color: textColor),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  AchievementCategory category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          category.name,
                          style: TextStyle(
                            fontSize: screenWidth! * 0.06,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: screenHeight! * 0.16,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: category.achievements.length,
                            itemBuilder: (context, index) {
                              Achievement achievement =
                              category.achievements[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: screenWidth! * 0.3,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 3,
                                        color: achievement.completed
                                            ? primaryColor
                                            : secColor),
                                    image: DecorationImage(
                                      image: achievement.completed
                                          ? const AssetImage(
                                          'images/trophy.jpg')
                                          : const AssetImage(
                                          'images/non-trophy.jpg'),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    color: achievement.completed
                                        ? Colors.transparent
                                        : Colors.grey,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '\n\n\n\n${achievement.name}',
                                      style: TextStyle(
                                        color: achievement.completed
                                            ? primaryColor
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

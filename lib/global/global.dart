import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

enum UserGoal{getFit, loseWeight, getFlexible, bodyBuilding}
enum UserGender{males, females}
enum TtsState { playing, stopped, paused, continued }

String? asUser;
bool isAssistantActive = false;
int? userAge;
int? userHeight;
int? userWeight;
double? bodyMassIndex;
Color primaryColor = Colors.blue;
Color textColor = Colors.white;
Color secColor = Colors.white;
UserGoal? selectedGoal;
UserGender? userGender;
bool isAdditionalDetailsProvided = false;
final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
bool isMaleMode = false;
bool isFemaleMode = false;
String profilePictureURL = "";
bool isFitMode = false;
bool isFlexibleMode = false;
bool isLoseWeightMode = false;
bool isBodyBuildingMode = false;

double totalTravelledDistance = 0;
int totalBurntCalories = 0;
int completedWorkoutSessions = 0;
int activeDays = 0;
int totalSteps = 0;
int completedExercises = 0;

UserModel? userModelCurrentInfo;

String? name;
String? email;
String? profileImageUrl;
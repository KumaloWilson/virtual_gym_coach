import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_gym_coach/mainscreen/mainscreen.dart';
import 'package:virtual_gym_coach/tabscreens/workouts.dart';
import '../global/global.dart';
import '../models/exercises_model.dart';


class GymCoachApp extends StatefulWidget {
  const GymCoachApp({super.key});

  @override
  _GymCoachAppState createState() => _GymCoachAppState();
}
class _GymCoachAppState extends State<GymCoachApp> {
  List<Exercise> exercises = [];


  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;


  late Timer timer;
  int currentExerciseIndex = 0;
  int remainingTime = 0;
  bool isStartExercise = true;
  bool showStartButton = true;


  int currentCalories = 0;


  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        setState(() {
          print("TTS Initialized");
        });
      });
    }

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await flutterTts.speak(_newVoiceText!);
      }
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }


  @override
  void initState() {
    super.initState();
    initTts();

    // Load exercises and speak the description instantly
    loadExercises();
    speakExerciseDescription();
  }


  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalWorkouts', completedWorkoutSessions);
    await prefs.setInt('totalCalories', totalBurntCalories);
  }

  void _finishWorkout() {
    setState(() {
      completedWorkoutSessions++;
      totalBurntCalories += currentCalories;
      currentCalories = 0;
      _saveData();
    });
    _newVoiceText = 'Congratulations you have completed your workout session for the day. Please come again tomorrow';

    _speak();

    _stop();
    flutterTts.stop();
    showCongratulatoryDialog();
  }

  void showCongratulatoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              image: const DecorationImage(image: AssetImage('images/add_info_bg.jpg'), fit: BoxFit.fill),
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
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            title: Column(children: [
              Lottie.asset(
                  'workout_animations/trophy.json',
                  width: MediaQuery.of(context).size.height*0.2
              ),
              Text(
                'Congratulations!',
                style: TextStyle(
                  color: textColor
                ),
              ),
            ]
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'You have completed your Workout',
                  style: TextStyle(
                      color: textColor
                  ),
                ),
                const SizedBox(height: 10),
              Text(
                'Total completed workouts: $completedWorkoutSessions',
                style: TextStyle(
                    color: textColor
                ),
              ),
                const SizedBox(height: 10),
                Text(
                  'Calories burnt: $totalBurntCalories kcal',
                  style: TextStyle(
                      color: textColor
                  ),),
              ],
            ),
            actions: [
              Center(
                child: GestureDetector(
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 2,
                        color: primaryColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Okay',
                        style: TextStyle(
                          color: secColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context); // Close the dialog
                    navigateToHomeScreen();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void speakExerciseDescription() async {
    if (exercises.isNotEmpty) {
      setState(() {
        Exercise exercise = exercises[currentExerciseIndex];
        _newVoiceText = exercise.description.toString();

        _speak();
      });
    }
  }

  void loadExercises() async {
    String jsonData =
    await DefaultAssetBundle.of(context).loadString('dataset/exercises.json');
    Map<String, dynamic> exercisesMap = json.decode(jsonData);

    setState(() {
      exercises = (exercisesMap[selectedGoal.toString().split('.').last] as List)
          .map((exerciseJson) => Exercise.fromJson(exerciseJson, userGender!))
          .toList();
    });

    exercises.shuffle();
  }

  void startExercise() async {
    Exercise exercise = exercises[currentExerciseIndex];
    dynamic duration = exercise.duration;


    if (duration != null) {
      remainingTime = duration;
    }

    setState(() {
      remainingTime;
      isStartExercise = false;
      showStartButton = false;
      currentCalories += exercise.caloriesBurnt;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });

        if (remainingTime < 11) {
          flutterTts.speak(remainingTime.toString());
        }
      } else {
        timer.cancel();
        if (currentExerciseIndex < exercises.length - 1) {
          setState(() {
            currentExerciseIndex++;
            isStartExercise = true;
            showStartButton = true;

            speakExerciseDescription();
          });
        } else {
          setState(() {
            completedWorkoutSessions++;
            showStartButton = false;
          });
          saveCompletedWorkoutSessions();
        }
      }
    });

    if (currentExerciseIndex > 9) {
      _finishWorkout();
    }
  }

  void navigateToHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  void saveCompletedWorkoutSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('completedWorkoutSessions', completedWorkoutSessions);
  }

  void resetWorkoutSession() {
    setState(() {
      currentExerciseIndex = 0;
      remainingTime = 0;
      exercises.shuffle();
      showStartButton = true;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    _stop();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (exercises.isEmpty) {
      return Container();
    }

    Exercise exercise = exercises[currentExerciseIndex];
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
            padding: const EdgeInsets.symmetric(
              vertical: 35.0,
              horizontal: 20
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: screenHeight * 0.02
                ),
                Center(
                  child: Text(
                    exercise.name,
                    style: TextStyle(
                        fontSize: screenWidth*0.05,
                        fontWeight: FontWeight.bold,
                      color: textColor
                    ),
                  ),
                ),
                SizedBox(
                    height: screenHeight * 0.02
                ),

                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(image: AssetImage('images/add_info_bg.jpg'), fit: BoxFit.fill),
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
                  height: screenHeight * 0.3,
                  child: Lottie.asset(
                    exercise.animation,
                  ),
                ),
                SizedBox(
                    height: screenHeight * 0.1
                ),
                Text(
                  'Instruction',
                  style: TextStyle(
                      color: textColor,
                      fontSize: screenWidth*0.05,
                      fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  exercise.description,
                  style: TextStyle(
                    color: textColor,
                    fontSize: screenWidth*0.04,
                    fontWeight: FontWeight.w300
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: screenHeight * 0.02
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('images/add_info_bg.jpg'),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Lottie.asset('workout_animations/calories burnt.json', width: 30),
                            Text(
                              '${exercise.caloriesBurnt} kcal',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: screenWidth*0.05,
                                    fontWeight: FontWeight.w500
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (exercise.duration != null && exercise.count == null)
                      Container(
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('images/add_info_bg.jpg'),
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
                          padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 8),
                          child: Text(
                            'Time: $remainingTime secs',
                            style: TextStyle(
                                color: textColor,
                                fontSize: screenWidth*0.05,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    if (exercise.count != null && exercise.duration == null)
                      Container(
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('images/add_info_bg.jpg'),
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
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Count: ${exercise.count}',
                            style: TextStyle(
                                color: textColor,
                                fontSize: screenWidth*0.05,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                    height: screenHeight * 0.05
                ),
                if (showStartButton && (exercise.duration != null && exercise.count == null) )
                  GestureDetector(
                    onTap: startExercise,
                    child: Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 2,
                            color: primaryColor
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Start',
                          style: TextStyle(
                              color: secColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                if (showStartButton && (exercise.count != null && exercise.duration == null) )
                  GestureDetector(
                    onTap: startExercise,
                    child: Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 2,
                            color: primaryColor
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                              color: secColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

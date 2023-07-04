import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/global.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class JogScreen extends StatefulWidget {
  const JogScreen({Key? key}) : super(key: key);

  @override
  _JogScreenState createState() => _JogScreenState();
}

class _JogScreenState extends State<JogScreen> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';
  int currentSteps = 0;
  bool startJogging = false;
  bool useGPS = true; // Flag to indicate GPS usage

  double? initialLatitude;
  double? initialLongitude;

  double _distance = 0.0;
  double _stepLength = 0; // Average step length in meters
  final double _caloriesFactor = 0.9; // Calories factor per kilometer per kilogram

  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer(); // Audio player instance
  bool isMuted = false; // Flag to indicate if audio is muted or not
  bool isPaused = false; // Flag to indicate if audio is paused or not
  bool isShuffleOn = false; // Flag to indicate if shuffle is turned on or off

  double _burntCalories = 0.0;

  void setTotalTravelledDistance() async {
    SharedPreferences signPrefs = await SharedPreferences.getInstance();

    setState(() {
      totalTravelledDistance = totalTravelledDistance + (_distance / 1000);
      signPrefs.setDouble('totalTravelledDistance', totalTravelledDistance);
    });
  }

  void permissionRequest() async{
    // Check location permission
    if (!(await Permission.locationAlways.isGranted)) {
      await Permission.locationAlways.request();
    }

    // Check sensors permission
    if (!(await Permission.sensors.isGranted)) {
      await Permission.sensors.request();
    }

    // Check physical activity permission
    if (!(await Permission.activityRecognition.isGranted)) {
      await Permission.activityRecognition.request();
    }
  }

  void addTotalBurntCalories() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    totalBurntCalories = totalBurntCalories + (_burntCalories.round()).toInt();
    await prefs.setInt('totalCalories', totalBurntCalories);
  }
  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
      if (startJogging && !useGPS) {
        currentSteps++;

        if (userGender == UserGender.males) {
          if (userHeight! <= 160) {
            _stepLength = 0.7;
          } else if (userHeight! > 160 && userHeight! < 180) {
            _stepLength = 0.9;
          } else if (userHeight! > 180) {
            _stepLength = 1.1;
          }
        } else if (userGender == UserGender.females) {
          if (userHeight! <= 150) {
            _stepLength = 0.55;
          } else if (userHeight! > 150 && userHeight! < 165) {
            _stepLength = 0.7;
          } else if (userHeight! > 165) {
            _stepLength = 1.1;
          }
        }

        _distance = currentSteps * _stepLength;
      }
      else if(startJogging && useGPS){
        currentSteps++;
      }

      _burntCalories = (_distance / 1000) * userWeight!.toDouble() * _caloriesFactor;
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void onLocationChanged(Position position) {
    if (startJogging && useGPS && currentSteps > 0) {
      setState(() {
        _distance = Geolocator.distanceBetween(initialLatitude!, initialLongitude!, position.latitude, position.longitude);
      });
    }
  }

  Future<void> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        useGPS = false;
        print('=========================YOU DONT HAVE INTERNET ACCESS ==================================');
      });
    }
    else if(!(connectivityResult == ConnectivityResult.none)){
      print('=========================CONGRATS YOU HAVE INTERNET ACCESS ==================================');
    }
  }

  void initPlatformState() async {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    Position initialPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    initialLatitude = initialPosition.latitude;
    initialLongitude = initialPosition.longitude;

    Geolocator.getPositionStream().listen(onLocationChanged);

    if (!mounted) return;

    if (useGPS) {
      print('THIS IS THE INITIAL POSITION {$initialLatitude , $initialLongitude}');
    }
  }

  @override
  void initState() {
    super.initState();
    permissionRequest();
    checkConnectivity(); // Check initial connectivity status
    initPlatformState();


// Initialize audio player
    _audioPlayer.open(
      Playlist(
        audios: [
          Audio('audio_assets/HAVE  A LITTLE TALK WITH JESUSAfrican Edition  Jehovah Shalom Acapella.mp3'),
          Audio('audio_assets/Musatisiye Tiri Tega  Firm Faith Music.mp3'),
          Audio('audio_assets/O_Where_Are_the_Reapers_-_SDA_Hymn_#_366(256k).mp3'),
          Audio('audio_assets/OFFICIAL VIDEO Im On My Way  Firm Faith.mp3'),
        ],
      ),
      autoStart: false,
      loopMode: LoopMode.playlist,
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose audio player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/add_info_bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenHeight * 0.35,
                height: screenHeight * 0.35,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('images/add_info_bg.jpg'),
                    fit: BoxFit.cover,
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
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.run_circle_outlined,
                      size: screenWidth * 0.15,
                      color: primaryColor,
                    ),
                    Text(
                      'Steps: $currentSteps\nDistance: ${_distance.toStringAsFixed(2)} m',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.06,
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('workout_animations/calories burnt.json', width: 30),
                        Text(
                          '${_burntCalories.toInt()} kcal',
                          style: TextStyle(
                              color: textColor,
                              fontSize: screenWidth*0.06,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              // Text(
              //   'Today Steps: $_steps',
              //   style: TextStyle(fontSize: 12, color: textColor),
              // ),

              if(startJogging == true)
                Center(
                child: Container(
                  alignment: const Alignment(0, 0.85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenHeight * 0.05,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('images/add_info_bg.jpg'),
                            fit: BoxFit.cover,
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
                          ],
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              isShuffleOn ? Icons.shuffle : Icons.repeat,
                              color: secColor,
                              size: screenHeight * 0.025,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isShuffleOn) {
                                  _audioPlayer; // Turn off shuffle
                                } else {
                                  _audioPlayer.shuffle; // Turn on shuffle
                                }
                                isShuffleOn = !isShuffleOn; // Toggle the shuffle state
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: screenHeight * 0.05,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('images/add_info_bg.jpg'),
                            fit: BoxFit.cover,
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
                          ],
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.skip_previous, color: secColor, size: screenHeight * 0.025),
                            onPressed: () {
                              _audioPlayer.previous(); // Play previous song
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: screenHeight * 0.08,
                        height: screenHeight * 0.08,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('images/add_info_bg.jpg'),
                            fit: BoxFit.cover,
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
                          ],
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(isPaused ? Icons.play_arrow : Icons.pause, color: secColor, size: screenHeight * 0.06,),
                            onPressed: () {
                              setState(() {
                                if (isPaused) {
                                  _audioPlayer.play(); // Resume playing the audio
                                } else {
                                  _audioPlayer.pause(); // Pause the audio
                                }
                                isPaused = !isPaused; // Toggle the pause state
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: screenHeight * 0.05,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('images/add_info_bg.jpg'),
                            fit: BoxFit.cover,
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
                          ],
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.skip_next, color: secColor, size: screenHeight * 0.025),
                            onPressed: () {
                              _audioPlayer.next(); // Play next song
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: screenHeight * 0.05,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('images/add_info_bg.jpg'),
                            fit: BoxFit.cover,
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
                          ],
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up, color: secColor, size: screenHeight * 0.025),
                            onPressed: () {
                              setState(() {
                                if (isMuted) {
                                  _audioPlayer.setVolume(1.0); // UnMute the audio
                                } else {
                                  _audioPlayer.setVolume(0.0); // Mute the audio
                                }
                                isMuted = !isMuted; // Toggle the mute state
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),

              GestureDetector(
                child: Container(
                  height: 45,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 2,
                      color: startJogging ? Colors.redAccent : primaryColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      startJogging ? 'Stop' : 'Start',
                      style: TextStyle(
                        color: secColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onTap: () async {
                  setState(() {
                    if (startJogging == false) {
                      startJogging = true;
                      _distance = 0;
                      _audioPlayer.play(); // Play music when jogging starts
                    } else {
                      startJogging = false;
                      _audioPlayer.pause(); // Pause music when jogging stops
                      setTotalTravelledDistance();
                      addTotalBurntCalories();
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
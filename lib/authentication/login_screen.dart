import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:virtual_gym_coach/authentication/signup_screen.dart';
import 'package:virtual_gym_coach/widgets/rounded_passwordfield.dart';
import 'package:virtual_gym_coach/widgets/roundend_input_field.dart';
import '../global/global.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/progress_dialog.dart';


class LoginScreen extends StatefulWidget
{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  String? errorMsg;


  validateForm()
  {
    if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "email address is not valid ");
    }

    else if(passwordTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password Field Cannot be empty!");
    }
    else
    {
      loginUserNow();
    }
  }

  loginUserNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Please wait...",);
        }
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim()
        ).catchError((error) async {
          errorMsg = error.toString();

          print("THIS IS THE EXCEPTION MESSAGE :  $errorMsg");

          Navigator.pop(context);

          if(errorMsg == '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.')
            {
              await Fluttertoast.showToast(msg: "Email account does not exist");
            }

          else if (errorMsg == "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.")
            {
              await Fluttertoast.showToast(msg: "Incorrect password");
            }

          else if(errorMsg == "[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.")
            {
              await Fluttertoast.showToast(msg: "Too Many Attempts \nYour account has been temporarily blocked. Please Contact Customer Service");
            }

          else if(errorMsg == "[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.")
            {
              await Fluttertoast.showToast(msg: "Please check your internet access");
            }

          else if(errorMsg == "[firebase_auth/invalid-email] The email address is badly formatted."){
            await Fluttertoast.showToast(msg: "The email address is badly formatted.");
          }
          else if(errorMsg == "[firebase_auth/unknown] com.google.firebase.FirebaseException: An internal error has occurred. [ Failed to connect to www.googleapis.com/172.217.170.202:443 ]")
          {
            await Fluttertoast.showToast(msg: "An internal Error has occurred. Please Try Again");
          }
        })
    ).user;

    if(firebaseUser != null) {
      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("users");
      driversRef.child(firebaseUser.uid).once().then((driverKey) {
        final snap = driverKey.snapshot;
        if (snap.value != null) {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        }
        else {
          Fluttertoast.showToast(msg: "Oops! email does not exist");
          fAuth.signOut();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        }
      });
    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Invalid email or password!!");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/login_bg.jpg"),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
                MediaQuery.of(context).size.height * 0.02
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.65,
                ),
                RoundedInputField(
                    hintText: 'Email',
                    icon: Icons.person,
                    onChanged: (value){
                      emailTextEditingController.text = value;
                    }
                ),
                RoundedPasswordField(
                    onChanged: (value){
                      passwordTextEditingController.text = value;
                    }
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                          ),
                          child: SvgPicture.asset(
                              'images/bxl-facebook-circle.svg',
                              semanticsLabel: 'Acme Logo'
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                          ),
                          child: SvgPicture.asset(
                              'images/bxl-google.svg',
                              semanticsLabel: 'Acme Logo'
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal:    5
                      ),
                      child: GestureDetector(
                        onTap: ()
                        {
                          validateForm();
                        },
                        child: Container(
                          color: Colors.black,
                          child: Center(
                            child: Container(
                              height: 42,
                              width: 100,
                              decoration: BoxDecoration(
                                color: secColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 2,
                                    blurRadius: 20,
                                    offset: Offset(3, 3),
                                  ),
                                  BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: Offset(-4, -4),
                                  )
                                ]
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.login_sharp)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Column(
                  children: [
                    GestureDetector(
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                              color: secColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        )
                    ),
                    GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (c)=> const SignUpScreen()));
                        },
                        child: Text(
                          "Don't have an Account? Register Here",
                          style: TextStyle(
                            color: secColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

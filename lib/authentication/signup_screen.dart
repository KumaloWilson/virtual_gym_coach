
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../global/global.dart';
import '../mainscreen/mainscreen.dart';
import '../widgets/progress_dialog.dart';
import '../widgets/rounded_passwordfield.dart';
import '../widgets/roundend_input_field.dart';
import 'add_info_pages/additional_info_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget
{
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
{
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  File? _imageFile;
  bool isLoading = false;
  String? userPhotoURL;

  Future<void>validateForm() async {
    if (nameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "name must be at least 3 letters long");
    } else if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "email address should contain '@'");
    } else if (phoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone Number is required.");
    }else if (_imageFile == null) {
      Fluttertoast.showToast(msg: "Please Upload a Profile Picture");
    } else if (passwordTextEditingController.text.length < 8) {
      Fluttertoast.showToast(
          msg: "password should contain at least 8 characters");
    } else {
      print("Before calling saveUserInfoNow()");
      await saveUserInfoNow();
      print("After calling saveUserInfoNow()");
    }

  }


  Future<void>saveUserInfoNow() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          message: "Please wait...",
        );
      },
    );

    try {
      final User? firebaseUser = (await fAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      ).catchError((error) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "ERROR: $error");
      })
      ).user;



      if (firebaseUser != null) {

        if (_imageFile != null) {
          profilePictureURL = await uploadProfilePicture(firebaseUser.uid);

          print('THIS IS THE PROFILE PICTURE URL: $profilePictureURL');
        }


        Map<String, dynamic> userMap = {
          "id": firebaseUser.uid,
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),
          "profilePicture": profilePictureURL.toString(),
        };
        DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
        usersRef.child(firebaseUser.uid).set(userMap);

        currentFirebaseUser = firebaseUser;
        Fluttertoast.showToast(msg: "Account has been created successfully");

        print("Before navigating to AdditionalUserInfoScreen");
        await Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => AdditionalUserInfoScreen()));
        print("After navigating to AdditionalUserInfoScreen");

      } else {
        Fluttertoast.showToast(
            msg: "Account creation unsuccessful. Please Retry!!");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "ERROR: $error");
    } finally {
      Navigator.pop(context);
    }
  }

  Future<String> uploadProfilePicture(String userID) async {
    try {
      if (_imageFile == null) {
        Fluttertoast.showToast(msg: "Please select an image");
        return "";
      }

      Reference storageRef = FirebaseStorage.instance.ref().child("userImages").child('$userID.jpg');
      await storageRef.putFile(_imageFile!);
      userPhotoURL = await storageRef.getDownloadURL();

      print('THIS IS THE USERPHOTO URL: $userPhotoURL');

      return userPhotoURL.toString();
    } catch (error) {
      Fluttertoast.showToast(msg: "Failed to upload profile picture");
      return "";
    }
  }


  Future<void> _getFromCamera() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
    _cropImage(pickedImage!.path);

    Navigator.of(context);

  }

  Future<void> _getFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    _cropImage(pickedImage!.path);

    Navigator.of(context);

  }

  Future<void> _showImageDialog() async {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: (){
                      _getFromCamera();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.camera,
                            color: secColor,
                            size: 50,
                          ),
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      _getFromGallery();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.image,
                            color: secColor,
                            size: 50,
                          ),
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
    );
  }



  Future<void> _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if(croppedImage != null){
      setState(() {
        _imageFile = File(croppedImage.path);
      });
    }
  }


  @override
  Widget build(BuildContext context)
  {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/signup_bg.jpg"),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.02,
                vertical: MediaQuery.of(context).size.height * 0.15
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    _showImageDialog();
                  },
                  child: CircleAvatar(
                    backgroundImage: _imageFile == null
                        ? null
                        : FileImage(_imageFile!),
                    radius: MediaQuery.of(context).size.height * 0.1,
                    child: _imageFile == null
                        ?Icon(Icons.camera_enhance,
                      size: MediaQuery.of(context).size.width *0.18,
                      color: Colors.black54,
                    )
                        : null,
                  ),
                ),


                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: [
                      Text(
                        'GYM GENIE',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: secColor
                        ),
                      ),
                      Text(
                        'Unleash Your Strength.\nEmbrace the Challenge',
                        style: TextStyle(
                          color: secColor
                        ),
                      )
                    ],
                  ),
                ),
                RoundedInputField(
                    hintText: 'Name',
                    icon: Icons.person,
                    onChanged: (value){
                      nameTextEditingController.text = value;
                    }
                ),


                RoundedInputField(
                    hintText: 'Email Address',
                    icon: Icons.person,
                    onChanged: (value){
                      emailTextEditingController.text = value;
                    }
                ),

                RoundedInputField(
                    hintText: 'Phone Number',
                    icon: Icons.person,
                    onChanged: (value){
                      phoneTextEditingController.text = value;
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
                                      'SignUp',
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
                GestureDetector(
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const LoginScreen()));
                    },
                    child: Text(
                      "Already have an Account? Login Here",
                      style: TextStyle(
                          color: secColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    )
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

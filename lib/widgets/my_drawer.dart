import 'package:flutter/material.dart';
import '../global/global.dart';
import '../splashScreen/splash_screen.dart';


class MyDrawer extends StatelessWidget {
  String? name;
  String? email;
  String? profilePic;

  MyDrawer({super.key, this.name, this.email, this.profilePic});


  @override
  Widget build(BuildContext context) {    return Drawer(
      backgroundColor: Colors.grey,
      child: ListView(
        children: [
          //drawer header
          Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height * 0.32,
            child: DrawerHeader(
              decoration: const BoxDecoration(color:Colors.black),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.09,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        email.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          //History Button
          GestureDetector(
            onTap: ()
            {

            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.white,

              child: const Center(
                child: Text(
                  'History',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                  ),
                ),
              ),

            ),
          ),


          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),

          //Visit profile Button
          GestureDetector(
            onTap: ()
            {

            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.white,

              child: const Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                  ),
                ),
              ),

            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),

          //About Button
          GestureDetector(
            onTap: ()
            {

            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.white,

              child: const Center(
                child: Text(
                  'About',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                  ),
                ),
              ),

            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),

          //SignOut Button
          GestureDetector(
            onTap: ()
            {
              fAuth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.white,

              child: const Center(
                child: Text(
                  'SignOut',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20
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

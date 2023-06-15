import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_gym_coach/tabscreens/nutrition_tab.dart';
import 'package:virtual_gym_coach/tabscreens/settings.dart';
import 'package:virtual_gym_coach/tabscreens/workouts.dart';
import '../global/global.dart';
import '../tabscreens/home_tab.dart';
import '../tabscreens/progress.dart';
import '../widgets/my_drawer.dart';

class MainScreen extends StatefulWidget
{
  const MainScreen({super.key});


  @override
  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {

  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();

  TabController? tabController;
  int selectedIndex = 2;
  bool openNavigationDrawer = true;

  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      completedWorkoutSessions = prefs.getInt('totalWorkouts') ?? 0;
      totalBurntCalories = prefs.getInt('totalCalories') ?? 0;
    });
  }

  void calculateActiveDays() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastActiveDate = prefs.getString('lastActiveDate');

    if (lastActiveDate != null) {
      DateTime lastActive = DateFormat('yyyy-MM-dd').parse(lastActiveDate);
      DateTime today = DateTime.now();
      if (today.difference(lastActive).inDays > 0) {
        setState(() {
          activeDays++;
        });
      }
    }
    saveLastActiveDate();
  }

  void saveLastActiveDate() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    prefs.setString('lastActiveDate', today);
  }

  @override
  void initState() {
    super.initState();

    _loadData();
    calculateActiveDays();
    tabController = TabController(
        length: 5,
        vsync: this,
        initialIndex: 2
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: sKey,
      drawer: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.75,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
          ),
          child: MyDrawer(
            name: userModelCurrentInfo?.name,
            email: userModelCurrentInfo?.email,
            profilePic: userModelCurrentInfo?.profilePicURL,
          ),
        ),
      ),

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Gym Genie',
          style: TextStyle(
            color: secColor,
            fontSize: screenWidth * 0.06,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (openNavigationDrawer) {
              sKey.currentState!.openDrawer();
            } else {
              //restart the app programatically to update app stats
              SystemNavigator.pop();
            }
          },
          icon: Icon(
            Icons.menu,
            color: secColor,
            size: screenWidth * 0.09,
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black,
        color: Colors.blue,
        height: 65,
        items: const [
          // Tab 1 - Progress
          CurvedNavigationBarItem(
            child: Icon(
              Icons.people_outlined,
              color: Colors.white,
            ),
            label: 'Community',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          // Tab 2 - WorkOuts
          CurvedNavigationBarItem(
            child: Icon(
              Icons.sports_gymnastics,
              color: Colors.white,
            ),
            label: 'Workouts',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),

          //Tab 3 - Home
          CurvedNavigationBarItem(
            child: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),

          // Tab 4 - Nutrition
          CurvedNavigationBarItem(
            child: Icon(
              Icons.fastfood,
              color: Colors.white,
            ),
            label: 'Nutrition',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),

          // Tab 5 - Settings
          CurvedNavigationBarItem(
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            label: 'Settings',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
        onTap: onItemClicked,
        // Method to handle tab navigation
        index: selectedIndex,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children:  const [
          ProgressTracker(), // Widget for Progress tab
          WorkOuts(),
          HomeTab(), // Widget for Home tab
          NutritionTab(),
          SettingsTab(),
        ],
      ),
    );
  }
  }

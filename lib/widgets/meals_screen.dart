
import 'package:flutter/material.dart';
import 'package:virtual_gym_coach/global/global.dart';

import '../models/nutrition_data_model.dart';

class MealDetailsScreen extends StatelessWidget {
  final NutritionData data;

  const MealDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/add_info_bg.jpg'),
            fit: BoxFit.fill
        ),
        color: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(data.name, style: TextStyle(color: textColor)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight*0.05,),
                Image.asset(data.imageSource, width: screenWidth*0.7,),
                Text('Description', style: TextStyle(color: textColor,fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05), textAlign: TextAlign.center,),
                Text(data.description, style: TextStyle(color: textColor, fontSize: screenWidth * 0.05), textAlign: TextAlign.center,),
                SizedBox(height: screenHeight*0.05,),
                Text('Calories: ${data.calories} kcal', style: TextStyle(color: textColor), textAlign: TextAlign.center),
                Text('Protein: ${data.protein}g', style: TextStyle(color: textColor), textAlign: TextAlign.center),
                Text('Carbohydrates: ${data.carbohydrates}g', style: TextStyle(color: textColor), textAlign: TextAlign.center),
                Text('Fat: ${data.fat}g', style: TextStyle(color: textColor), textAlign: TextAlign.center),
                Text('Fiber: ${data.fiber}g', style: TextStyle(color: textColor), textAlign: TextAlign.center),
                Text('Serving Size: ${data.servingSize}', style: TextStyle(color: textColor), textAlign: TextAlign.center),
                // Add more attributes here as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}
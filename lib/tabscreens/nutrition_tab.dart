import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_gym_coach/global/global.dart';

import '../models/nutrition_data_model.dart';
import '../widgets/meals_screen.dart';

class NutritionTab extends StatefulWidget {
  const NutritionTab({Key? key}) : super(key: key);

  @override
  _NutritionTabState createState() => _NutritionTabState();
}

class _NutritionTabState extends State<NutritionTab> {
  final String _selectedGoal = selectedGoal.toString().split('.').last;
  List<NutritionData> _nutritionDataList = [];

  final List<String> _backgroundImages = [
    'images/tile_bg1.jpg',
    'images/tile_bg2.jpg',
    'images/tile_bg3.jpg',
    'images/tile_bg4.jpg',
    'images/tile_bg5.jpg',
    'images/tile_bg6.jpg',
    'images/tile_bg7.jpg',
    'images/tile_bg8.jpg',
    'images/tile_bg9.jpg',
    'images/tile_bg10.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _loadNutritionData();
  }

  Future<void> _loadNutritionData() async {
    String nutritionDataJson = await rootBundle.loadString('dataset/nutrition.json');
    List<dynamic> nutritionData = json.decode(nutritionDataJson);

    setState(() {
      _nutritionDataList = nutritionData.map((item) => NutritionData.fromJson(item)).toList();
    });
  }

  List<NutritionData> _getFilteredNutritionData() {
    return _nutritionDataList.where((data) => data.goal == _selectedGoal).toList();
  }

  void _onMealTap(NutritionData data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(data: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/nutrition_bg.jpg'),
            fit: BoxFit.fill
        ),
        color: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _getFilteredNutritionData().length,
                itemBuilder: (context, index) {
                  NutritionData data = _getFilteredNutritionData()[index];
                  String randomImage = _backgroundImages[Random().nextInt(_backgroundImages.length)];

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(randomImage),
                          fit: BoxFit.cover,
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
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(data.name, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                        subtitle: Text('Calories: ${data.calories}', style: TextStyle(color: textColor)),
                        trailing: Text('Protein: ${data.protein}g', style: TextStyle(color: textColor)),
                        onTap: () => _onMealTap(data),
                      ),
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



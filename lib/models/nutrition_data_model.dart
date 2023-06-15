
class NutritionData {
  final String name;
  final String goal;
  final int calories;
  final double protein;
  final int carbohydrates;
  final int fat;
  final int fiber;
  final String servingSize;
  final String description;
  final String imageSource;
  // Add more attributes here as needed

  NutritionData({
    required this.name,
    required this.goal,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
    required this.fiber,
    required this.servingSize,
    required this.description,
    required this.imageSource
    // Add more attributes here as needed
  });

  factory NutritionData.fromJson(Map<String, dynamic> json) {
    return NutritionData(
      name: json['name'],
      goal: json['goal'],
      calories: json['calories'],
      protein: json['protein'].toDouble(),
      carbohydrates: json['carbohydrates'],
      fat: json['fat'],
      fiber: json['fiber'],
      servingSize: json['servingSize'],
      description: json['description'],
      imageSource: json['image'],
      // Add more attributes here as needed
    );
  }
}
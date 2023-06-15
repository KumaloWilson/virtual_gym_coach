class Exercise {
  final String animation;
  final String name;
  final String description;
  final dynamic count;
  final dynamic duration;
  final int caloriesBurnt;

  Exercise({
    required this.animation,
    required this.name,
    required this.description,
    this.count,
    this.duration,
    required this.caloriesBurnt,
  });

  factory Exercise.fromJson(Map<String, dynamic> json, userGender) {
    return Exercise(
      animation: json['animation'],
      name: json['name'],
      description: json['description'],
      count: json['count'][userGender.toString().split('.').last],
      duration: json['duration'][userGender.toString().split('.').last],
      caloriesBurnt: json['calories_burnt'],
    );
  }
}

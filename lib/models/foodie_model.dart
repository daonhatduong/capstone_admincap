import 'package:cloud_firestore/cloud_firestore.dart';

class FoodieModel {
  String? id;
  String? name;
  List<String>? imageUrls;
  String? avatar;
  String? cookingTime;
  List<String> ingredients = [];
  List<String> steps = [];
  String? videoUrl;

  FoodieModel({
    this.id,
    this.name,
    this.imageUrls,
    this.avatar,
    this.cookingTime,
    this.ingredients = const [],
    this.videoUrl,
    this.steps = const [],
  });



  void addStepNumber(String stepNumber) {
    steps.add(stepNumber);
    stepNumber = steps.length.toString();
  }

  factory FoodieModel.fromSnapshot(DocumentSnapshot snapshot) {
    final _snapshot = snapshot.data() as Map<String, dynamic>?;

    if (_snapshot == null) {
      return FoodieModel();
    }

    return FoodieModel(
      id: snapshot.id,
      name: _snapshot['name'] ?? '',
      imageUrls: List<String>.from(_snapshot['imageUrls'] ?? []),
      avatar: _snapshot['avatar'] ?? '',
      cookingTime: _snapshot['cookingTime'] ?? '',
      ingredients: List<String>.from(_snapshot['ingredients'] ?? []),
      steps: List<String>.from(_snapshot['steps'] ?? []),
      videoUrl: _snapshot['videoUrl'] ?? '',
    );
  }
}

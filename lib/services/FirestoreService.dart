import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/foodie_model.dart';

class FirestoreService{
  final CollectionReference dishs = FirebaseFirestore.instance.collection("Dish");
  Future<void> addDish(
      String ingredient,
      String making, // step
      String nameDish,
      String totalTimeCooking){
    // làm sao để getkey trước khi push len firebase
    List<String> ingredients = [];
    ingredients.add(ingredient);

    List<String> makings= [];
    makings.add(making);


    FoodieModel foodieModel = new FoodieModel(
        name: nameDish,
        cookingTime:totalTimeCooking,
        ingredients:ingredients,
        steps: makings);
    return dishs.add(foodieModel.toJS);
  }
  Future<void> updateDish(String dishID,
      String ingredient,
      String making,
      String mameDish,
      String totalTimeCooking){
    return dishs.doc(dishID).update({
      "Ingredient": ingredient,
      "Making":making,
      "Name_Dish": mameDish,
      "TotalTimeCooking": totalTimeCooking
    });

  }
  Stream<QuerySnapshot> getDishStream(){
    final dishStream = dishs.orderBy("Name_Dish", descending: true).snapshots();
    return dishStream;
  }
  Future<void> deleteDish(String dishID){
      return dishs.doc(dishID).delete();
  }
}
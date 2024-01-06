import 'package:admincap/services/FirestoreService.dart';
import 'package:admincap/showToast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ValidDataOfDish.dart';

class PageDish extends StatefulWidget {
  const PageDish({Key? key}) : super(key: key);

  @override
  State<PageDish> createState() => _PageDishState();
}

class _PageDishState extends State<PageDish> {
  final FirestoreService firestoreService = FirestoreService();
  ValidDataOfDish validDataOfDish = new ValidDataOfDish();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController makingController = TextEditingController();
  TextEditingController nameDishController = TextEditingController();
  TextEditingController tooTimeCooking = TextEditingController();
  void openNotBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // tải ảnh lên firebase
            // giúp t chỗ này
            TextField(
              controller: ingredientController,
              decoration: InputDecoration(
                hintText: "Ingredient",
              ),
            ),
            TextField(
              controller: makingController,
              decoration: InputDecoration(
                hintText: "Making",
              ),
            ),
            TextField(
              controller: nameDishController,
              decoration: InputDecoration(
                hintText: "Name dish",
              ),
            ),
            TextField(
              controller: tooTimeCooking,
              decoration: InputDecoration(
                hintText: "Total time cooking ",
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docID == null) {
                firestoreService.addDish(
                  ingredientController.text,
                  makingController.text,
                  nameDishController.text,
                  tooTimeCooking.text,
                );
                // if(validDataOfDish.IsValidList(ingredientController.text)){
                //   if(validDataOfDish.IsValidList(makingController.text)){
                //
                //     print("ADD");
                //   }else{
                //     showToast(message: "Please Input the step is correct like: 1. step1 2. step2");
                //     return;
                //   }
                //
                // }else{
                //   showToast(message: "Please Input the ingredient is correct like: 1. Good1 2. Good2");
                //   return;
                // }
              } else {
                firestoreService.updateDish(
                  docID,
                  ingredientController.text,
                  makingController.text,
                  nameDishController.text,
                  tooTimeCooking.text,
                );
              }
              // Clear the text controllers after adding or updating
              ingredientController.clear();
              makingController.clear();
              nameDishController.clear();
              tooTimeCooking.clear();
              Navigator.pop(context);
            },
            child: Text('Add'),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DISH')),
      floatingActionButton: FloatingActionButton(
        onPressed: openNotBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getDishStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = notesList[index];
                String dishID = document.id;

                Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
                String nameDish = data['Name_Dish'];

                return ListTile(
                  title: Text(nameDish),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => openNotBox(docID: dishID),
                        icon: const Icon(Icons.settings),
                      ),
                      IconButton(
                        onPressed: () => firestoreService.deleteDish(dishID),
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const Text("No notes..");
          }
        },
      ),
    );
  }
}


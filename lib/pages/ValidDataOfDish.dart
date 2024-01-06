class ValidDataOfDish{
  bool IsValidList(String ingredient){
    RegExp regex = RegExp(r'\d+\.\s+\w+', caseSensitive: false);
    return regex.hasMatch(ingredient);
  }
  List<String> ValidList(String ingredient){
    List<String> splitIngredients = ingredient.split(RegExp(r'\b\d+\.\s*'))
        .where((element) => element.isNotEmpty)
        .map((e) => e.trim())
        .toList();
    return splitIngredients;
  }
}
import 'package:hive_flutter/hive_flutter.dart';

class TheListDatabase {

  List itemsList = [];
  List categoryList = [];

  // reference the box
  final _myBox = Hive.box('mybox');

  // load the data from database
  void loadData() {
    if (_myBox.isNotEmpty) {
      itemsList = _myBox.get('ITEMLIST');
      categoryList = _myBox.get('CATEGORYLIST');
    }
  }

  // update the database
  void updateDatabase () {
    _myBox.put('ITEMLIST', itemsList);
    _myBox.put('CATEGORYLIST', categoryList);
  }

}
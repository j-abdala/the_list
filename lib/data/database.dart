import 'package:hive_flutter/hive_flutter.dart';

class TheListDatabase {

  List itemsList = [];
  List categoryList = [];

  // reference the box
  final _myBox = Hive.box('mybox');

  // run this method if first time using the app
  // void createInitialItemsData() {
  //   itemsList = [
  //     ['Create an item', false],
  //     ['Delete this item', false],
  //     ['Archieve an item', false]
  //   ];
  // }

  // void createInitialCategoryData() {
  //   categoryList = [
  //     'TO DO', 
  //     'Maintenance',
  //     'Groceries'
  //   ];
  // }

  // load the data from database
  void loadData() {
    itemsList = _myBox.get('ITEMLIST');
    categoryList = _myBox.get('CATEGORYLIST');
  }

  // update the database
  void updateDatabase () {
    _myBox.put('ITEMLIST', itemsList);
    _myBox.put('CATEGORYLIST', categoryList);
  }

}
import 'package:hive_flutter/hive_flutter.dart';

class TheListDatabase {

  List itemsList = [];

  // reference the box
  final _myBox = Hive.box('mybox');

  // run this method if first time using the app
  void createInitialData() {
    itemsList = [
      ['Create an item', false],
      ['Delete this item', false],
      ['Archieve an item', false]
    ];
  }

  // load the data from database
  void loadData() {
    itemsList = _myBox.get('ITEMLIST');
  }

  // update the database
  void updateDatabase () {
    _myBox.put('ITEMLIST', itemsList);
  }

}
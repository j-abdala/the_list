import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:the_list/data/database.dart';
import 'package:the_list/utilities/dialog_box.dart';
import 'package:the_list/utilities/thelist_tile.dart';

class CategoriesPage extends StatefulWidget {
  final String categoryName;
  
  const CategoriesPage({
    super.key,
    required this.categoryName
    });

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _myBox = Hive.box('mybox');
  
  TheListDatabase db = TheListDatabase();

  List itemsInCategory = [];

  // text controller
  final _controller = TextEditingController();

  @override
  void initState() {
    db.loadData();
    checkItemsCategory();
    super.initState();
  }

  void checkItemsCategory() {
    print(db.itemsList);
    if (db.itemsList.isNotEmpty) {
      itemsInCategory = [];
        db.itemsList.forEach((element) {
          if (element[2] == widget.categoryName) {
            itemsInCategory.add(element);
          }
        });
      }
  }
  

  // save the new item 
  void saveNewItem() {
    setState(() {
      db.itemsList.add([_controller.text, false, widget.categoryName]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
    checkItemsCategory();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.itemsList[index][1] = !db.itemsList[index][1];
    });
    db.updateDatabase();
  }

  void createNewItem() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewItem,
          onCancel: () => Navigator.of(context).pop());
      }
    );
  }

  void deleteItem(int index) {
    setState(() {
      db.categoryList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(backgroundColor: Theme.of(context).primaryColorDark,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        centerTitle: true,
        title: Text(widget.categoryName, 
          style: Theme.of(context).textTheme.displaySmall
        ),
        elevation: 0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewItem,
        backgroundColor: Colors.amber[900],
        child: const Icon(Icons.add, color: Colors.white,)),
      body: db.itemsList.isEmpty ? Center(child: Text('Create a new items')) : ListView.builder(
        itemCount: itemsInCategory.length,
        itemBuilder: (context, index) {
          return TheListTile(
            itemName: itemsInCategory[index][0],
            itemCompleted: itemsInCategory[index][1],
            categoryName: itemsInCategory[index][2],
            onChanged: (value) => checkBoxChanged(value, index),
            archieveFunction: (context) => deleteItem(index),
          );
        }
      )
    );
  }
}
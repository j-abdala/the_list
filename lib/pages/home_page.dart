import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_list/data/database.dart';
import 'package:the_list/utilities/dialog_box.dart';
import 'package:the_list/utilities/thelistcategory_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');

  TheListDatabase db = TheListDatabase();

  @override
  void initState() {
    db.loadData();

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();
  
  // save new category
  void saveNewCategory() {
    if (_controller.text != "") {
      setState(() {
        db.categoryList.add([_controller.text, dropDownValue.getString()]);
        print(dropDownValue.getString());
        _controller.clear();
      });
      Navigator.of(context).pop();
      db.updateDatabase();
    }
  }

  // create new category
  void createNewCategory() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          labelName: 'Category',
          onSave: saveNewCategory,
          onCancel: () => {
            Navigator.of(context).pop(),
            _controller.clear()
          },
        );
      }
    );
  }

  void deleteCategory(int index, String iName) {
    List toRemove = [];
    setState(() {
      db.itemsList.forEach((element) {
        if (element[2] == db.categoryList[index]) {
          toRemove.add(element);
        }
      });
      db.categoryList.removeAt(index);
    });
    db.updateDatabase();
  }

  // TODO: add due dates for items

  // TODO: sharing function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          centerTitle: true,
          title: Text('The List', 
            style: Theme.of(context).textTheme.displaySmall
          ),
        elevation: 0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewCategory,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(Icons.add)),
      body: db.categoryList.isEmpty ? Center(child: Text('Create a new category')) : ListView.builder(
        itemCount: db.categoryList.length,
        itemBuilder: (context, index) {
          return TheListCategoryTile(
            categoryName: db.categoryList[index][0], 
            categoryIcon: db.categoryList[index][1],
            deleteFunction: (context) => deleteCategory(index, db.categoryList[index][0]));
        }
      )
    );
  }
}
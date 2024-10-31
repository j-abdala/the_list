import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:the_list/data/database.dart';
import 'package:the_list/services/permission_services.dart';
import 'package:the_list/utilities/dialog_box.dart';
import 'package:the_list/utilities/thelistcategory_tile.dart';
import 'package:the_list/services/notification_services.dart';

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

    // this comes with flutter_local_notification
    //AndroidFlutterLocalNotificationsPlugin().requestExactAlarmsPermission();

    checkPermission(Permission.notification, context);

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  bool isValid = false;
  
  // save new category
  void saveNewCategory() {
    if (db.categoryList.contains(_controller.text)) {
      if (_controller.text != "") {
        setState(() {
          db.categoryList.add([_controller.text, DropDownValue.getString()]);
          DropDownValue.resetString();
          print(DropDownValue.getString());
          _controller.clear();
          dateController.clear();
        });
        Navigator.of(context).pop();
        db.updateDatabase();
        isValid = true;
      }
    } else {
      isValid = false;
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
        if (element[2] == db.categoryList[index][0]) {
          toRemove.add(element);
        }
      });
      toRemove.forEach((element) {
        db.itemsList.removeWhere((item) => element[2] == item[2]);
      });
      db.categoryList.removeAt(index);
    });
    db.updateDatabase();
  }

  void testNotification() {
    NotificationService().showNotification(title: 'Test', body: 'test!');
    print('test');
  }
  // TODO: check database if there is already an existing item / category

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
      body: db.categoryList.isEmpty ? Center(child: Text('Create a new category')) : Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: db.categoryList.length,
          itemBuilder: (context, index) {
            return TheListCategoryTile(
              categoryName: db.categoryList[index][0], 
              categoryIcon: db.categoryList[index][1],
              deleteFunction: (context) => deleteCategory(index, db.categoryList[index][0]));
          }
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_list/services/notification_services.dart';
import 'package:the_list/utilities/button.dart';

class DialogBox extends StatefulWidget {
  final controller;
  final _formKey = GlobalKey<FormState>();
  final String labelName;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key, 
    required this.controller,
    required this.labelName,
    required this.onSave,
    required this.onCancel
    });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class DropDownValue {
  static String ddValue = 'not_interested';
  
  static void setString(String newValue) {
    ddValue = newValue;
    }

  static String getString() {
    return ddValue;
  }

  static void resetString() {
    ddValue = 'not_interested';
  }
}

class GetDateValue {
  static DateTime? getDate() {
    if (dateController.text.isNotEmpty) {
      return DateFormat('yyyy-MM-dd').parse(dateController.text);
    } else {
      return null;
    }
  }
}

TextEditingController dateController = TextEditingController();

class _DialogBoxState extends State<DialogBox> {
  String currentOption = 'not_interested'; 

  bool isEnabled = false;

  Future<void> selectDate() async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year), 
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Color(0xffFF6F61),
            surface: Color(0xff2B2B3C)
          ),
          datePickerTheme: DatePickerThemeData(
            cancelButtonStyle: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xffFF6F61)),
              foregroundColor: WidgetStatePropertyAll(Color(0xffeaeaea))
            ),
            confirmButtonStyle: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xffFF6F61)),
              foregroundColor: WidgetStatePropertyAll(Color(0xffeaeaea))
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          )),
        child: child!,)
    );

    setState(() {
      if (picked != null) {
        dateController.text = picked.toString().split(" ")[0];
      } 
      if (isEnabled == false) {
        dateController.clear();
        picked = null;
      }
    });
    
  }

  void onChanged() {
    setState(() {
      if (isEnabled == false) {
        isEnabled = true;
      } else {
        isEnabled = false;
        dateController.clear();
      }  
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      content: Form(
        key: widget._formKey,
        child: SizedBox(
          width: 200,
          height: widget.labelName == 'Category' ? 350 : isEnabled == true ? 330 : 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Text(
              //   widget.labelName == 'Category' ? 'Create a new category' : 'Create a new item', 
              //   style: Theme.of(context).textTheme.headlineMedium),
              // get user input
              Padding(
                padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    validator: (value) => value == "" ? 'The name cannot be empty' : null,
                    autovalidateMode: AutovalidateMode.always,
                    controller: widget.controller,
                    decoration: InputDecoration(
                      labelText: '${widget.labelName} Name',
                      hintText: 'Add new ${widget.labelName}',
                      border: OutlineInputBorder()
                    ),
                  ),
              ),
              if (widget.labelName == 'Category') ...[
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField(
                    value: currentOption,
                    isExpanded: true,
                    menuMaxHeight: 200,
                    decoration: InputDecoration(
                      label: Text('Select an icon')
                    ),
                    dropdownColor: Theme.of(context).colorScheme.primary,
                    onChanged: (String? newOption) {
                      setState(() {
                        currentOption = newOption!;
                        DropDownValue.setString(currentOption);
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'not_interested',
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.not_interested),
                            ),
                            Text('None')
                          ],
                        )
                      ),
                      DropdownMenuItem(
                        value: 'house',
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.house),
                            ),
                            Text('House')
                          ],
                        )
                      ),
                      DropdownMenuItem(
                        value: 'shopping_cart',
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.shopping_cart),
                            ),
                            Text('Shopping Cart')
                          ],
                        )
                      ),
                      DropdownMenuItem(
                        value: 'shopping_bag_rounded',
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.shopping_bag_rounded),
                            ),
                            Text('Shopping Bag')
                          ],
                        )
                      ),
                      DropdownMenuItem(
                        value: 'car_repair',
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.car_repair),
                            ),
                            Text('Car')
                          ],
                        )
                      ),
                      DropdownMenuItem(
                        value: 'pets',
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.pets),
                            ),
                            Text('Pet')
                          ],
                        )
                      ),
                      DropdownMenuItem(
                        value: 'assignment',
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.assignment),
                            ),
                            Text('Assignment')
                          ],
                        )
                      ),
                      DropdownMenuItem(
                        value: 'task',
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.task),
                            ),
                            Text('Task')
                          ],
                        )
                      ),
                      DropdownMenuItem(
                        value: 'cleaning_services',
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.cleaning_services),
                            ),
                            Text('Cleaning')
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ] else if (widget.labelName == 'Item') ...[
                //calendar
                Row(
                  children: [
                    Text(
                      'Add due date', 
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      )),
                    Checkbox(
                      value: isEnabled,
                      onChanged: (value) {
                        onChanged();
                      },
                      checkColor: Color(0xffeaeaea),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1
                      ),
                    ),
                  ],
                ),
                if (isEnabled == true) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: 'Due Date',
                        prefixIcon: Icon(
                          Icons.calendar_today, 
                          color: Theme.of(context).colorScheme.primary
                          ),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder()
                      ),
                      readOnly: true,
                      onTap: () {
                        selectDate();
                      },
                    ),
                  )
                ]
              ],
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // save button
                    Button(text: "Save", onPressed: widget.onSave),
                    // cancel button
                    Button(text: "Cancel", onPressed: widget.onCancel)
                  ],
                ),
              )
            ],
          )
        ),
      )
    );
  }
}
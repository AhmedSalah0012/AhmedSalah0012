import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/dirctory/firebase/firebase_Function.dart';
import 'package:todo/dirctory/firebase/taskModel.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime choosenDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add  New Task",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
                label: Text("Title"),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue))),
          ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
                label: Text("Description"),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue))),
          ),
          SizedBox(
            height: 12,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Time",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )),
          InkWell(
            onTap: () {
              displaypicker(context);
            },
            child: Text(
              choosenDate.toString().substring(0, 10),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    TaskModel model = TaskModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: DateUtils.dateOnly(choosenDate).millisecondsSinceEpoch);
                    FirebaseFunctions.addTask(model);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Add Task",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  )))
        ],
      ),
    );
  }

  displaypicker(BuildContext context) async {
    DateTime? selectedDay = await showDatePicker(
        context: context,
        confirmText: "Thanks",
        firstDate: DateTime.now(),
        initialDate: choosenDate,
        lastDate: DateTime.now().add(Duration(days: 365)));
    setState(() {
      if (selectedDay != null) choosenDate = selectedDay;
    });
  }
}

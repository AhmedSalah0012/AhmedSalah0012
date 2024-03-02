import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/dirctory/firebase/firebase_Function.dart';
import 'package:todo/dirctory/firebase/taskModel.dart';

class EditTab extends StatefulWidget {
  static const String routename = "Edit";

  EditTab({super.key});

  @override
  State<EditTab> createState() => _EditTabState();
}

class _EditTabState extends State<EditTab> {
  DateTime choosenDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as TaskModel;
    var titleController = TextEditingController(text: args.title);
    var descriptionController = TextEditingController(text: args.description);
    choosenDate = DateTime.fromMillisecondsSinceEpoch(args.date);

    return Scaffold(
      backgroundColor: Color(0xffdfecdb),
      appBar: AppBar(
        title: const Text(
          "Update Task",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white), // Change the color here

      ),
      body: Stack(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.blue,
          ),
          Container(
              height: MediaQuery.of(context).size.height*.5,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Edit Task",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 12,
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )),SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      displaypicker(context);
                    },
                    child: Text(
                      choosenDate.toString().substring(0, 10),
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            TaskModel model = TaskModel(
                                title: titleController.text,
                                description: descriptionController.text,
                                date: DateUtils.dateOnly(choosenDate).millisecondsSinceEpoch,id: args.id,isDone: args.isDone);
                            try {
                              await FirebaseFunctions.editTask(model);
                              Navigator.pop(context);
                            } catch (e) {
                              print("Error updating task: $e");
                              // Handle error as needed
                            }                          },
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          )))
                ],
              ))
        ],
      ),
    );
  }

  displaypicker(BuildContext context) async {
    DateTime? selectedDay = await showDatePicker(
        context: context,
        confirmText: "Thanks",
        firstDate: choosenDate,
        initialDate: choosenDate,
        lastDate: DateTime.now().add(Duration(days: 365)));
    setState(() {
      if (selectedDay != null) choosenDate = selectedDay;
    });
  }
}

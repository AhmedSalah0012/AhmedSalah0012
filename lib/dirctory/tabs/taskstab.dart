import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/dirctory/firebase/firebase_Function.dart';
import 'package:todo/dirctory/firebase/taskModel.dart';
import 'package:todo/dirctory/taskitem.dart';

class TasksTab extends StatefulWidget {
  static const String routeName="tasksTab";

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),color: Colors.blue.shade100
      ),
        child: DatePicker(
          DateTime.now(),
          initialSelectedDate: selectedDate,
          selectionColor: Colors.blue,
          selectedTextColor: Colors.white,
          height: 90,
          locale: "en",

          onDateChange: (date) {
            selectedDate=date;
           setState(() {

           });
          },
        ),
      ),SizedBox(height: 10,),
      Expanded(
        child: StreamBuilder<QuerySnapshot<TaskModel>>(
          stream: FirebaseFunctions.getTasks(selectedDate),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasError){
            return Column(children: [
              Text("Somethig Error"),
              ElevatedButton(onPressed: (){}, child: Text("Try again"))
            ],);
            }
            var tasks=snapshot.data?.docs.map((e) => e.data()).toList()??[];
            if(tasks.isEmpty){
              return const Center(child: Text("none"),);
            }
            return ListView.separated(
              separatorBuilder: (context,index)=>SizedBox(height: 12,),
              itemBuilder: (context,index){
                return TaskItem(taskModel: tasks[index]);
              },itemCount: tasks.length,
            );
          },
        ),
      )
    ],);
  }
}

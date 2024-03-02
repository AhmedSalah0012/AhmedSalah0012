import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/dirctory/firebase/firebase_Function.dart';
import 'package:todo/dirctory/firebase/taskModel.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;

  TaskItem({required this.taskModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18), color: Colors.white),
      child: Slidable(
        startActionPane:
            ActionPane(motion: DrawerMotion(), extentRatio: .6, children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(taskModel.id ?? "");
            },
            label: "Delete",
            backgroundColor: Colors.red,
            spacing: 5,
            autoClose: true,
            icon: Icons.delete,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18), topLeft: Radius.circular(18)),
          ),
          SlidableAction(
            onPressed: (context) {

            },
            label: "Edit",
            backgroundColor: Colors.blue,
            spacing: 5,
            autoClose: true,
            icon: Icons.edit,
          )
        ]),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: taskModel.isDone ? Colors.green.shade400 : Colors.blue,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(taskModel.description ?? "")
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  taskModel.isDone = true;
                  FirebaseFunctions.editTask(taskModel);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: taskModel.isDone
                            ? Colors.green.shade400
                            : Colors.blue),
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 30,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

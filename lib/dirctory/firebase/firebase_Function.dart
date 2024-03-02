import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/dirctory/firebase/taskModel.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(fromFirestore: (snapshot, _) {
      return TaskModel.fromJson(snapshot.data()!);
    }, toFirestore: (task, _) {
      return task.toJson();
    });
  }

  static Future<void> addTask(TaskModel taskModel) {
    var collection = getTaskCollection();
    var doc = collection.doc();
    taskModel.id = doc.id;
    return doc.set(taskModel);
  }


  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime dateTime) {
    return getTaskCollection().where("date",isEqualTo:DateUtils.dateOnly(dateTime).millisecondsSinceEpoch ).snapshots();
  }
  static Future<void>deleteTask(String id){
    return getTaskCollection().doc(id).delete();
  }
static Future<void> editTask(TaskModel taskModel){
    return getTaskCollection().doc(taskModel.id).update(taskModel.toJson());
}
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/dirctory/add_task_bottom_sheet.dart';
import 'package:todo/dirctory/tabs/settingstab.dart';
import 'package:todo/dirctory/tabs/taskstab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  static const String routeName = "homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdfecdb),
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Todo",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
            currentIndex: index,
            onTap: (value) {
              index = value;
              setState(() {});
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey.shade400,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.task,
                    color: Colors.cyan,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.cyan,
                  ),
                  label: "")
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskBottomSheet(),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.white, width: 3)),
      ),
      body: tabs[index],
    );
  }

  List<Widget> tabs = [TasksTab(), SettingsTab()];
}

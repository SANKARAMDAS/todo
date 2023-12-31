import 'package:flutter/material.dart';

import '../utils/dialog_box.dart';
import '../utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller
  final _controller = TextEditingController();

  //list of  todo tasks
  List toDOList = [
    ['Make Tasks', false],
    ['Go to the Gym', false],
  ];

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDOList[index][1] = !toDOList[index][1];
    });
  }
  
  //save new task
  void saveNewTask() {
    setState(() {
      toDOList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  //create new task
  void createNewTask() {
    showDialog(context: context, builder: (context){
      return DialogBox(controller: _controller,
      onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),);
    });
  }

  //delete task
  void deleteTask(int index){
    toDOList.remove(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Center(
          child: Text('To Do'),
        ),
        // elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDOList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            onChanged: (value) => checkBoxChanged(value, index),
            taskName: toDOList[index][0],
            taskComplete: toDOList[index][1],
              deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}

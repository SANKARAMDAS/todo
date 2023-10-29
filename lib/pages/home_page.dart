import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../db/database.dart';
import '../utils/dialog_box.dart';
import '../utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('myBox');

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the first time ever opening the app, then create default data
    if(_myBox.get('TODOLIST') == null) {
      db.createInitalData();
    } else {
      //there already exists data
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  // //list of  todo tasks
  // List toDOList = [
  //   ['Make Tasks', false],
  //   ['Go to the Gym', false],
  // ];

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDOList[index][1] = !db.toDOList[index][1];
    });
    db.updateDataBase();
  }
  
  //save new task
  void saveNewTask() {
    setState(() {
      db.toDOList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
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
    setState(() {
      db.toDOList.removeAt(index);
    });
    db.updateDataBase();
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
        itemCount: db.toDOList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            onChanged: (value) => checkBoxChanged(value, index),
            taskName: db.toDOList[index][0],
            taskComplete: db.toDOList[index][1],
              deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}

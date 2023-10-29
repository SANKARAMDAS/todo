import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDOList =[];

  //reference our box
  final _myBox = Hive.box('myBox');

  //run for the first time opening this aap
  void createInitalData() {
    toDOList = [
      ['Make Tasks', false],
      ['Go to the Gym', false],
    ];
  }

  //load the data from DB
  void loadData(){
    toDOList = _myBox.get('TODOLIST');
  }

  //update the data
  void updateDataBase(){
    _myBox.put('TODOLIST', toDOList);
  }
}
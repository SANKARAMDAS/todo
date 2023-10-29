import 'package:flutter/material.dart';

import 'button_page.dart';


class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key, required this.onSave, required this.onCancel, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new Task',
              ),
            ),

            //button -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //save button
                MyButtons(text: 'Save', onPressed: onSave,),

                const SizedBox(width: 7.0,),

                //Cancel Button
                MyButtons(onPressed: onCancel, text: 'Cancel')
              ],
            )
          ],
        ),
      ),
    );
  }
}


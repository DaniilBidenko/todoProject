import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do/data/model/todo.dart';

class SettingsScreen extends StatefulWidget{
  final Todo todo;
  const SettingsScreen({Key? key, required this.todo}) : super (key: key);
  
   

  @override
  _SettingsScreenState createState() => _SettingsScreenState(); // создаем состояние 
}
class _SettingsScreenState extends State<SettingsScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      title: Title(
        color: Colors.black, 
        child: Text('Найстройки',
        style: TextStyle(
          color:  Colors.black
        ),
        )),
      
    ),
    body: Center(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                 SizedBox(
              height: 5,
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    'Изменить цвет заголовка :'
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  
                ],
              )
              ),
              Expanded(
              child: Row(
                children: [
                  Text(
                    'Изменить цвет описания :'
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              )
              ),
              Expanded(
              child: Row(
                children: [
                  Text(
                    'Изменить цвет описания :'
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              )
              ),
              Expanded(
              child: Row(
                children: [
                  Text(
                    'Изменить цвет описания :'
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              )
              ),
              ],
            ),
            Column(
              children: [
                 SizedBox(
              height: 5,
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    'Изменить цвет заголовка :'
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              )
              ),
              Expanded(
              child: Row(
                children: [
                  Text(
                    'Изменить цвет описания :'
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              )
              ),
              Expanded(
              child: Row(
                children: [
                  Text(
                    'Изменить цвет описания :'
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              )
              ),
              Expanded(
              child: Row(
                children: [
                  Text(
                    'Изменить цвет описания :'
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              )
              ),
              ],
            ),
           
              
          ],
        ),
      ),
    ),
    );
    
  }

  Future _changePalitr (BuildContext context) async{
    final palitr = await showDialog(
      builder: context,
  context: context,
  child: AlertDialog(
    title: const Text('Pick a color!'),
    content: SingleChildScrollView(
      child: ColorPicker(
        pickerColor: pickerColor,
        onColorChanged: changeColor,
      ),
      // Use Material color picker:
      //
      // child: MaterialPicker(
      //   pickerColor: pickerColor,
      //   onColorChanged: changeColor,
      //   showLabel: true, // only on portrait mode
      // ),
      //
      // Use Block color picker:
      //
      // child: BlockPicker(
      //   pickerColor: currentColor,
      //   onColorChanged: changeColor,
      // ),
      //
      // child: MultipleChoiceBlockPicker(
      //   pickerColors: currentColors,
      //   onColorsChanged: changeColors,
      // ),
    ),
    actions: <Widget>[
      ElevatedButton(
        child: const Text('Got it'),
        onPressed: () {
          setState(() => currentColor = pickerColor);
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
)
  }

}
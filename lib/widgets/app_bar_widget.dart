import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/bloc/color_bloc.dart';
import 'package:to_do/bloc/color_state.dart';
import 'package:to_do/my_color/color.dart';
import 'package:to_do/screens/settings_screen.dart';
import 'package:to_do/screens/statistick_todo_screen.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget{

  const AppBarWidget ({Key? key}) : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize;
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {

  late AppBarColors appBarColors;
  
  Key _listKey = UniqueKey();
  
  @override
  void initState() {
    super.initState();
    appBarColors = AppBarColors();
    _loadColors();
  }

  Future<void> _loadColors() async{
    final colors = await AppBarColors.loadFromPrefs();
    setState(() {
      appBarColors = colors;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double appBarTitle = width * 0.04;
    return BlocBuilder<ColorBloc, ColorState>(
      builder: (context, state) {
        if (state is ColorLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ColorLoaded) {
          return AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Задачник',
                style: TextStyle(
                  fontSize: width * 0.025,
                  fontWeight: FontWeight.bold,
                  color: state.appBarColors.titleAppBarColor
                ),
                ),
                appbarButtons(
                  'Настройки',
                  width * 0.25, 
                  () {
                  Navigator.push(
                    context,
                     MaterialPageRoute(
                      builder: (context) => SettingsScreen()
                      )
                    );
                },
                state.appBarColors.buttonSettingsTextColor
                ),
                appbarButtons(
                  'Статистика',
                  width * 0.25,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatistickTodoScreen()
                      )
                    );
                  },
                  state.appBarColors.buttonAddedTextColor
                  )
              ],
            )
          );
        } else {
          return AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Задачник',
                style: TextStyle(
                  fontSize: width * 0.025,
                  fontWeight: FontWeight.bold,
                  color: appBarColors.titleAppBarColor
                ),
                ),
                appbarButtons(
                'Настройки',
                width * 0.25,
                () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen())
                    );
                }, 
                Colors.grey
                ),
                appbarButtons(
                  'Статистика', 
                  width * 0.25, 
                  () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => StatistickTodoScreen()
                        )
                      );
                  }, 
                  Colors.grey
                  )
              ],
            ),
          );
        }
      }
      );
  }

  Widget appbarButtons (String label, double appBarButtonSize, VoidCallback onTap, Color textColor) {
    double width = MediaQuery.of(context).size.width;
    double appBatText = width * 0.025;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        foregroundColor: Colors.grey,
                        side: BorderSide.none,
                        overlayColor: Colors.transparent
                      ),
                    onPressed: onTap,
                    child: Text(label,
                      style: TextStyle(
                        color: textColor,
                        fontSize: appBatText
                      ),
                    )
                    );
                    
  }
}

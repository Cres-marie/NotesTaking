import 'package:flutter/material.dart';
import 'package:notestaking/constants.dart';
import 'package:notestaking/screens/calculatorScreen.dart';
import 'package:notestaking/screens/createNote.dart';
import 'package:notestaking/screens/home.dart';
import 'package:notestaking/screens/listScreen.dart';
import 'package:notestaking/screens/searchScreen.dart';
import 'package:notestaking/screens/todoScreen.dart';


class BottomBar extends StatefulWidget {
  int index;
  BottomBar({required this.index});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int _selectedIndex;

  List _screens = [
    Home(),
    Todo(),
    Calculator()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.index;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: _screens[_selectedIndex],
        ),


        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: bselected,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          elevation:10,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
        
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Notes'
            ),
        
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: 'Day Planner'
            ),
            
             BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Calculator'
            ),
          
        
          ]
        ),

    );
  }
}

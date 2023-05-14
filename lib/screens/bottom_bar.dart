import 'package:flutter/material.dart';
import 'package:notestaking/constants.dart';
import 'package:notestaking/screens/calculatorScreen.dart';
import 'package:notestaking/screens/createNote.dart';
import 'package:notestaking/screens/home.dart';
import 'package:notestaking/screens/listScreen.dart';
import 'package:notestaking/screens/searchScreen.dart';
import 'package:notestaking/screens/todoScreen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  List _screens = [
    Home(),
    ListScreen(),
    Search(),
    CreateNote(),
    Calculator()
  ];

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
              label: 'To Do'
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search'
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.create), 
              label: 'Create Note'
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
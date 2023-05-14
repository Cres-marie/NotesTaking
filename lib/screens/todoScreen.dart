import 'package:flutter/material.dart';
import 'package:notestaking/screens/listScreen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants.dart';
import 'bottom_bar.dart';


class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {


DateTime? _selectedDay;
DateTime _focusedDay = DateTime.now();
CalendarFormat _calendarFormat = CalendarFormat.month;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

          title: Text('To Do', style: bheadings),
          backgroundColor: backgroundColor,
          elevation: 0.0,
          
  //centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: (){
              Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => BottomBar(),
                  ));
            }, 
            icon: Image.asset('images/backicon.png')
          ),

        ),

      body: SingleChildScrollView(
        child: Container(
          //margin: bmargintop,
          padding: bpadding,
          child: Column(
            children: [

              // Row(
              //   children: [
        
              //   InkWell(
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //           builder: (context) => BottomBar(),
              //     ));
              //     },
              //     child: Image.asset('images/backicon.png'),
              //   ),

              //   SizedBox(width: 32,),

              //   Center(child: Text('To Do', style: bheadings,)),
        
              //   SizedBox(width: 140,),
        
              //   // TextButton(
              //   //   onPressed: (){
              //   //     Navigator.push(context, MaterialPageRoute(builder: (context) => ListScreen(),));
              //   //   },
              //   //   child: Icon(Icons.event_note, size: 40,color: biconcolor,)
              //   // )
        
              //   ],
              // ),

              SafeArea(
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2230, 3, 14),
                  focusedDay:  _focusedDay,
                  headerVisible: true,
                  availableCalendarFormats: {
                    CalendarFormat.month: 'Month',
                    //CalendarFormat.week: 'Week',
                  },
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)){
                      // Call `setState()` when updating the selected day
                      setState(() {
                      _selectedDay = selectedDay;
                     _focusedDay = focusedDay; // update `_focusedDay` here as well
                    });
                    }
                 },
                  calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                       // Call `setState()` when updating calendar format 
                        setState(() {
                        _calendarFormat = format;
                        });
                      };
                    },

                    onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                      _focusedDay = focusedDay;
                    },


                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      weekendTextStyle: TextStyle().copyWith(color: bselected),
                      holidayTextStyle: TextStyle().copyWith(color: bselected),
                      defaultTextStyle: TextStyle().copyWith(fontSize: 15.0, color: Colors.black87),
                      selectedTextStyle: TextStyle().copyWith(fontSize: 15.0, color: Colors.white),
                      todayTextStyle: TextStyle().copyWith(fontSize: 15.0, color: Colors.black87),
                      markersMaxCount: 5,
                      markersAlignment: Alignment.bottomCenter,
                      todayDecoration: BoxDecoration(
                        color: Colors.green[100],
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),

                    headerStyle: HeaderStyle(
                      formatButtonVisible: true,
                      titleCentered: true,
                      titleTextStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                      formatButtonTextStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),



                    
                  //availableGestures: AvailableGestures.none,
                  //CalendarFormat.month : 'Month',
                ),
              ),

              SizedBox(height: 80,),

              Container(
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2.0,
        blurRadius: 5.0,
        offset: Offset(0, 3),
      ),
    ],
  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      //flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Add Event',
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
              
                   TextButton(
                      onPressed: (){
                        
                      },
                      child: SizedBox(
                        width: 60, // set the desired width
                        height: 80, // set the desired height
                        child: Image.asset('images/add.png', height: 80, width: 80),
                      ),
                    )
              
                  ],
                ),
              )

            ],
            
          ),
        ),
      )
    );
  }
}
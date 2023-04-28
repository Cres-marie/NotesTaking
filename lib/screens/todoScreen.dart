import 'package:flutter/material.dart';
import 'package:notestaking/screens/listScreen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants.dart';


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

      body: SingleChildScrollView(
        child: Container(
          margin: bmargintop,
          padding: bpadding,
          child: Column(
            children: [

              Row(
                children: [
        
                InkWell(
                  onTap: () {},
                  child: Image.asset('images/backicon.png'),
                ),

                SizedBox(width: 32,),

                Center(child: Text('To Do', style: bheadings,)),
        
                SizedBox(width: 140,),
        
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListScreen(),));
                  },
                  child: Icon(Icons.event_note, size: 40,color: biconcolor,)
                )
        
                ],
              ),

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

                    
                  //availableGestures: AvailableGestures.none,
                  //CalendarFormat.month : 'Month',
                ),
              ),

              SizedBox(height: 40,),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Add Event',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                  ),

                 TextButton(
                    onPressed: (){},
                    child: SizedBox(
                      width: 60, // set the desired width
                      height: 80, // set the desired height
                      child: Image.asset('images/add.png', height: 80, width: 80),
                    ),
                  )

                ],
              )

            ],
            
          ),
        ),
      )
    );
  }
}
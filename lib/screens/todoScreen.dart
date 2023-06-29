import 'dart:math';
import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notestaking/Event.dart';
import 'package:notestaking/authenticate.dart';
import 'package:notestaking/notification.dart';
import 'package:notestaking/sqlite.dart';
import 'package:notestaking/authenticate.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../Event.dart';
import '../constants.dart';
import '../sqlite.dart';
import 'listScreen.dart';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final mysql = sqlite();
  final popupmessage = authenticate();
  final _formkey = GlobalKey<FormState>();
DateTime? _selectedDay;
DateTime _focusedDay = DateTime.now();

CalendarFormat _calendarFormat = CalendarFormat.month;
Map<DateTime, List<Event>> selectedEvents={};
 
  final title = TextEditingController();
  Future<void> getdata() async{
   List<Map<String, dynamic>> events = await mysql.getevents();
   selectedEvents.clear();
  if(events.isNotEmpty){
     for(int i=0; i< events.length; i++){
      //print(events[i]['eventtime']);
    int id = events[i]['_id'];
    String title = events[i]['Title'];
    DateTime date= DateTime.parse(events[i]['eventtime'].toString());
    String eventtime = events[i]['starttime'];
    
         if(selectedEvents[date] != null){
      setState(() {
         selectedEvents[date]!.add(Event(title: title,id: id, time: eventtime));
        print(selectedEvents);
      });
    }
    else{
      setState(() {
        selectedEvents[date] = [Event(title: title,id: id, time: eventtime)];
      print(selectedEvents);
      });
      
    }
    
 
  }
  }
 
  }
  List _getEventsfromDay(DateTime date){
    
    return selectedEvents[date] ?? [];
  }
 
   Future<DateTime?> pickdatetime(DateTime initialdate, bool dateortime) async{
    if(dateortime){
      final datepicked = await showDatePicker(context: context, initialDate: initialdate, firstDate: DateTime.now(), lastDate: DateTime(2050));
      //final time = Duration(hours: initialdate.hour, minutes: initialdate.minute);
      return datepicked;
    }
    
    else{
       final timepicked = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initialdate), builder:(context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Container(
          height: 600,
          width: 450,
          child: child!),
    );
      },);
      if(timepicked == null) return null;
      final date = DateTime(initialdate.year, initialdate.month, initialdate.day);
      final time = Duration(hours: timepicked.hour, minutes: timepicked.minute);
      return date.add(time);
    }
     

  }
  @override
  void initState() {
    super.initState();
    getdata();
    SmolleyNotification.checkScheduledNotifications(flutterLocalNotificationsPlugin);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
extendBodyBehindAppBar: true,
      appBar: AppBar(
         
      //   //title:Text('To Do', style: bheadings,),
      //
         backgroundColor:  Color.fromARGB(255, 214, 118, 58),
         elevation: 0.0,
         automaticallyImplyLeading: false,
      //   leading: IconButton(onPressed: (){
      //        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomAppBar(),));
      //     }, icon: Image.asset('images/backicon.png'),
      //   ),
      //   // actions: [
      //   //   IconButton(onPressed: (){
      //   //      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomAppBar(),));
      //   //   }, icon: Image.asset('images/backicon.png'),
      //   //   )
      //   // ],
       ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              children: [
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 214, 118, 58),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18)
                        )
                      ),
                      padding: bpadding,
                      //margin: bmargintop,
                      
                      
                      child: TableCalendar(
                        calendarStyle: CalendarStyle(
                          defaultTextStyle: TextStyle(fontSize: 15, color: Colors.white),
                          //titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          defaultDecoration:  BoxDecoration(
                            
                            //shape: BoxShape.rectangle,
                            //borderRadius: BorderRadius.circular(10),
                            //color: Colors.grey[200]
                            //color: Colors.transparent, // Change the color to your desired background color
                            //border: Border.all(color: Colors.grey), // Add a border to each day
                          ),
                          weekendDecoration: BoxDecoration(
                            //shape: BoxShape.rectangle,
                            //borderRadius: BorderRadius.circular(10),
                            //color: Color.fromARGB(255, 183, 149, 98)
      
                          ),
                          todayDecoration: BoxDecoration(
                             shape: BoxShape.circle,
                            color:  Color.fromARGB(255, 148, 61, 7),
                            //borderRadius: BorderRadius.circular(10),
                          ) ,
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 233, 148, 95),
                            //borderRadius: BorderRadius.circular(10),
                          ),
                          
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: true,
                          titleCentered: true,
                          formatButtonDecoration: BoxDecoration(
                            color: Color.fromARGB(255, 233, 148, 95),
                            borderRadius: BorderRadius.circular(10)
                          ),
      
                          titleTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
        //fontWeight: FontWeight.bold,
                        ),
      
                        weekdayStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
        //fontWeight: FontWeight.bold,
                        ),
                      ),
      
      
                        currentDay: DateTime.now(),
                        firstDay: DateTime.now(),
                        lastDay: DateTime.utc(2230, 3, 14),
                        focusedDay:  _focusedDay,
                        headerVisible: true,
                        daysOfWeekVisible: true,
                        eventLoader: _getEventsfromDay,
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, day, events) {
                            if (events.isEmpty) return SizedBox();
                                       return Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(top: 20),
                                                  padding: const EdgeInsets.all(1),
                                                  child: Container(
                                                    // height: 7,
                                                    width: 5,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
                                                  ),
                                                ),
                                                Container(margin: const EdgeInsets.only(top: 20),child: Text(events.length.toString(), style: TextStyle(fontSize:10 ),))
                                              ],
                                            );
                          }
                        ),
                        availableCalendarFormats: {
                          CalendarFormat.month: 'Month',
                          //CalendarFormat.week: 'Week',
                        },
                        selectedDayPredicate: (day) {
                            
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
      
                    SizedBox(height: 18,),
      
                    Container(
                      padding: bpadding,
                      child: Text('Tasks', style: bheadings)
                    )
                  ],
                ),
            
            
                ..._getEventsfromDay(_focusedDay).map((event) => SingleChildScrollView(
              
                  child: GestureDetector(
                    onLongPress: () {
                      popupmessage.deletenotemessage(context,event.id, false);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                    
                      child: AnimatedOpacity(
                        opacity: event.isChecked ? 0.5 : 1.0,
                        duration: Duration(seconds: 2),
                        child: Container(
                           height: 120,
                           width: 550,
                           margin: EdgeInsets.symmetric( horizontal: 2, vertical: 5),
                           
                           padding: bpadding,
                           //padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(
                              color:  Color.fromARGB(255, 230, 190, 165),
                             //color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.6),
                             borderRadius: BorderRadius.circular(10),
                             boxShadow: [BoxShadow(
                              color: Color.fromARGB(255, 223, 211, 211),
                              offset: Offset(0.0, 4.0),
                              blurRadius: 6.0,
                              ),
                               ],
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                              
                              Row(
                                children: [
                                  Expanded(
                                    child: AnimatedOpacity(
                                      opacity: event.isChecked ? 0.5 : 1.0, // Adjust the opacity based on the isChecked value,
                                      duration: Duration(seconds: 2),// Set the duration of the fade animation
                                      child: Text(
                                        '${event.title[0].toUpperCase()}${event.title.substring(1)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          decoration: event.isChecked
                                            ? TextDecoration.lineThrough // Apply strikethrough style when isChecked is true
                                            : TextDecoration.none, // Remove decoration when isChecked is false
                                
                                        ) 
                                      ),
                                    ),
                                  ),
                      
                                  Checkbox(
                                    value: event. isChecked ?? false, 
                                    onChanged: (value){
                                        setState(() {
                                          event.isChecked = value ?? false;
                  
                                          if (event.isChecked) {
                  
                                            //deleterecord(event.id);
                        
                                          setState(() {
                          
                                      });
                                    }
                                        });
                                    }
                                  )
                                ],
                              ),
                                        
                              Text(event.time, style: TextStyle(fontSize: 12,) ),
                                        
                                        
                                        
                              
                              // ListTile(
                              //    splashColor: Colors.black,
                              //    style: ListTileStyle.drawer,
                              //    //title: Center(child: Text(event.title,style: TextStyle(fontWeight: FontWeight.bold))),
                                        
                              //  ),
                              //  Expanded(child: Text(event.time,maxLines: 2, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),)),
                                  
                             ],
                           ),
                         ),
                      ),
                    ),
                  ),
                ),)
            
              ],
              
            ),
          ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
        showDialog(context: context, builder: (context){
          DateTime time = DateTime.now();
          final dDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
          DateTime date = dDay.toUtc();
          
          print(date);
         return StatefulBuilder(
           builder: (BuildContext context, void Function(void Function()) setState) { 
            return AlertDialog(
            backgroundColor: Color.fromARGB(255, 209, 219, 215),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Enter Your Event'),
                Icon(Icons.calendar_month, color:  Color(0xFF52B848),)
              ],
            ),
             content: SingleChildScrollView(
               child: Form(
               key: _formkey,
               child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   TextFormField(
                           validator: (value) {
                             if( value == null || value.isEmpty ){
                               return 'Please fill in this field';
                             }
                             return null;
                           },
                           style: TextStyle(fontSize: 20),
                           controller: title,
                           decoration: InputDecoration(
                             hintText: 'Remind me to...',
                             suffixIcon: Icon(Icons.create_sharp),
                             border: UnderlineInputBorder()
                           ),
                         ),
                        SizedBox(height: 20,),
                         Text('SELECT TIME', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                         SizedBox(height: 20,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async{
                                    final mydate = await pickdatetime(time, true);
                                    if(mydate == null) return null;
                                    final dDay = DateTime.utc(mydate.year, mydate.month, mydate.day).toUtc();
                                    print(dDay);
                                    setState((){
                                      date = dDay;
                                    } );
                                },
                                child: Text('Date: '+DateFormat.yMMMd().format(date))),
                            ),
                            InkWell(
                              onTap: () async{
                                 final mydate = await pickdatetime(time, false);
                                 if(mydate == null) return null;
                                 setState(()=> time = DateTime(date.year, date.month, date.day, mydate.hour, mydate.minute));
                              },
                              child: Text('Time: '+DateFormat.Hm().format(time))),
                          ],
                         ),
                         

                 ],
               )),
             ),
             actions: [
              ElevatedButton(
                          onPressed: (){
                         if(_formkey.currentState!.validate()){
                          mysql.insertevent(title.text,date,time);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=> ListScreen())                 
                          print(selectedEvents.entries);
                          
                          SmolleyNotification.ShowNotification(title: 'Hey there! Do you know what time it is?', body: title.text, fn: flutterLocalNotificationsPlugin, time: time);

                          
                          SmolleyNotification.checkScheduledNotifications(flutterLocalNotificationsPlugin);
                          
                          getdata();
                          Navigator.of(context).pop();
                           
                         }
                          }, 
                          child: Text("Add Event")),
                           TextButton(
                     onPressed: (){
                         Navigator.of(context).pop();
            }, child: Text("Cancel")),
           
             ],
           );
            },
            
         );
        });
      },
      backgroundColor: Color(0xFF52B848),
      child: Icon(Icons.add, size: 30,),
      ),
      
    );
  }
  

}



  // TextButton(
  //                   onPressed: (){
  //                     if(title.text.isEmpty){
  //                       return;
  //                     }
  //                     else{
                        
  //                        // selectedEvents[_focusedDay]!.add(Event(title: title.text));
  //                         mysql.insertevent(title.text,_focusedDay,time);
  //                         Navigator.push(context, MaterialPageRoute(builder: (context)=> ListScreen()));
  //                         print(selectedEvents.entries);
  //                         getdata();
                          
  //                          SmolleyNotification().dailyNotification(time, 'Hey there! Do you know what time it is?', title.text);
  //                          SmolleyNotification().dailyNotification(time.subtract(Duration(minutes: 30)), 'Hey there! Its almost Time', title.text);
  //                     }
  //                   },
  //                   child: SizedBox(
  //                     width: 45, // set the desired width
  //                     height: 55, // set the desired height
  //                     child: Image.asset('images/add.png', height: 80, width: 80),
  //                   ),
  //                 ),

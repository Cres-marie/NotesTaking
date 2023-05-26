import 'dart:math';
import 'dart:ui';

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
    String title = events[i]['Title'];
    DateTime date= DateTime.parse(events[i]['eventtime'].toString());
    String eventtime = events[i]['starttime'];
    print(date);

    
         if(selectedEvents[date] != null){
      setState(() {
         selectedEvents[date]!.add(Event(title: title, time: eventtime,));
      print('xxxxxxxxxxxxxxxxxxxx');
        print(selectedEvents);
      });
     
    }
    else{
      setState(() {
        selectedEvents[date] = [Event(title: title, time: eventtime)];
      print('xxxxxxxxxxxxxxxxxxxx');
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
 
    //SmolleyNotification.initialize(fNp);
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
         flexibleSpace: ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.transparent,),),),
        title: Center(child:Text('To Do', style: bheadings,),),
         backgroundColor: Colors.white.withAlpha(150),
        actions: [
          IconButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => ListScreen(),));
          }, icon: Icon(Icons.calendar_month, color:biconcolor ,))
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent:AlwaysScrollableScrollPhysics()),
        child: SafeArea(
          child: Column(
            children: [
              TableCalendar(
                calendarStyle: CalendarStyle(
                  defaultDecoration:  BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  weekendDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  todayDecoration: BoxDecoration(
                     shape: BoxShape.rectangle,
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(10),
                  ) ,
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: true,
                  formatButtonDecoration: BoxDecoration(
                    color:  Color(0xFF52B848),
                    borderRadius: BorderRadius.circular(10)
                  )
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
          
          
              ..._getEventsfromDay(_focusedDay).map((event) => Container(
                 height: 120,
                 width: 150,
                 margin: EdgeInsets.symmetric( horizontal: 2, vertical: 5),
                 padding: EdgeInsets.all(5),
                 decoration: BoxDecoration(
                   color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.6),
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
                     ListTile(
                       splashColor: Colors.black,
                       style: ListTileStyle.drawer,
                       title: Center(child: Text('TITLE: '+event.title,style: TextStyle(fontWeight: FontWeight.bold))),
                     ),
                     Expanded(child: Text(event.time,maxLines: 2, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),)),
                        
                   ],
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
          bool remainder = false;
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
                          SizedBox(height: 20,),
                         Divider(color: Colors.grey,),
                         
                           SwitchListTile(
                            title: Text('Remind me daily'),
                            value: remainder, onChanged: (value){
                                  setState(() =>remainder = value,);
                                }),

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
                          //  SmolleyNotification().dailyNotification(time, 'Hey there! Do you know what time it is?', title.text);
                          //  SmolleyNotification().dailyNotification(time.subtract(Duration(minutes: 30)), 'Hey there! Its almost Time', title.text);
                           Navigator.of(context).pop();
                           getdata();
                         }
                          }, 
                          child: Text("Add Event")),
                           TextButton(
                     onPressed: (){
                         Navigator.of(context).pop();
            }, child: Text("Cancel"))
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

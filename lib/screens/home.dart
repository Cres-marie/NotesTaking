import 'package:flutter/material.dart';
import 'package:notestaking/constants.dart';
import 'package:notestaking/screens/authenticate.dart';
import 'package:notestaking/screens/sqlite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final mysql = sqlite();
  final auth = authenticate();
  List<Map<String,dynamic>> thisweek=[];
  List<Map<String,dynamic>> weeksago=[];
  Future<void> getdata() async{
    List<Map<String, dynamic>> weekAgonotes = await mysql.getdata();
    List<Map<String, dynamic>> weeksbefore = await mysql.weeksbefore();
    setState(() {
      thisweek = weekAgonotes;
      weeksago = weeksbefore;
    });
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          child: Container(
            margin: bmargintop,
            padding: bpadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Notes', style: bheadings),

                SizedBox(height: 24,),

                InkWell(
                  onTap: () {},
                  child: Image.asset('images/search.png'),
                ),

                SizedBox(height: 24,),

                Row(
                  children: [

                    Container(
                      height: 50,
                      width: 160,
                      child: ElevatedButton.icon(
                        onPressed: (){}, 
                        icon: Image.asset('images/notes.png', height: 50,), 
                        label: Text('All Notes', style: TextStyle(color: Colors.black),),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          shape:MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          )
                        ),
                      ),
                    ),

                    SizedBox(width: 20,),

                    Container(
                      height: 50,
                      width: 160,
                      child: ElevatedButton.icon(
                        onPressed: (){}, 
                        icon: Image.asset('images/trash.png', height: 50,), 
                        label: Text('Trash', style: TextStyle(color: Colors.black),),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          shape:MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          )
                        ),
                      ),
                    )

                  ],
                ),

                SizedBox(height: 24,),

                Text('Recent Notes' ,style: bheadings,),
                SizedBox(height: 24,),
                  
               thisweek.isEmpty?
               Container(
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/splash.png'), alignment: Alignment.center, fit: BoxFit.fill)
                ),
              ): 
               SizedBox(
                height: 200,
                 child: Expanded(
                 // flex: 1,
                   child: ListView.builder(
                   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    shrinkWrap: true,
                    itemCount: thisweek.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return GestureDetector(
                   onTap: () {
                     //Navigator.push(context, MaterialPageRoute(builder: (context) => mynote(note: thisweek[index]),));
                   },
                   onLongPress: (){
                      auth.deletenotemessage(context,thisweek[index]['_id']);
                             getdata();
                   },
                   child: Container(
                     height: 200,
                     width: 150,
                     margin: EdgeInsets.symmetric( horizontal: 2, vertical: 5),
                     padding: EdgeInsets.all(5),
                     decoration: BoxDecoration(
                       color: Colors.primaries[index % Colors.primaries.length].shade400,
                       borderRadius: BorderRadius.circular(10),
                       boxShadow: [BoxShadow(
                        color: Color.fromARGB(255, 223, 211, 211),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 6.0,
                        ),
                         ],
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         ListTile(
                           splashColor: Colors.black,
                           style: ListTileStyle.drawer,
                           title: Center(child: Text('TITLE: '+thisweek[index]['Title'], style: TextStyle(fontWeight: FontWeight.bold),)),
                         ),
                         
                         Expanded(child: Text(thisweek[index]['notes'],maxLines: 4, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,)),
                         Text(thisweek[index]['time'].toString(),),
                       ],
                     ),
                   ),
                      );
                      
                    },),
                 ),
               ),
               SizedBox(height: 5,),
            Text('Past Notes' ,style: bheadings,),
                
              weeksago.isEmpty?
              Container(
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/splash.png'), alignment: Alignment.center, fit: BoxFit.fill)
                ),
              )
               :SizedBox(
                
                height: 325,
                 child: Expanded(
                 // flex: 1,
                   child: ListView.builder(
                   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                   //dragStartBehavior: DragStartDetails,
                    shrinkWrap: true,
                    itemCount: weeksago.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context,index){
                      return GestureDetector(
                   onTap: () {
                     //Navigator.push(context, MaterialPageRoute(builder: (context) => mynote(note: weeksago[index]),));
                   },
                   onLongPress: (){
                      auth.deletenotemessage(context,weeksago[index]['_id']);
                             getdata();
                   },
                   child: Container(
                     height: 150,
                     width: 150,
                     margin: EdgeInsets.symmetric( horizontal: 2, vertical: 5),
                     padding: EdgeInsets.all(5),
                     decoration: BoxDecoration(
                       color: Colors.primaries[index % Colors.primaries.length].shade400,
                       borderRadius: BorderRadius.circular(10),
                       boxShadow: [BoxShadow(
                        color: Color.fromARGB(255, 223, 211, 211),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 6.0,
                        ),
                         ],
                     ),
                     child: Column(
                       
                       children: [
                         ListTile(
                           splashColor: Colors.black,
                           style: ListTileStyle.drawer,
                           title: Center(child: Text(weeksago[index]['time'])),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(weeksago[index]['_id'].toString(),),
                             SizedBox(width: 30,),
                             Expanded(child: Text(weeksago[index]['notes'],maxLines: 2, overflow: TextOverflow.ellipsis,)),
                            
                           ],
                         ),
                       ],
                     ),
                   ),
                      );
                      
                    },),
                 ),
               ),
                

              ],
              
            ),
          ),
          
        )
        //Text('Home'),

    );
  }
}
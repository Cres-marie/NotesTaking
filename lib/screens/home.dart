import 'package:flutter/material.dart';
import 'package:notestaking/constants.dart';
import 'package:notestaking/authenticate.dart';
import 'package:notestaking/sqlite.dart';

import '../authenticate.dart';
import '../sqlite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final mysql = sqlite();
  final auth = authenticate();
  bool loading = false;
  String greeting = '';
  List<Map<String,dynamic>> notes=[];
  List<Map<String, dynamic>> filtered_list =[];
  Future<void> getdata() async{
    setState(()=> loading =true);
    //await Future.delayed(Duration(seconds: 1));
    List<Map<String, dynamic>> mynotes = await mysql.getdata();

    setState(() {
      notes = mynotes;
      filtered_list = mynotes;
    });
    setState(()=> loading = false);
  }
    void _greetnigga(){
    var hour = DateTime.now().hour;
    if(hour<12){
      setState(() {
        greeting = 'Good morning,';
      });
      
    } else if(hour<18){
      setState(() {
        greeting = 'Good afternoon,';
      });
      
    } else{
      setState(() {
       greeting = 'Good evening,';
      });

    }
  }
  void Searchevent(String query){
  final suggestions = notes.where((note){
      final title = note['Title'].toString().toLowerCase();
      final body = note['notes'].toString().toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input);
    }).toList();
    setState(() => filtered_list = suggestions);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    _greetnigga();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          flexibleSpace: ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.transparent,),),),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(greeting, style: TextStyle(color: Colors.black, fontSize: 28),),
              Row(
                children: [
                  
                  Text('Smolleys', style: bheadings),
                ],
              ),
            ],
          ),
          backgroundColor: Colors.white.withAlpha(150),
          elevation: 0.0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          

        ),

        body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.vertical,
          padding:  bpadding,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                //Text('Notes', style: bheadings),
          
                //SizedBox(height: 24,),
          
          
                Container(
          
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
          
                child: TextField(
                      //controller: search,
                      onChanged: (value){
                        Searchevent(value);
                      },
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          hintText: 'Search for note',
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          //fillColor: biconcolor,
                          fillColor: Color.fromARGB(255, 69, 143, 72),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),    
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color.fromARGB(255, 14, 147, 19)),
                          ),
                    
                        ),
                    ),
              ),
          // Container(
          //       height: 80,
          //       decoration: BoxDecoration(
          //         image: DecorationImage(image: AssetImage('images/started.png'), alignment: Alignment.center, fit: BoxFit.fill)
          //       ),
          //     ),
                SizedBox(height: 24,),
            Text('Yours Notes' ,style: bheadings,),
                
              SizedBox(
                height: MediaQuery.of(context).size.height ,
                 child: ListView.builder(
                 // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  shrinkWrap: true,
                  itemCount: filtered_list.length,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context,index){
                    return GestureDetector(
                 onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNote(note: filtered_list[index]),));
                 },
                 onLongPress: (){
                    auth.deletenotemessage(context,filtered_list[index]['_id'], true);
                           getdata();
                 },
                 child: Card(
                   
                   margin: EdgeInsets.symmetric( horizontal: 2, vertical: 5),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   //color: Colors.primaries[index % Colors.primaries.length].shade400,
                   color: cardColors[index % cardColors.length],
                   elevation: 6,
                 
                   child: Container(
                    width: 150,
                    height: 130,
                     child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${notes[index]['Title'][0].toUpperCase()}${filtered_list[index]['Title'].substring(1)}',
                               //thisweek[index]['Title'],
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black,),
                            ),
                            Divider(height: 10, thickness:2 ,),
                            SizedBox(height: 12),
                            Text(
                               filtered_list[index]['notes'],
                                maxLines: null,
                                overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black,fontSize: 16,letterSpacing: 0.5, height: 1.2,),
                            ),
                            SizedBox(height: 10),
                            
                            Text(
                              filtered_list[index]['time'].toString(),
                              style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 36, 35, 35),letterSpacing: 0.5,),
                            ),
                          ],
                        ),
                      ),
                   ),
                   
                  //  child: Column(
                  //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //    children: [
                  //      ListTile(
                  //        splashColor: Colors.black,
                  //        style: ListTileStyle.drawer,
                  //        title: Center(child: Text('TITLE: '+thisweek[index]['Title'], style: TextStyle(fontWeight: FontWeight.bold),)),
                  //      ),
                       
                  //      Expanded(child: Text(thisweek[index]['notes'],maxLines: 4, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,)),
                  //      Text(thisweek[index]['time'].toString(),),
                  //    ],
                  //  ),
                 ),
                    );
                    
                  },),
               ),
                
          
              ],
              
            ),
          ),
          
        ),
        //Text('Home'),
        floatingActionButton: FloatingActionButton.extended(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateNote(note: {},))); },
        backgroundColor: Color(0xFF52B848),
        
        icon: Icon(Icons.create),
        label:  Text('Create Note')
        ),
    );
  }
  Widget buildNoteShimmer() =>  Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.grey[300]!,
              child: Container(
              width: 150,
              height: 110,
              child: Padding(
              padding: EdgeInsets.all(8),
                    
              ),
              ),
  );
}


import 'package:flutter/material.dart';
import 'package:notestaking/constants.dart';

import '../authenticate.dart';
import '../sqlite.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final mysql = sqlite();
   final auth = authenticate();
  final controller = TextEditingController();

  List<Map<String,dynamic>> notes=[];
  List<Map<String, dynamic>> filtered_list =[];
  Future<void> getAllNotes() async{
    List<Map<String, dynamic>> mynotes = await mysql.getdata();
    
    setState((){
      notes = mynotes;
      filtered_list = mynotes;
    });
    
  }
  void Searchnote(String query){
    final suggestions = notes.where((note){
      final title = note['Title'].toString().toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input);
    }).toList();
    setState(() => filtered_list = suggestions);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllNotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

          title: Text('Search Notes', style: bheadings),
          backgroundColor: backgroundColor,
          elevation: 0.0,
  //centerTitle: true,
          automaticallyImplyLeading: false,

        ),

      body: Padding(
        padding: bpadding,
        child: Column(
          children: [
            Container(
             // margin: bmargintop,
              padding: bpadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      
                  //Text('Notes', style: bheadings),
      
                  //SizedBox(height: 24,),
      
                  Container(
                    //margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                      //controller: controller,
                      // onChanged: (value){
                      //   //Searchnote(value);
                      // },
                      
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 85, 86, 85),),
                        hintText: 'Search for note',
                        filled: true,
                        //fillColor: biconcolor,
                        fillColor: Color.fromARGB(255, 69, 143, 72),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),    
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color.fromARGB(255, 14, 147, 19)),
                        ),
                  
                      ),
                    ),
                  ),
                ],
              )
            ),
            // Expanded(
            //         child: ListView.builder(
            //           itemCount: filtered_list.length,
            //            scrollDirection: Axis.vertical,
            //           itemBuilder: (context, index){
            //             return GestureDetector(
            //            onTap: () {
            //              //Navigator.push(context, MaterialPageRoute(builder: (context) => mynote(note: filtered_list[index]),));
            //            },
            //            onLongPress: (){
            //               auth.deletenotemessage(context,filtered_list[index]['_id']);
            //               getAllNotes();
            //            },
            //            child: Container(
            //              height: 120,
            //              width: 150,
            //              margin: EdgeInsets.symmetric( horizontal: 2, vertical: 5),
            //              padding: EdgeInsets.all(5),
            //              decoration: BoxDecoration(
            //                color: Colors.primaries[index % Colors.primaries.length].shade400,
            //                borderRadius: BorderRadius.circular(10),
            //                boxShadow: [BoxShadow(
            //                 color: Color.fromARGB(255, 223, 211, 211),
            //                 offset: Offset(0.0, 4.0),
            //                 blurRadius: 6.0,
            //                 ),
            //                  ],
            //              ),
            //              child: Column(
            //                crossAxisAlignment: CrossAxisAlignment.start,
            //                children: [
            //                  ListTile(
            //                    splashColor: Colors.black,
            //                    style: ListTileStyle.drawer,
            //                    title: Center(child: Text('TITLE: '+filtered_list[index]['Title'],style: TextStyle(fontWeight: FontWeight.bold))),
            //                  ),
            //                  Expanded(child: Text(filtered_list[index]['notes'],maxLines: 2, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),)),
            //                     Text(filtered_list[index]['time'],),
            //                ],
            //              ),
            //            ),
            //               );
            //         })
            //       )
          ],
        ),
      )
    );
  }
}

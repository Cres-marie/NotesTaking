import 'package:flutter/material.dart';
import 'package:notestaking/constants.dart';
import 'package:notestaking/screens/bottom_bar.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final search = TextEditingController();
  final mysql = sqlite();
  final auth = authenticate();
  List<Map<String,dynamic>> events=[];
  List<Map<String, dynamic>> filtered_list =[];
  Future<void> getAllevents() async{
    List<Map<String, dynamic>> mynotes = await mysql.getevents();
    setState((){
      events = mynotes;
      filtered_list = mynotes;
    });
  }
  void Searchevent(String query){
    final suggestions = events.where((note){
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
    getAllevents();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          margin: bmargintop,
          padding: bpadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Text('Notes', style: bheadings),
              InkWell(
                  onTap: () {
                  Navigator.of(context).pop();
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => Navigator.pop(context),));
                  },
                  child: Image.asset('images/backicon.png'),
                ),

              SizedBox(height: 24,),

              TextField(
                    controller: search,
                    onChanged: (value){
                      Searchevent(value);
                    },
                    
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.green,),
                      hintText: 'Search for note',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),    
                      )
                    ),
                  ),

              SizedBox(height: 32,),

              Text('To Do', style: bheadings,),

              Expanded(
                    child: ListView.builder(
                      itemCount: filtered_list.length,
                       scrollDirection: Axis.vertical,
                      itemBuilder: (context, index){
                        return GestureDetector(
                       onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => mynote(note: filtered_list[index]),));
                       },
                       onLongPress: (){
                        auth.deletenotemessage(context,filtered_list[index]['_id'], false);
                          // getAllNotes();
                       },
                       child: Container(
                         height: 120,
                         width: 150,
                         margin: EdgeInsets.symmetric( horizontal: 2, vertical: 5),
                         padding: EdgeInsets.all(5),
                         decoration: BoxDecoration(
                           color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
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
                               title: Center(child: Text('TITLE: '+filtered_list[index]['Title'],style: TextStyle(fontWeight: FontWeight.bold))),
                             ),
                             Expanded(child: Text(filtered_list[index]['starttime'],maxLines: 2, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),)),
                               // Text(filtered_list[index]['time'],),
                           ],
                         ),
                       ),
                          );
                    })
                  )

            ],
          )
        )
          


    );
  }
}

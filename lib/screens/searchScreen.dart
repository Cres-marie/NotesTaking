import 'package:flutter/material.dart';
import 'package:notestaking/constants.dart';

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

      body: Padding(
        padding: bpadding,
        child: Column(
          children: [
            Container(
              margin: bmargintop,
              padding: bpadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      
                  Text('Notes', style: bheadings),
      
                  SizedBox(height: 24,),
      
                  TextField(
                    controller: controller,
                    onChanged: (value){
                      Searchnote(value);
                    },
                    
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.green,),
                      hintText: 'Search for note',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),    
                      )
                    ),
                  ),
                ],
              )
            ),
            Expanded(
                    child: ListView.builder(
                      itemCount: filtered_list.length,
                       scrollDirection: Axis.vertical,
                      itemBuilder: (context, index){
                        return GestureDetector(
                       onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => mynote(note: filtered_list[index]),));
                       },
                       onLongPress: (){
                          auth.deletenotemessage(context,filtered_list[index]['_id']);
                          getAllNotes();
                       },
                       child: Container(
                         height: 120,
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
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             ListTile(
                               splashColor: Colors.black,
                               style: ListTileStyle.drawer,
                               title: Center(child: Text('TITLE: '+filtered_list[index]['Title'],style: TextStyle(fontWeight: FontWeight.bold))),
                             ),
                             Expanded(child: Text(filtered_list[index]['notes'],maxLines: 2, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),)),
                                Text(filtered_list[index]['time'],),
                           ],
                         ),
                       ),
                          );
                    })
                  )
          ],
        ),
      )
    );
  }
}

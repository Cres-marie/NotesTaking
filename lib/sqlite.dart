
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
class sqlite{
        static final _dbname = 'mynotes.db';
        static final _dbversion = 2;
        static final table = 'mynotes';
        static final columnid = '_id';
        static final Title = 'Title';
        static final notes = 'notes';
        static final dateplustime = 'time';

        static final eventtable = 'events';
        static final eventcolumnid = '_id';
        static final eventTitle = 'Title';
        static final starttime = 'starttime';
        static final eventtime = 'eventtime';
        final itemsFromAweekAgo = DateTime.now().subtract(Duration(days: 7));
        //static final dateAndtime = DateFormat('yyyy-MM-dd - kk:mm:ss').format(DateTime.now());
        static Database? _db;
        Future<Database> get database async {
          if(_db != null) return _db!;
          _db = await _initdatabase();
          return _db!;
        }

        Future<Database> _initdatabase() async{
          final documentdirectory = await getApplicationDocumentsDirectory();
          final path = join(documentdirectory.path, _dbname);
          print("The pathhhhhhhhh::::: $path");
          return await openDatabase(path,version: _dbversion,onCreate: _create);
        }
        Future<void> _create(Database db, int version) async {
          await db.execute('''
                    CREATE TABLE $table (
                      $columnid INTEGER PRIMARY KEY,
                      $Title TEXT NULL,
                      $notes TEXT NULL,
                      $dateplustime TEXT NOT NULL
                    )

              ''');
              await db.execute('''
                    CREATE TABLE $eventtable (
                      $eventcolumnid INTEGER PRIMARY KEY,
                      $eventTitle TEXT NOT NULL,
                      $eventtime TEXT NULL,
                      $starttime TEXT NULL
                    )

              ''');
        }
        Future<int> insertdata(String myTitle,String note) async{
          final db = await database;
          return await db.insert(table,{
            Title: myTitle,
            notes: note,
            dateplustime: DateFormat('dd-MMM-yyyy kk:mm:ss a').format(DateTime.now()),
          });
        }
         Future<int> insertevent(String myTitle,DateTime Eventtime, DateTime start) async{
          final db = await database;
          return await db.insert(eventtable,{
            eventTitle: myTitle,
            eventtime: Eventtime.toString(),
            starttime: DateFormat('dd-MMM-yyyy kk:mm:ss a').format(start),
          });
        }
        Future<List<Map<String,dynamic>>> getdata() async{
          final db = await database;
          return await db.query(table, orderBy: dateplustime+' DESC');
        }
        Future<List<Map<String,dynamic>>> getevents() async{
          final db = await database;
          return await db.query(eventtable, orderBy: starttime+' DESC');
        }
        Future<int> deleteall() async{
          final db = await database;
          return await db.delete(table);
        }
        Future<int> deleterecord(int id) async{
          final db = await database;
          return await db.delete(table, where: '_id=?', whereArgs: [id]);
        }
        Future<bool> update(int id, String note) async{
          final db = await database;
          await db.update(table, {notes: note, dateplustime: DateFormat('dd-MMM-yyyy kk:mm:ss a').format(DateTime.now())}, where: '_id=?', whereArgs: [id]);
          return Future.value(true);
        }
        Future<List<Map<String, dynamic>>> weekAgoNotes() async {
          final db = await database;
          
          final format = DateFormat('dd-MMM-yyyy kk:mm:ss a').format(itemsFromAweekAgo);
          return db.query(table, where: 'time >=?', whereArgs: [format] );
        }
        Future<List<Map<String, dynamic>>> weeksbefore() async {
          final db = await database;
          final itemsFromAweekAgo = DateTime.now().subtract(Duration(days: 7));
          final format = DateFormat('dd-MMM-yyyy kk:mm:ss a').format(itemsFromAweekAgo);
          return db.query(table, where: 'time <=?', whereArgs: [format] );
        }
}
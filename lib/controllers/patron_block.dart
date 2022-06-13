import 'dart:async';

import 'package:path/path.dart';
import '../models/models.dart';
import 'package:sqflite/sqflite.dart';


class Block{
  late Database _database;

  late List<CheckWordsData>checkwordsdata;
  StreamController<List<CheckWordsData>>streamWords=StreamController();
  Stream<List<CheckWordsData>>get chekWodsStream=> streamWords.stream;

  Block() {
    init();
  }
  
  
  Future <void> init()async{
    _database =await openDatabase(
      join(await getDatabasesPath(), "Database_Words.db"),
      onCreate: (db,version){
        db.execute("CREATE TABLE words( word TEXT,answer TEXT)");
      },
      version: 1,
    );

  }



    findCheckWords()async{
    final List<Map<String,dynamic>> mapWords=await _database.rawQuery("SELECT rowid, word, answer FROM words ");
      checkwordsdata=List.generate(mapWords.length, (index) {
      return CheckWordsData(
        mapWords[index]["rowid"],
        mapWords[index]["word"],
        mapWords[index]["answer"]
      ) ;
    } );

     streamWords.sink.add(checkwordsdata);


  }
  Future<void> insertWords(CheckWords words)async{
    await _database.insert("words",words.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  void dispose() {
    streamWords.close();
  }
}


class Check {
  bool check = false;
  StreamController<bool> checkbox = StreamController.broadcast();
  Stream<bool> get checkStream => checkbox.stream;

  Check() {
    print("check inicializado");
    init();
  }

  init() {
    checkbox.add(check);
  }

  void dispose() {
    checkbox.close();
  }
}

class BlockAppbar {
  bool appbar = false;
  StreamController<bool> controappbar = StreamController.broadcast();

  Stream<bool> get appbarstream => controappbar.stream;

  BlockAppbar(){
    init();
  }



  Providerappbar() {
    init();
  }

  init() {
    controappbar.sink.add(appbar);
  }

  void dispose() {
    controappbar.close();
  }
}
BlockAppbar blockAppbar = BlockAppbar();
Check check=Check();
Block blocks=Block();
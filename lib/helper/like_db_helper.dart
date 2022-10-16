import 'dart:convert';

import 'package:path/path.dart';
import 'package:quotes_app/modal/like_modal.dart';
import 'package:sqflite/sqflite.dart';

import '../modal/imageList.dart';
import '../modal/quotes_modal.dart';

class LikeDbHelper {
  LikeDbHelper._();

  static LikeDbHelper likeDbHelper = LikeDbHelper._();

  String Dbparth = "";
  Database? db;
  String table = "like";

  Future<Database?> inttDB() async {
    String path = await getDatabasesPath();
    Dbparth = join(path, "likeData.db");

    db = await openDatabase(Dbparth, version: 1,
        onCreate: (Database db, version) async {
          String query =
              "CREATE TABLE IF NOT EXISTS $table(id INTEGER PRIMARY KEY AUTOINCREMENT,quote TEXT,image BLOB);";
          await db.execute(query);
          print("Table create ==> $db");
        });
    String query =
        "CREATE TABLE IF NOT EXISTS $table(id INTEGER PRIMARY KEY AUTOINCREMENT,quote TEXT,image BLOB);";
    await db!.execute(query);
    return db;
  }

  Future insertlikeData({required String quotes,required String image}) async {
    //await deletData();

    db = await inttDB();
    // for (Quotes value in quotesDataList) {
    //   String query = "INSERT INTO $table VALUES(?,?,?,?,?)";
    //   List args = [
    //     null,
    //     "${value.quote}",
    //     "${value.author}",
    //     "${value.category}",
    //     "${value.image}",
    //
    //   ];
    //   int? id = await db?.rawInsert(query, args);
    //   print(" insert ==> $id");
    // }


      String query = "INSERT INTO $table VALUES(?,?,?)";
      List args = [
        null,
        quotes,
        image,
      ];
      int? id = await db?.rawInsert(query, args);
       print(" insert ==> $id");
      //print("${quotesDataList.length}");
      print(" quotes ==> ${quotes}");
      print(" quotes ==> ${image}");
      // print(" author ==> ${value.author}");
      // print(" category ==> ${value.category}");
      // print(" Allimage ==> ${AllQuotesImage[i]}");

    }


  Future<List<Like>>fetchlikeData() async {
    db = await inttDB();
    String query = "SELECT * FROM $table";
    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<Like> quoteData = likeFromJson(jsonEncode(data));

    print("[[[[[[[[[[[[[[[[[[[[ ==> ${data.length}");
    print("[[[[[[[[[[[[[[[[[[[[ ==> ${quoteData[0].quote}");
    // print("object ==> ${data[10]}");
    // print("object ==> ${data[11]}");
    // print("object ==> ${data[12]}");
    // print("object ==> ${data[13]}");
    // print("object ==> ${quoteData[1].image}");

    return quoteData;
  }
  // Future<List<Quotes>> likecategory({required String val}) async {
  //   db = await inttDB();
  //
  //   String query = "SELECT * FROM $table WHERE category LIKE '%$val%';";
  //
  //   List<Map<String, dynamic>> res = await db!.rawQuery(query);
  //
  //   List<Quotes> search = quotesFromJson(jsonEncode(res));
  //
  //   return search;
  // }
  deletData({required String id}) async {
    db = await inttDB();
    String query = "DELETE FROM $table WHERE id=$id";
    // print(" =>>>>>>>>>>>>>>> ${}");
    return await db!.rawDelete(query);
  }
}

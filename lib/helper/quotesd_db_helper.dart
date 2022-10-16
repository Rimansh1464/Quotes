import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modal/imageList.dart';
import '../modal/quotes_modal.dart';

class QuotesDbHelper {
  QuotesDbHelper._();

  static QuotesDbHelper quotesDbHelper = QuotesDbHelper._();

  String DBparth = "";
  Database? db;
  String table = "quotes";

  Future<Database?> inttDB() async {
    String path = await getDatabasesPath();
    DBparth = join(path, "quotesData.db");

    db = await openDatabase(DBparth, version: 1,
        onCreate: (Database db, version) async {
      String query =
          "CREATE TABLE IF NOT EXISTS $table(id INTEGER PRIMARY KEY AUTOINCREMENT,quote TEXT,author TEXT,category TEXT,image BLOB);";
      await db.execute(query);
      print("Table create ==> $db");
    });
    String query =
        "CREATE TABLE IF NOT EXISTS $table(id INTEGER PRIMARY KEY AUTOINCREMENT,quote TEXT,author TEXT,category TEXT,image BLOB);";
    await db!.execute(query);
    return db;
  }

  Future insertData(List<Quotes> quotesDataList) async {
    await deletData();

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
    int i = 0;

    while (i < quotesDataList.length) {
      Quotes value = quotesDataList[i];
      String query = "INSERT INTO $table VALUES(?,?,?,?,?)";
      List args = [
        null,
        "${value.quote}",
        "${value.author}",
        "${value.category}",
        (AllQuotesImage[i]),
      ];
      int? id = await db?.rawInsert(query, args);
      // print(" insert ==> $id");
      // print("${quotesDataList.length}");
      // print(" quotes ==> ${value.quote}");
      // print(" author ==> ${value.author}");
      // print(" category ==> ${value.category}");
      // print(" Allimage ==> ${AllQuotesImage[i]}");
      i++;

    }
i=0;
  }

  Future<List<Quotes>>fetchData() async {
    db = await inttDB();
    String query = "SELECT * FROM $table";
    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<Quotes> quoteData = quotesFromJson(jsonEncode(data));

    print("object ==> ${data.length}");
    print("object ==> ${quoteData[1].quote}");
    // print("object ==> ${data[10]}");
    // print("object ==> ${data[11]}");
    // print("object ==> ${data[12]}");
    // print("object ==> ${data[13]}");
    // print("object ==> ${quoteData[1].image}");

    return quoteData;
  }
  Future<List<Quotes>> likecategory({required String val}) async {
    db = await inttDB();

    String query = "SELECT * FROM $table WHERE category LIKE '%$val%';";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<Quotes> search = quotesFromJson(jsonEncode(res));

    return search;
  }
  deletData() async {
    db = await inttDB();
    String query = "DROP TABLE $table ";
    await db!.execute(query).then((value) {
      print("$table ==> Delete Table");
    });
  }
}

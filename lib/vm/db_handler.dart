import 'package:must_eat_place_app/model/review.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/* 
    Description : local db viewmodel
    Author 		: Lcy
    Date 			: 2024.04.06
*/

class DatabaseHandler {

  Future<Database> initalizeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'musteat.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE musteatplace '
          '(seq integer primary key autoincrement,'
          'name text(30),'
          'phone text(30),'
          'lat numeric(20),'
          'long numeric(20),'
          'image blob,'
          'estimate text,'
          'initdate date)'
        );
      },
      version: 1,
    );
  }

  Future<List<Review>> queryReview() async {
    final Database db = await initalizeDB();
    final List<Map<String, Object?>> result = await db.rawQuery('SELECT * FROM musteatplace');

    return result.map((e) => Review.fromMap(e)).toList();
  }

  Future<int> insertReview(Review review) async {
    final Database db = await initalizeDB();
    int result;
    result = await db.rawInsert(
      'INSERT INTO musteatplace '
      '(name,phone,lat,long,image,estimate,initdate) '
      'VALUES (?,?,?,?,?,?,?)',
      [review.name, review.phone, review.lat, review.long, review.image, review.estimate, review.initdate]
    );
    return result;
  }

  Future<int> updateReview(Review review) async {
    final Database db = await initalizeDB();
    int result;
    result = await db.rawInsert(
      'UPDATE musteatplace SET '
      'name=?, phone=?, lat=?, long=?, image=?, estimate=? '
      'WHERE seq=?',
      [review.name, review.phone, review.lat, review.long, review.image, review.estimate, review.seq]
    );
    return result;
  }

  Future<void> deleteReview(int? seq) async {
    final Database db = await initalizeDB();
    await db.rawDelete(
      'DELETE FROM musteatplace '
      'WHERE seq = ?',
      [seq]
    );
  }

}
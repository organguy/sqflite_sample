import 'package:sqflite_sample/models/sample_data.dart';
import 'package:sqflite_sample/repository/sql_database.dart';
import 'package:sqflite_sample/utils/data_util.dart';

class SqlRepository{
  static Future<SampleData> create(SampleData sample) async{
    var db = await SqlDatabase().database;
    var id = await db.insert(SampleData.tableName, sample.toJson());
    return sample.clone(id: id);
  }

  static Future<List<SampleData>> getList() async{
    var db = await SqlDatabase().database;
    var result = await db.query(
      SampleData.tableName,
      columns: [
        SampleFileds.id,
        SampleFileds.name,
        SampleFileds.yn,
        SampleFileds.createdAt,
      ]
    );

    return result.map((data){
      return SampleData.fromJson(data);
    }).toList();
  }

  static Future<SampleData?> getData(int id) async{
    try{
      var db = await SqlDatabase().database;
      var result = await db.query(
          SampleData.tableName,
          columns: [
            SampleFileds.id,
            SampleFileds.name,
            SampleFileds.value,
            SampleFileds.yn,
            SampleFileds.createdAt,
          ],
          where: '${SampleFileds.id} = ?',
          whereArgs: [id,]
      );

      var datas =  result.map((data){
        return SampleData.fromJson(data);
      }).toList();

      if(datas.isNotEmpty){
        return datas.first;
      }else{
        return null;
      }
    }catch(e){
      print(e.toString());
    }
    return null;
  }

  static Future<int> updateData(int id) async{
    var sample = await getData(id);

    if(sample != null){

      double value = DataUtils.makeValue();

      var updateSample = sample.clone(
          value: value,
          yn: value.toInt() % 2 == 0,
      );

      var db = await SqlDatabase().database;
      return await db.update(
          SampleData.tableName,
          updateSample.toJson(),
          where: '${SampleFileds.id} = ?',
          whereArgs: [id,]
      );
    }else{
      return -1;
    }
  }

  static Future<int> deleteData(int id) async{
    var db = await SqlDatabase().database;
    return await db.delete(
        SampleData.tableName,
        where: '${SampleFileds.id} = ?',
        whereArgs: [id,]
    );
  }
}
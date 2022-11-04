import 'package:flutter/material.dart';
import 'package:sqflite_sample/models/sample_data.dart';
import 'package:sqflite_sample/repository/sql_repository.dart';
import 'package:sqflite_sample/screens/detail_screen.dart';
import 'package:sqflite_sample/utils/data_util.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Widget _sampleOne(SampleData sample){
    return GestureDetector(
      onTap: () async{
        await Navigator.push(context, MaterialPageRoute(builder: (context){
          return DetailScreen(id: sample.id!);
        }));
        update();
      },
      child: Container(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: sample.yn ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(width: 7,),
                Text(sample.name),
              ],
            ),
            const SizedBox(height: 7,),
            Text(
              sample.createdAt.toIso8601String(),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _createRandomSample() async{

    double value = DataUtils.makeValue();

    var sample = SampleData(
      name: DataUtils.makeUUID(),
      yn: value % 2 == 0,
      value: value,
      createdAt: DateTime.now(),
    );

    await SqlRepository.create(sample);
    update();
  }

  void update() => setState(() {});

  Future<List<SampleData>> _loadSampleList() async{
    return await SqlRepository.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqflite Sample'),
      ),
      body: FutureBuilder<List<SampleData>>(
        future: _loadSampleList(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Center(
              child: Text('Not Support Sqflite'),
            );
          }

          if(snapshot.hasData){
            var datas = snapshot.data;
            return ListView(
              children: List.generate(datas!.length, (index) => _sampleOne(datas[index])),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createRandomSample,
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite_sample/models/sample_data.dart';
import 'package:sqflite_sample/repository/sql_repository.dart';

class DetailScreen extends StatefulWidget {

  final int id;

  const DetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  Future<SampleData?> getData() async{
    return await SqlRepository.getData(widget.id);
  }

  void updateData() async{
    await SqlRepository.updateData(widget.id);
    update();
  }

  void deleteData() async{
    await SqlRepository.deleteData(widget.id);

    if(!mounted) return;
    Navigator.pop(context);
  }

  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<SampleData?>(
          future: getData(),
          builder: (context, snapshot){

            if(snapshot.hasError){
              return const Center(
                child: Text('Database Has Error!!!'),
              );
            }

            if(snapshot.hasData){
              var data = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'name : ${data!.name}',
                    style: const TextStyle(
                        fontSize: 15
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    'Y/N : ${data.yn}',
                    style: const TextStyle(
                        fontSize: 15
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    'value : ${data.value}',
                    style: const TextStyle(
                        fontSize: 15
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    'createdAt : ${data.createdAt.toIso8601String()}',
                    style: const TextStyle(
                        fontSize: 15
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: updateData,
                    child: const Text('업데이트 랜덤 값'),
                  ),
                  ElevatedButton(
                    onPressed: deleteData,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red
                    ),
                    child: const Text('삭제'),
                  )
                ],
              );
            }else{
              return Center(
                child: Text('Not Found Data By ${widget.id}'),
              );
            }
          }
        ),
      ),
    );
  }
}

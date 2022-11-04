import 'dart:math';

import 'package:uuid/uuid.dart';

class DataUtils{
  static String makeUUID(){
    return const Uuid().v1();
  }
  
  static double makeValue(){
    return Random().nextInt(100) / 3;
  }
}
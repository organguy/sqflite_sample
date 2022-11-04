
class SampleFileds{
  static const String id = 'id';
  static const String name = 'name';
  static const String yn = 'yn';
  static const String value = 'value';
  static const String createdAt = 'createdAt';
}


class SampleData{
  static String tableName = 'sample_table';
  final int? id;
  final String name;
  final bool yn;
  final double value;
  final DateTime createdAt;

  SampleData({
    this.id,
    required this.name,
    required this.yn,
    required this.value,
    required this.createdAt
  });

  Map<String, dynamic?> toJson(){
    return {
      SampleFileds.id : id,
      SampleFileds.name : name,
      SampleFileds.yn : yn ? 1 : 0,
      SampleFileds.value : value,
      SampleFileds.createdAt : createdAt.toIso8601String(),
    };
  }

  factory SampleData.fromJson(Map<String, dynamic> json){
    return SampleData(
        id: json[SampleFileds.id] as int?,
        name: json[SampleFileds.name] == null
              ? ''
              : json[SampleFileds.name] as String,
        yn: json[SampleFileds.yn] == null
              ? true
              : json[SampleFileds.yn] == 1,
        value: json[SampleFileds.value] == null
              ? 0
              : json[SampleFileds.value] as double,
        createdAt: json[SampleFileds.createdAt] == null
              ? DateTime.now()
              : DateTime.parse(json[SampleFileds.createdAt] as String),
    );
  }

  SampleData clone({
    int? id,
    String? name,
    bool? yn,
    double? value,
    DateTime? createdAt,
  }){
    return SampleData(
        id: id ?? this.id,
        name: name ?? this.name,
        yn: yn ?? this.yn,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
    );
  }
}
import 'package:json_annotation/json_annotation.dart';

part 'StudentList.g.dart';

// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class StudentList extends Object {
  // 为了绑定 json 中的 key
  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'list')
  List<Student> list;

  @JsonKey(name: 'msg')
  String msg;

  StudentList(
    this.code,
    this.list,
    this.msg,
  );

  factory StudentList.fromJson(Map<String, dynamic> srcJson) =>
      _$StudentListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StudentListToJson(this);
}

@JsonSerializable()
class Student extends Object {
  @JsonKey(name: 'studentName')
  String studentName;

  @JsonKey(name: 'studentId')
  int studentId;

  @JsonKey(name: 'studentAge')
  int studentAge;

  Student(
    this.studentName,
    this.studentId,
    this.studentAge,
  );

  factory Student.fromJson(Map<String, dynamic> srcJson) =>
      _$StudentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}

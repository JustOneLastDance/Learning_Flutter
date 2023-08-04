// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StudentList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentList _$StudentListFromJson(Map<String, dynamic> json) => StudentList(
      json['code'] as String,
      (json['list'] as List<dynamic>)
          .map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['msg'] as String,
    );

Map<String, dynamic> _$StudentListToJson(StudentList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
    };

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      json['studentName'] as String,
      json['studentId'] as int,
      json['studentAge'] as int,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'studentName': instance.studentName,
      'studentId': instance.studentId,
      'studentAge': instance.studentAge,
    };

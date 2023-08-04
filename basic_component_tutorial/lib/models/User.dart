import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'User.g.dart';

/*
* 以json_serializable的方式创建model类
*
* */

/// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class User {
  User(this.name, this.email);

  String name;
  String email;

  // 不同的类使用不同的mixin即可
  // 用于从一个 map 构造出一个 User实例 map 结构
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  // 一个toJson 方法, 将 User 实例转化为一个 map。
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

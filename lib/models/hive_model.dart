import 'package:hive/hive.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 1)
class HiveModel {
  @HiveField(2)
  String input;
  @HiveField(3)
  String output;
  @HiveField(4)
  DateTime createdAt;
  HiveModel({
    required this.output,
    required this.input,
    required this.createdAt
  });
}
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class AvengerBO {
  int? id;
  String? name;
  AvengerBO({required this.id, required this.name});
}

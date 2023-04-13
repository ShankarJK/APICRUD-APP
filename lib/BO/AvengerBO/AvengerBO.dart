import 'package:dart_json_mapper/dart_json_mapper.dart';

// Make the AvengerBO class as jsonSerializable
@jsonSerializable

// Create a class AvengerBO
class AvengerBO {

  // Create a variable id with Datatype as  int and make it as nullable variable
  int? id;

  // Create a variable name with Datatype as String and make it as nullable variable
  String? name;

  /* Declare a constructor AvengerBO with required parameter id and name */
  AvengerBO({required this.id, required this.name});
}

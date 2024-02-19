import 'package:uuid/uuid.dart';

class Uuids{
  String generateUniqueId(){
    var uuid = Uuid();
    return uuid.v4();
  }
}

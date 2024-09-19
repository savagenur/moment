import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';

enum PhotoType {
  clothes("clothes"),
  startWorkPlace("startWorkPlace"),
  startCamera("startCamera"),
  startLaptop("startLaptop"),
  startWires("startWires"),
  none("none");

  final String text;

  const PhotoType(this.text);
}

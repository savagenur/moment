
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment/core/enums/shift_status.dart';

class ShiftStatusConverter  extends JsonConverter<ShiftStatus?,String?>{
  const ShiftStatusConverter();
  @override
  ShiftStatus? fromJson(String? json) {
   if (json == null) return null;

    return ShiftStatus.fromJson(json); 
  }

  @override
  String? toJson(ShiftStatus? object) {
    return object?.toJson();
  }
}
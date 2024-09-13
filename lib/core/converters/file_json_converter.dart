import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

class FileJsonConverter  extends JsonConverter<File?,String?>{
  const FileJsonConverter();
  @override
  File? fromJson(String? json) {
   if (json == null) return null;
    return File(json); 
  }

  @override
  String? toJson(File? object) {
    return object?.path;
  }
}
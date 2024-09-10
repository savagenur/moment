// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'user_model.freezed.dart';
// part 'user_model.g.dart';

// @freezed
// class UserModel with _$UserModel {
//   const factory UserModel({
//     final String? id,
//     final String? role,
//     final List<String>? shifts,
//     final List<String>? restaurants,
//     final String? email,
//     final String? name,
//     final String? username,
//     @JsonKey(
//       includeFromJson: false,
//       includeToJson: false,
//     )
//     final String? password,
//   }) = _UserModel;

//   factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(
//         json,
//       );
// }
//  "name": "Restaurant A",
//     "location": "123 Main Street, Houston, TX",
//     "photos": ["photoId1", "photoId2"],  // List of photo document references
//     "shifts": ["shiftId1", "shiftId2"],  // List of shifts associated with the restaurant
//     "totalPhotos": 200,  // Total photos taken at this restaurant
//     "totalPhotosSold": 100 
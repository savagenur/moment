import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';

enum SnapperShiftPhotoType {
  clothes,
  startWorkPlace,
  startCamera,
  startLaptop,
  startWires,
  none;

  PhotoModel? getPhoto(SnapperShift? shift) {
    return switch (this) {
      SnapperShiftPhotoType.clothes => shift?.clothesPhoto,
      SnapperShiftPhotoType.startWorkPlace => shift?.startWorkPlacePhoto,
      SnapperShiftPhotoType.startCamera => shift?.startCameraPhoto,
      SnapperShiftPhotoType.startLaptop => shift?.startLaptopPhoto,
      SnapperShiftPhotoType.startWires => shift?.startWiresPhoto,
      SnapperShiftPhotoType.none => null,
    };
  }

  SnapperShift? updateShiftWithPhoto(SnapperShift? shift, PhotoModel? newPhoto) =>
      switch (this) {
        SnapperShiftPhotoType.clothes =>
          shift?.copyWith(clothesPhoto: newPhoto),
        SnapperShiftPhotoType.startWorkPlace =>
          shift?.copyWith(startWorkPlacePhoto: newPhoto),
        SnapperShiftPhotoType.startCamera =>
          shift?.copyWith(startCameraPhoto: newPhoto),
        SnapperShiftPhotoType.startLaptop =>
          shift?.copyWith(startLaptopPhoto: newPhoto),
        SnapperShiftPhotoType.startWires =>
          shift?.copyWith(startWiresPhoto: newPhoto),
        SnapperShiftPhotoType.none => null,
      };
}

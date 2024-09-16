import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';

enum SnapperShiftPhotoType {
  clothes("clothes"),
  startWorkPlace("startWorkPlace"),
  startCamera("startCamera"),
  startLaptop("startLaptop"),
  startWires("startWires"),
  none("none");

  final String text;

  const SnapperShiftPhotoType(this.text);
  PhotoModel? getPhoto(SnapperShift? shift) {
    return switch (this) {
      SnapperShiftPhotoType.clothes => shift?.startReportModel?.clothesPhoto,
      SnapperShiftPhotoType.startWorkPlace => shift?.startReportModel?.startWorkPlacePhoto,
      SnapperShiftPhotoType.startCamera => shift?.startReportModel?.startCameraPhoto,
      SnapperShiftPhotoType.startLaptop => shift?.startReportModel?.startLaptopPhoto,
      SnapperShiftPhotoType.startWires => shift?.startReportModel?.startWiresPhoto,
      SnapperShiftPhotoType.none => null,
    };
  }

  SnapperShift? updateShiftWithPhoto(
          SnapperShift? shift, PhotoModel? newPhoto) =>
      switch (this) {
        SnapperShiftPhotoType.clothes =>
          shift?.copyWith(startReportModel: shift.startReportModel?.copyWith(clothesPhoto: newPhoto)),
        SnapperShiftPhotoType.startWorkPlace =>
          shift?.copyWith(startReportModel: shift.startReportModel?.copyWith(startWorkPlacePhoto: newPhoto)),
        SnapperShiftPhotoType.startCamera =>
          shift?.copyWith(startReportModel: shift.startReportModel?.copyWith(startCameraPhoto: newPhoto)),
        SnapperShiftPhotoType.startLaptop =>
          shift?.copyWith(startReportModel: shift.startReportModel?.copyWith(startLaptopPhoto: newPhoto)),
        SnapperShiftPhotoType.startWires =>
          shift?.copyWith(startReportModel: shift.startReportModel?.copyWith(startWiresPhoto: newPhoto)),
        SnapperShiftPhotoType.none => null,
      };
}

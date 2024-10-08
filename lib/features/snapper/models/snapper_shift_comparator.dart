import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/core/generics/data_source_comparator.dart';
import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';

class SnapperShiftComparator extends DataSourceComparator<SnapperShift> {
  SnapperShiftComparator({
    super.local,
    super.remote,
  });
  SnapperShift? getLatestShift() {
    return getLatestItem(
      (shift) => shift?.createdAt ?? DateTime(0),
    );
  }

  PhotoModel? getLatestPhoto(SnapperShiftPhotoType shiftPhotoType) {
  PhotoModel? getPhoto(SnapperShift? shift) => switch (shiftPhotoType) {
    SnapperShiftPhotoType.clothes => shift?.startReportModel?.clothesPhoto,
    SnapperShiftPhotoType.startWorkPlace => shift?.startReportModel?.startWorkPlacePhoto,
    SnapperShiftPhotoType.startCamera => shift?.startReportModel?.startCameraPhoto,
    SnapperShiftPhotoType.startLaptop => shift?.startReportModel?.startLaptopPhoto,
    SnapperShiftPhotoType.startWires => shift?.startReportModel?.startWiresPhoto,
    SnapperShiftPhotoType.none => null,
  };

  final shift = getLatestItem(
    (shift) => getPhoto(shift)?.createdAt ?? DateTime(0),
  );

  return getPhoto(shift);
}

}

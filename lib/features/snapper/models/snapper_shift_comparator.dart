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
      (shift) => shift?.updatedAt ?? DateTime(0),
    );
  }

  PhotoModel? getLatestPhoto(PhotoType shiftPhotoType) {
    PhotoModel? getPhoto(SnapperShift? shift) => switch (shiftPhotoType) {
          PhotoType.clothes => shift?.shiftStart?.clothesPhoto,
          PhotoType.startWorkPlace => shift?.shiftStart?.startWorkPlacePhoto,
          PhotoType.startCamera => shift?.shiftStart?.startCameraPhoto,
          PhotoType.startLaptop => shift?.shiftStart?.startLaptopPhoto,
          PhotoType.startWires => shift?.shiftStart?.startWiresPhoto,
          PhotoType.none => null,
        };

    final shift = getLatestItem(
      (shift) => getPhoto(shift)?.createdAt ?? DateTime(0),
    );

    return getPhoto(shift);
  }
}

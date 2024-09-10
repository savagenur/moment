import 'package:moment/features/shift/models/shift_model.dart';

class ShiftStatusList {
  final List<ShiftModel> activeShifts;
  final List<ShiftModel> inactiveShifts;

  const ShiftStatusList(this.activeShifts, this.inactiveShifts);
}

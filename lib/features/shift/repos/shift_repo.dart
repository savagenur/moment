import 'package:moment/core/utils.dart';
import 'package:moment/features/shift/models/shift_model.dart';

class ShiftRepo {
  Stream<List<ShiftModel>> getSnapperShiftList({required int status}) {
    return firestore
        .collection("shifts")
        .where("status", isEqualTo: status)
        .orderBy("startTime", descending: true)
        .snapshots()
        .map(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          // Assuming you're interested in the first shift found
          return snapshot.docs.map(
            (e) {
              return SnapperShift.fromJson(e.data());
            },
          ).toList();
        } else {
          // Handle the case when no shift with status 1 is found
          return const [];
        }
      },
    );
  }

  Future<void> createShift(ShiftModel shift) async {
    try {
      await firestore.collection("shifts").doc().set(shift.toJson());
    } catch (e) {
      logger.e(e.toString());
    }
  }
}

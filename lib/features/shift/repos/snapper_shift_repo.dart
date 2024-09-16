import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/core/utils.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/app/repos/database/database_helper.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/models/snapper_start_report/snapper_start_report_model.dart';
import 'package:sqflite/sqflite.dart';

class SnapperShiftRepo {
  Stream<List<SnapperShift>> getSnapperShiftList({required int status}) {
    return firestore
        .collection("shifts")
        .where("status", isEqualTo: status)
        .orderBy("startTime", descending: false)
        .snapshots()
        .map(
      (snapshot) {
        // print('Firestore snapshot received for status: $status');
        if (snapshot.docs.isNotEmpty) {
          return snapshot.docs.map(
            (e) {
              return SnapperShift.fromJson(e.data());
            },
          ).toList();
        } else {
          return const [];
        }
      },
    );
  }

  Future<void> createShift(SnapperShift shift) async {
    try {
      await firestore.collection("shifts").doc(shift.id).set(shift.toJson());
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> updateShift(SnapperShift shift) async {
    try {
      final startReport = shift.startReportModel;

      final updatedStartReport = StartReportModel.forFirestore(startReport);

      final updatedShift = shift.copyWith(startReportModel: updatedStartReport);

      await firestore.collection("shifts").doc(shift.id).set(
            updatedShift.toJson(),
            SetOptions(merge: true),
          );
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<String?> uploadMedia(
    File file, {
    required bool isVideo,
    required String shiftId,
    required SnapperShiftPhotoType snapperShiftPhotoType,
  }) async {
    try {
      String filePath =
          "uploads/${isVideo ? "videos" : "images"}/$shiftId/${snapperShiftPhotoType.text}";
      Reference ref = storage.ref().child(filePath);
      UploadTask uploadTask = ref.putFile(file);
      uploadTask.snapshotEvents.listen(
        (snapshot) {
          double progress =
              (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          print("Upload is $progress complete");
        },
      );
      await uploadTask.whenComplete(
        () => null,
      );
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      logger.e("Error uploading media: $e");
      return null;
    }
  }

  Future<void> setLocalShift(SnapperShift shift) async {
    final db = await sl<DatabaseHelper>().database;
    await db.insert(
      'shift',
      {
        'id': 1,
        'shift_data': jsonEncode(shift.toJson()),
        'runtimeType': "snapper"
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<SnapperShift?> getLocalShift() async {
    final db = await sl<DatabaseHelper>().database;
    // await db.delete("shift");
    List<Map<String, dynamic>> maps = await db.query('shift');
    print(maps.length);
    if (maps.isNotEmpty) {
      return SnapperShift.fromJson(jsonDecode(maps.first['shift_data']));
    }
    return null;
  }
}

ShiftModel fromSql(Map<String, dynamic> json) {
  return ShiftModel.fromJson(json);
}

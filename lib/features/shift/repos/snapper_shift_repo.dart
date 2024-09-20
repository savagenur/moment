import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/core/utils/utils.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';

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

  Future<void> updateShift(SnapperShift? shift) async {
    try {
      if (shift != null) {
        await firestore.collection("shifts").doc(shift.id).set(
              shift.toJson(),
              SetOptions(merge: true),
            );
      }
    } catch (e) {
      logger.e(e.toString());
      throw Exception(e);
    }
  }

  Future<String?> uploadMedia(
    File file, {
    required bool isVideo,
    required String shiftId,
    required PhotoType snapperShiftPhotoType,
  }) async {
    try {
      String filePath =
          "uploads/${isVideo ? "videos" : "images"}/$shiftId/${snapperShiftPhotoType.text}";
      Reference ref = firebaseStorage.ref().child(filePath);
      UploadTask uploadTask = ref.putFile(file);
      uploadTask.snapshotEvents.listen(
        (snapshot) {
          double progress =
              (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          log("Upload is $progress complete");
        },
      );
      await uploadTask.whenComplete(
        () => null,
      );
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      logger.e("Error uploading media: $e");
      throw Exception(e);
    }
  }

  Future<SnapperShift?> getShift(String id) async {
    try {
      final shiftData = await firestore.collection("shifts").doc(id).get();
      final shift = shiftData.data();
      return shift != null ? ShiftModel.fromJson(shift) as SnapperShift? : null;
    } catch (e) {
     throw Exception(e);
    }
  }
}

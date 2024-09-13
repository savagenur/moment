import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moment/core/utils.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/app/repos/database/database_helper.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:sqflite/sqflite.dart';

class SnapperShiftRepo {
  Stream<List<ShiftModel>> getSnapperShiftList({required int status}) {
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
       await firestore
            .collection("shifts")
            .doc(shift.id)
            .set(shift.toJson());
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> updateShift(SnapperShift shift) async {
    try {
       await firestore.collection("shifts").doc(shift.id).set(
            shift.toJson(),
            SetOptions(
              merge: true,
            ));
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> setLocalShift(ShiftModel shift) async {
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

  Future<ShiftModel?> getLocalShift() async {
    final db = await sl<DatabaseHelper>().database;
    // await db.delete("shift");
    List<Map<String, dynamic>> maps = await db.query('shift');
    print(maps.length);
    if (maps.isNotEmpty) {
      return ShiftModel.fromJson(jsonDecode(maps.first['shift_data']));
    }
    return null;
  }
}

ShiftModel fromSql(Map<String, dynamic> json) {
  return ShiftModel.fromJson(json);
}

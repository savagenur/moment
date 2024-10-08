// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:moment/features/auth/views/sign_in/sign_in_page.dart' as _i1;
import 'package:moment/features/shift/models/shift/shift_model.dart' as _i9;
import 'package:moment/features/snapper/views/navigation/snapper_navigation/snapper_navigation_page.dart'
    as _i2;
import 'package:moment/features/snapper/views/shift_end/snapper_shift_end_page.dart'
    as _i3;
import 'package:moment/features/snapper/views/shift_process/shift_process_page.dart'
    as _i4;
import 'package:moment/features/snapper/views/shift_start/snapper_shift_start_page.dart'
    as _i5;
import 'package:moment/features/snapper/views/shift_start_report/snapper_shift_start_report_page.dart'
    as _i6;

/// generated route for
/// [_i1.SignInPage]
class SignInRoute extends _i7.PageRouteInfo<void> {
  const SignInRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.SignInPage();
    },
  );
}

/// generated route for
/// [_i2.SnapperNavigationPage]
class SnapperNavigationRoute extends _i7.PageRouteInfo<void> {
  const SnapperNavigationRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SnapperNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'SnapperNavigationRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.SnapperNavigationPage();
    },
  );
}

/// generated route for
/// [_i3.SnapperShiftEndPage]
class SnapperShiftEndRoute extends _i7.PageRouteInfo<void> {
  const SnapperShiftEndRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SnapperShiftEndRoute.name,
          initialChildren: children,
        );

  static const String name = 'SnapperShiftEndRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.SnapperShiftEndPage();
    },
  );
}

/// generated route for
/// [_i4.SnapperShiftProcessPage]
class SnapperShiftProcessRoute extends _i7.PageRouteInfo<void> {
  const SnapperShiftProcessRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SnapperShiftProcessRoute.name,
          initialChildren: children,
        );

  static const String name = 'SnapperShiftProcessRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.SnapperShiftProcessPage();
    },
  );
}

/// generated route for
/// [_i5.SnapperShiftStartPage]
class SnapperShiftStartRoute
    extends _i7.PageRouteInfo<SnapperShiftStartRouteArgs> {
  SnapperShiftStartRoute({
    _i8.Key? key,
    required _i9.ShiftModel shiftRemote,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          SnapperShiftStartRoute.name,
          args: SnapperShiftStartRouteArgs(
            key: key,
            shiftRemote: shiftRemote,
          ),
          initialChildren: children,
        );

  static const String name = 'SnapperShiftStartRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SnapperShiftStartRouteArgs>();
      return _i5.SnapperShiftStartPage(
        key: args.key,
        shiftRemote: args.shiftRemote,
      );
    },
  );
}

class SnapperShiftStartRouteArgs {
  const SnapperShiftStartRouteArgs({
    this.key,
    required this.shiftRemote,
  });

  final _i8.Key? key;

  final _i9.ShiftModel shiftRemote;

  @override
  String toString() {
    return 'SnapperShiftStartRouteArgs{key: $key, shiftRemote: $shiftRemote}';
  }
}

/// generated route for
/// [_i6.SnapperShiftStartReportPage]
class SnapperShiftStartReportRoute
    extends _i7.PageRouteInfo<SnapperShiftStartReportRouteArgs> {
  SnapperShiftStartReportRoute({
    _i8.Key? key,
    required _i9.SnapperShift snapperShift,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          SnapperShiftStartReportRoute.name,
          args: SnapperShiftStartReportRouteArgs(
            key: key,
            snapperShift: snapperShift,
          ),
          initialChildren: children,
        );

  static const String name = 'SnapperShiftStartReportRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SnapperShiftStartReportRouteArgs>();
      return _i6.SnapperShiftStartReportPage(
        key: args.key,
        snapperShift: args.snapperShift,
      );
    },
  );
}

class SnapperShiftStartReportRouteArgs {
  const SnapperShiftStartReportRouteArgs({
    this.key,
    required this.snapperShift,
  });

  final _i8.Key? key;

  final _i9.SnapperShift snapperShift;

  @override
  String toString() {
    return 'SnapperShiftStartReportRouteArgs{key: $key, snapperShift: $snapperShift}';
  }
}

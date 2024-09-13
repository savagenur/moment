import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moment/core/constants/toast/toast_types.dart';
import 'package:moment/core/utils.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/app/routes/app_router.gr.dart';
import 'package:moment/features/auth/view_models/auth_viewmodel.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/repos/snapper_shift_repo.dart';
import 'package:moment/features/shift/view_models/snapper/snapper_shift_viewmodel.dart';
import 'package:uuid/uuid.dart';

class SnapperProfilePage extends HookConsumerWidget {
  const SnapperProfilePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewNotifier = ref.read(authViewModelProvider.notifier);
    _authViewModelListener(ref, context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          TextButton(
              onPressed: () {
                sl<SnapperShiftRepo>().createShift(
                  SnapperShift(
                    id: const Uuid().v1(),
                    restaurantId: "1",
                    createdAt: DateTime.now(),
                    restaurantName: "Let's go",
                    startTime: DateTime.now(),
                    status: 1,
                  ),
                );
              },
              child: Text("Create shift"))
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Account"),
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            onTap: () {
              authViewNotifier.signOut();
            },
            title: Text(
              "Log out",
              style: TextStyle(color: Colors.red),
            ),
            trailing: Icon(Icons.logout_outlined, color: Colors.red),
          )
        ],
      ),
    );
  }

  void _authViewModelListener(WidgetRef ref, BuildContext context) {
    ref.listen(
      authViewModelProvider,
      (previous, next) {
        next?.when(
          data: (data) {
            print("object");
            context.router.pushAndPopUntil(
              const SignInRoute(),
              predicate: (route) => false,
            );
          },
          error: (error, stackTrace) => snackBar(context,
              message: error.toString(), toastType: ToastType.failure),
          loading: () => EasyLoading.show(status: "Log out..."),
        );
      },
    );
  }
}

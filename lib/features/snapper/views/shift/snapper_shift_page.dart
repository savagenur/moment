import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moment/features/app/routes/app_router.gr.dart';
import 'package:moment/features/app/routes/guards/auth_guard.dart';
import 'package:moment/features/snapper/views/shift_start/snapper_shift_start_page.dart';

class SnapperShiftPage extends ConsumerWidget {
  const SnapperShiftPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shift"),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () => context.pushRoute(const SnapperShiftStartRoute()),
            title: Text("Start"),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ),
          ListTile(
            onTap: () => context.pushRoute(const SnapperShiftProcessRoute()),
            title: Text("In procces"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ),
          ListTile(
            onTap: () => context.pushRoute(const SnapperShiftEndRoute()),
            title: Text("End"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

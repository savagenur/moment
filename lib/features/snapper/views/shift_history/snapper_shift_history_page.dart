import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SnapperShiftHistoryPage extends ConsumerWidget {
  const SnapperShiftHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My shifts"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          index++;
          return ListTile(
            title: Text("09.0$index.2024"),
            onTap: () {
              
            },
            subtitle: Text("Forget me not"),
          );
        },
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moment/features/snapper/views/shift/snapper_shift_page.dart';
import 'package:moment/features/snapper/views/shift_history/snapper_shift_history_page.dart';

@RoutePage()
class SnapperNavigationPage extends ConsumerStatefulWidget {
  const SnapperNavigationPage({super.key});

  @override
  ConsumerState<SnapperNavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends ConsumerState<SnapperNavigationPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) => setState(
          () => _currentIndex = value,
        ),
        items: _items,
      ),
    );
  }

  List<Widget> get _pages => [
        SnapperShiftPage(),
        SnapperShiftHistoryPage(),
        Container(),
        Container(),
      ];

  List<BottomNavigationBarItem> get _items => const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: "Shift",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
          ),
          label: "My shifts",
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(
        //     Icons.discount,
        //   ),
        //   label: "Мои купоны",
        // ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: "Профиль",
        ),
      ];
}

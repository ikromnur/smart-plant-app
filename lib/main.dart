import 'package:flutter/material.dart';
import 'theme.dart';
import 'state/hydroponic_store.dart';
import 'app_state.dart';
import 'pages/home_page.dart';
import 'pages/account_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final store = HydroponicStore();
    return AppState(
      store: store,
      child: MaterialApp(
        title: 'Smart Plant App',
        theme: appTheme(),
        home: const RootTabs(),
      ),
    );
  }
}

class RootTabs extends StatefulWidget {
  const RootTabs({super.key});
  @override
  State<RootTabs> createState() => _RootTabsState();
}

class _RootTabsState extends State<RootTabs> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const AccountPage(),
    ];
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Akun'),
        ],
        onDestinationSelected: (i) => setState(() => index = i),
      ),
    );
  }
}

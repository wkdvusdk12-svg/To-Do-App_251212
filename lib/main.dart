import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Core/app_theme.dart';
import 'Riverpod/View/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const HomePage(title: '한결`s Tasks'),
    );
  }
}









// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // 머티리얼은 네비게이션바, 앱바, 버튼 등 기본 디자인을 자동으로 관리해줌.
//       // 선언하지 않으면 AppBar, Scaffold, Navigator 등의
//       // 머티리얼 구성요소를 쓸 수 없고, 직접 구현해야 함.

//       debugShowCheckedModeBanner: false,

//       theme: AppTheme.light,
//       darkTheme: AppTheme.dark,
//       themeMode: ThemeMode.system,

//       home: const HomePage(title: '한결`s Tasks'),
//     );
//   }
// }






// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => DetailPage(
// title : "지윤"
// )),
// );
 // if 

// Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage()),
// Navigator.pop(context);


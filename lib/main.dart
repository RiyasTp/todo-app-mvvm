import 'package:flutter/material.dart';
import 'package:interview/features/view/todo_screen.dart';
import 'package:interview/features/view_model/todo_provider.dart';
import 'package:interview/utility/local_storage/hive_utils.dart';
import 'package:interview/utility/messenger/messenger.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageUtils.instance.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: Messenger.rootScaffoldMessengerKey,
        home: const TodoScreen(),
      ),
    );
  }
}

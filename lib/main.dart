import 'package:Calculator/provider/provider.dart';
import 'package:Calculator/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/hive_model.dart';
void main() async{
WidgetsFlutterBinding.ensureInitialized();
final directory=await getApplicationDocumentsDirectory();
Hive.init(directory.path);
Hive.registerAdapter(HiveModelAdapter());
Hive.openBox("history");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Calculator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  MyCalculator(historyInput: "", historyOutput: '',),
      ),
    );
  }
}




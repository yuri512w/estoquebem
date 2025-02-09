import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialize o Hive
  await Hive.initFlutter();

  // Inicialize o banco de dados
  final dbService = DatabaseService();
  await dbService.init();

  runApp(MyApp(dbService: dbService));
}



class MyApp extends StatelessWidget {
  final DatabaseService dbService;

  const MyApp({Key? key, required this.dbService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Produtos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(dbService: dbService),
    );
  }
}

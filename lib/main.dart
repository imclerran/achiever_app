import 'package:achiever_app/screens/home_screen.dart';
import 'package:achiever_app/data/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'bloc/habits/habits_bloc.dart';
import 'bloc/tasks/tasks_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var storage = HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  HydratedBloc.storage = await storage;
  storage.whenComplete(() {
    runApp(AchieverApp());
  });
}

class AchieverApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AchieverAppState createState() => _AchieverAppState();
}

class _AchieverAppState extends State<AchieverApp> {
  HabitsBloc habitsBloc = HabitsBloc()..add(LoadHabits());
  TasksBloc tasksBloc = TasksBloc()..add(LoadTasks());
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.platformBrightnessOf(context);
    var theme = AppTheme(brightness);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: theme.backgroundColor,
    ));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<HabitsBloc>(
          create: (_) => habitsBloc,
        ),
        BlocProvider(
          create: (_) => tasksBloc,
        ),
      ],
      child: MaterialApp(
        title: 'Achiever',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // hintColor: theme.h4.color,
            // disabledColor: theme.h4.color,
            //splashColor: theme.highlightColor,
            //highlightColor: theme.highlightColor,
            ),
        home: HomeScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    habitsBloc.close();
  }
}

import 'package:flutter/material.dart';
import 'package:opt120/screens/activity/activity_screen.dart';
import 'package:opt120/screens/user_activity/user_activity_screen.dart';
import 'package:opt120/screens/users/user_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OPT - 120'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Usuários'),
            Tab(text: 'Atividades'),
            Tab(text: 'Atividade do Usuário'),
          ],
          labelStyle: TextStyle(fontSize: 18.0),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          UserTable(
            users: [],
          ),
          ActivitiesTable(
            activities: [],
          ),
          UserActivitiesTable(
            userActivities: [],
          ),
        ],
      ),
    );
  }
}

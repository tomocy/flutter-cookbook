import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repo = await prepareDogRepository();

  repo.create(const Dog(
    id: 1,
    name: 'alice',
    age: 1,
  ));
  repo.create(const Dog(
    id: 2,
    name: 'bob',
    age: 1,
  ));
  repo.create(const Dog(
    id: 3,
    name: 'cris',
    age: 1,
  ));

  runApp(App(
    repo: repo,
  ));
}

Future<DogRepository> prepareDogRepository() async {
  return SQLiteRepository(openDatabase(
    join(await getDatabasesPath(), 'doggie.db'),
    version: 1,
    onCreate: (db, version) => db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)'),
  ));
}

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.repo,
  })  : assert(repo != null),
        super(key: key);

  final DogRepository repo;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(
        repo: repo,
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({
    Key key,
    @required this.repo,
  })  : assert(repo != null),
        super(key: key);

  final DogRepository repo;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  Future<List<Dog>> _dogs;

  @override
  void initState() {
    super.initState();
    _dogs = widget.repo.list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doggie'),
      ),
      body: FutureBuilder<List<Dog>>(
        future: _dogs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) => ListTile(
                title: Text(snapshot.data[i].name),
                subtitle: Text('${snapshot.data[i].age}'),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.repo.close();
    super.dispose();
  }
}

abstract class DogRepository {
  const DogRepository();

  Future<List<Dog>> list();
  Future<void> create(Dog dog);
  Future<void> close();
}

class SQLiteRepository extends DogRepository {
  const SQLiteRepository(this.db);

  final Future<Database> db;

  Future<List<Dog>> list() async {
    final db = await this.db;
    final dog = await db.query('dogs');

    return dog.map<Dog>((json) => Dog.fromJson(json)).toList();
  }

  Future<void> create(Dog dog) async {
    final db = await this.db;

    return db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> close() async {
    final db = await this.db;

    return db.close();
  }
}

class Dog {
  const Dog({this.id, this.name, this.age});

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'],
      name: json['name'],
      age: json['age'],
    );
  }

  final int id;
  final String name;
  final int age;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'age': age,
      };
}

import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(
        todos: List<Todo>.generate(20, (i) => Todo('Todo $i', 'Do $i')),
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({Key key, this.todos}) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('page'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(
            todos[i].title,
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TodoPage(todo: todos[i]),
            ),
          ),
        ),
      ),
    );
  }
}

class TodoPage extends StatelessWidget {
  const TodoPage({
    Key key,
    @required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }
}

class Todo {
  const Todo(this.title, this.description);

  final String title;
  final String description;
}

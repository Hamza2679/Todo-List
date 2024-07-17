import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> todos = [];
  final TextEditingController controller = TextEditingController();
  int nextId = 0;
  void addTodo() {
    final String text = controller.text;
    if (text.isNotEmpty) {
      setState(() {
          todos.add(Todo(
          id: nextId++,
          title: text,
          completed: false,
        ));
          controller.clear();
      });
    }
  }

  void deleteTodo(int id) {
    setState(() {
      todos.removeWhere((todo) => todo.id == id);
    });
  }

  void todoCompleted(int id) {
    setState(() {
      final todo = todos.firstWhere((todo) => todo.id == id);
      todo.completed = !todo.completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 212, 224),
      appBar: AppBar(
        title: Text('Todo List'),
        backgroundColor: Color.fromARGB(255, 180, 181, 181),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Add a task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addTodo,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: IconButton(
                    color: Colors.blue,
                    icon: Icon(
                      todo.completed ? Icons.check_box : Icons.check_box_outline_blank,
                    ),
                    onPressed: () => todoCompleted(todo.id),
                  ),
                  trailing: IconButton(
                    color: Colors.red,
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteTodo(todo.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Todo {
  final int id;
  final String title;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    this.completed = false,
  });
}

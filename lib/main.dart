import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _pendingTasks = [];
  List<String> _completedTasks = [];

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int completedCount = _completedTasks.length;
    int totalCount = _pendingTasks.length + _completedTasks.length;
    String completionText = '$completedCount/$totalCount';

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter task',
              contentPadding: EdgeInsets.all(20.0),
            ),
            onSubmitted: (text) {
              setState(() {
                _pendingTasks.add(text);
                _controller.clear();
              });
            },
          ),
          Text("pending task", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _pendingTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.check_box_outline_blank),
                    onPressed: () {
                      setState(() {
                        _completedTasks.add(_pendingTasks[index]);
                        _pendingTasks.removeAt(index);
                      });
                    },
                  ),
                  title: Text(_pendingTasks[index]),
                );
              },
            ),
          ),
          Text('Completed Tasks $completionText',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _completedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.check, color: Colors.blue),
                  title: Text(_completedTasks[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

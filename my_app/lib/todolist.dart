import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final TextEditingController _textFieldController =
      TextEditingController(); // TODO: change name? Change to resemble lecture?
  final List<ToDo> _todos = <ToDo>[];

  void _addToDoItem(String name) {
    setState(() {
      _todos.add(
        ToDo(name: name, checked: false),
      );
      _textFieldController.clear();
    });
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new todo item'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your new todo'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addToDoItem(_textFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo list'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map<Widget>((ToDo todo) {
          return ToDoItem(
            todo: todo,
            onToDoChanged: _handleToDoChange,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _displayDialog();
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ToDo {
  ToDo({required this.name, required this.checked});
  final String name;
  bool checked;
}

class ToDoItem extends StatelessWidget {
  ToDoItem({
    required this.todo,
    required this.onToDoChanged,
  }) : super(key: ObjectKey(todo));

  final ToDo todo;
  final onToDoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onToDoChanged(todo),
      leading: CircleAvatar(
        child: Text(todo.name[0]),
      ),
      title: Text(
        todo.name,
        style: _getTextStyle(todo.checked),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

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

  void _removeToDoItem(ToDo item) {
    setState(() {
      _textFieldController.text = item.name;
      _todos.remove(item);
    });
  }

  void _toggleCheck(ToDo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('ToDo list'),
      ),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _textFieldController,
                  decoration:
                      const InputDecoration(hintText: 'Type your new todo'),
                ),
              ),
              FloatingActionButton(
                onPressed: () async {
                  _addToDoItem(_textFieldController.text);
                },
                tooltip: 'Add Item',
                child: Icon(Icons.add),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: _todos.map<Widget>((ToDo todo) {
                return ToDoItem(
                  todo: todo,
                  onCheckBoxTap: _toggleCheck,
                  onItemTap: _removeToDoItem,
                );
              }).toList(),
            ),
          ),
        ],
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
  ToDoItem(
      {required this.todo,
      required this.onCheckBoxTap,
      required this.onItemTap})
      : super(key: ObjectKey(todo));

  final ToDo todo;
  final onCheckBoxTap;
  final onItemTap;

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
      // onTap: () => onToDoChanged(todo),
      onTap: () => {onItemTap(todo)},
      leading: IconButton(
        icon: Icon(todo.checked
            ? Icons.check_box
            : Icons.check_box_outline_blank_outlined),
        onPressed: () => {onCheckBoxTap(todo)},
      ),
      title: Text(
        todo.name,
        style: _getTextStyle(todo.checked),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final TextEditingController _textField = TextEditingController();
  final List<ToDo> _itemList = <ToDo>[];

  void _addItem(String name) {
    setState(() {
      _itemList.add(
        ToDo(name: name, checked: false),
      );
      _textField.clear();
    });
  }

  void _removeItem(ToDo item) {
    setState(() {
      _textField.text = item.name;
      _itemList.remove(item);
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
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textField,
                    decoration:
                        const InputDecoration(hintText: 'Type your new todo'),
                  ),
                ),
                FloatingActionButton.small(
                  onPressed: () async {
                    _addItem(_textField.text);
                  },
                  tooltip: 'Add Item',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                children: _itemList.map<Widget>((ToDo todo) {
                  return ToDoItem(
                    todo: todo,
                    onCheckBoxTap: _toggleCheck,
                    onItemTap: _removeItem,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
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

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
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

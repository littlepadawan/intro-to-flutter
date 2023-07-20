import 'package:flutter/material.dart';

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

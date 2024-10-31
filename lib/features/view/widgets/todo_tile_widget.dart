import 'package:flutter/material.dart';
import 'package:interview/features/models/todo_model.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.todo, required this.onTap});

  final TodoModel todo;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: ListTile(
        onTap: onTap,
        title: Text(todo.title),
        leading: CircleAvatar(
          child: todo.status
              ? const Icon(
                  Icons.check_box,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.crop_square,
                  color: Colors.red,
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:interview/features/models/todo_model.dart';
import 'package:interview/features/view_model/todo_provider.dart';
import 'package:interview/utility/extensions/context_extensions.dart';
import 'package:interview/utility/extensions/text_styel_extension.dart';
import 'package:interview/utility/spacer/spacers.dart';
import 'package:provider/provider.dart';

class TodoViewBottomSheet extends StatelessWidget {
  final TodoModel todo;

  const TodoViewBottomSheet({super.key, required this.todo});
  @override
  Widget build(BuildContext context) {
    final prov = context.read<TodoProvider>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            todo.status ? "Completed." : "Todo.",
            style: context.textTheme.headlineLarge?.setColor(todo.status
                ? context.colorScheme.primary
                : context.colorScheme.tertiary),
          ),
          Spacers.vSpace8,
          const Divider(),
          Spacers.vSpace8,
          Text(todo.title, style: context.textTheme.bodyLarge),
          Spacers.vSpace16,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Selector<TodoProvider, bool>(
                  builder: (context, value, child) => value
                      ? Transform.scale(
                          scale: 0.6,
                          child: const CircularProgressIndicator(),
                        )
                      : TextButton.icon(
                          onPressed: () async {
                            await prov.removeTodo(todo);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          icon: const Icon(
                            Icons.delete_outlined,
                            color: Colors.red,
                          ),
                          label: const Text(
                            "delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                  selector: (ctx, pro) => pro.isBusyOnRemove),
              Spacers.hSpace16,
              Selector<TodoProvider, bool>(
                  builder: (context, value, child) => value
                      ? FilledButton(
                          onPressed: () {},
                          child: Transform.scale(
                            scale: 0.6,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ))
                      : FilledButton.icon(
                          onPressed: () async {
                            var newTodo = todo.copyWith(status: !todo.status);
                            await prov.updateTodoStatus(newTodo);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          icon: todo.status
                              ? const Icon(Icons.close)
                              : const Icon(Icons.check),
                          label: todo.status
                              ? const Text("Mark as todo")
                              : const Text("Mark as completed"),
                        ),
                  selector: (ctx, pro) => pro.isBusyOnUpdate)
            ],
          ),
          Spacers.vSpace32,
        ],
      ),
    );
  }
}

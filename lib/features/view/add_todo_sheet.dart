import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interview/features/models/todo_model.dart';
import 'package:interview/features/view_model/todo_provider.dart';
import 'package:interview/utility/extensions/context_extensions.dart';
import 'package:interview/utility/extensions/text_styel_extension.dart';
import 'package:interview/utility/spacer/spacers.dart';
import 'package:provider/provider.dart';

class BottomSheetForm extends StatefulWidget {
  const BottomSheetForm({super.key});

  @override
  createState() => _BottomSheetFormState();
}

class _BottomSheetFormState extends State<BottomSheetForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final prov = context.read<TodoProvider>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add Todo.",
            style: context.textTheme.headlineLarge?.setWeight(800),
          ),
          Spacers.vSpace8,
          const Divider(),
          Spacers.vSpace8,
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: "Enter the title",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Title cannot be empty";
                }
                return null;
              },
            ),
          ),
          Spacers.vSpace16,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              Spacers.hSpace16,
              Selector<TodoProvider, bool>(
                  builder: (context, value, child) => FilledButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final todo = TodoModel(
                              id: DateTime.now()
                                      .microsecondsSinceEpoch
                                      .hashCode ~/
                                  2,
                              status: false,
                              title: _textController.text.trim(),
                            );
                            log(todo.id.toString());
                            await prov.addTodo(todo);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        icon: value ? null : const Icon(Icons.add),
                        label: value
                            ? Transform.scale(
                                scale: 0.6,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Submit"),
                      ),
                  selector: (ctx, pro) => pro.isBusyOnAdd)
            ],
          ),
          Spacers.vSpace16,
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

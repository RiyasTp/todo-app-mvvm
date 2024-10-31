// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:interview/features/models/todo_model.dart';
import 'package:interview/features/view/add_todo_sheet.dart';
import 'package:interview/features/view/view_todo_sheet.dart';
import 'package:interview/features/view/widgets/loading_indicator_widget.dart';
import 'package:interview/features/view/widgets/todo_tile_widget.dart';
import 'package:interview/features/view_model/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    Future.delayed(
        Duration.zero, () => context.read<TodoProvider>().getTodos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 1.0),
          child: Selector<TodoProvider, bool>(
              builder: (context, value, child) => LoadingIndicator(value),
              selector: (ctx, pro) => pro.isLoading),
        ),
      ),
      body: const TodoBody(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _showBottomSheet(context),
          child: const Icon(Icons.add)),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const BottomSheetForm(),
        );
      },
    );
  }
}

class TodoBody extends StatelessWidget {
  const TodoBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<TodoProvider>();
    final data = prov.todos;

    // Display loading state
    if (prov.isLoading) {
      return const Center(
        child: Text(
          "Loading.. \nPlease wait",
          textAlign: TextAlign.center,
        ),
      );
    }

    if (prov.error != null) {
      return Center(
        child: Text(prov.error!),
      );
    }

    return data.isEmpty
        ? const Center(child: Text("No Todos"))
        : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => TodoTile(
              onTap: ()=> _showBottomSheet(context, data[index]),
              todo: data[index]));
  }

  void _showBottomSheet(BuildContext context , TodoModel todo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child:  TodoViewBottomSheet( todo: todo),
        );
      },
    );
  }
}

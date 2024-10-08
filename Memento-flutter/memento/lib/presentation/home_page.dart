import 'package:memento/presentation/tabs/s_completed_tasks.dart';
import 'package:memento/presentation/tabs/s_pending_tasks.dart';
import 'package:memento/presentation/dialogs/di_new_task.dart';
import 'package:memento/presentation/tabs/s_news_screen.dart';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  void refresh() => setState(() {});

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    // adding a listener means we can call setState() when the tab changes
    // this fixes a bug where swiping between tabs doesn't update the UI
    tabController.addListener(refresh);
  }

  @override
  void dispose() {
    tabController.removeListener(refresh);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar's style was adjusted in theme d_theme_data.dart
      appBar: AppBar(title: const Text("Memento")),
      body: TabBarView(
        controller: tabController,
        children: const [
          PendingTasksScreen(),
          CompletedTasksScreen(),
          NewsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pending_actions), label: "Pending"),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: "Completed"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "News"),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (index) => tabController.animateTo(index),
        currentIndex: tabController.index,
      ),
      floatingActionButton: tabController.index == 0
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(context: context, builder: (context) => const NewTaskDialog());
              },
            )
          : null,
    );
  }
}

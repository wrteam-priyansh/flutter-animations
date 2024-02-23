import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AssignmentScreen extends StatefulWidget {
  final String title;
  final int index;
  const AssignmentScreen({super.key, required this.index, required this.title});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();

  static Widget getRouteInstance() {
    final arguments = Get.arguments as Map;
    if (kDebugMode) {
      print("Arguments for assignment screen is ${Get.arguments}");
    }
    return AssignmentScreen(
      index: int.parse(arguments['index'].toString()),
      title: arguments['title'].toString(),
    );
  }
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  late final TextEditingController _textEditingController =
      TextEditingController(text: widget.title);

  @override
  void initState() {
    if (kDebugMode) {
      print(
          "Current get arguments : ${Get.arguments} and the route is ${Get.currentRoute}");
    }
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back(result: _textEditingController.text.trim());
        },
        child: const Icon(Icons.check),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: TextField(
            controller: _textEditingController,
          ),
        ),
      ),
    );
  }
}

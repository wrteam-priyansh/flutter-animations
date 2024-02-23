import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_route/app/routes.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();

  static Widget getRouteInstance() => const AssignmentsScreen();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  List<String> assignments = [
    "First Assignment",
    "Second assignment",
    "Third Assignemnt"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignments "),
      ),
      body: Column(
        children: List.generate(assignments.length, (index) => index)
            .map((index) => ListTile(
                  onTap: () {
                    Get.toNamed(Routes.assignmentScreen, arguments: {
                      "index": index,
                      "title": assignments[index]
                    })?.then((value) {
                      if (kDebugMode) {
                        print(
                            "Current get arguments : ${Get.arguments} and the route is ${Get.currentRoute}");
                        print("Result return from assginemnt screen");
                        print(value?.toString());
                        if (value != null) {
                          assignments[index] = value.toString();
                          setState(() {});
                        }
                      }
                    });
                  },
                  title: Text(assignments[index]),
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.shield),
          onPressed: () {
            Get.bottomSheet(
                Container(
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    children: [
                      const Text("This is demo bottomsheet"),
                      const Divider(),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))));
          }),
    );
  }
}

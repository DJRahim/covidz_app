import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainCard extends StatelessWidget {
  final String title;
  final Widget body;
  bool vis;
  // ignore: prefer_function_declarations_over_variables
  void Function(dynamic vis) ontap = (vis) {};

  MainCard({
    Key? key,
    required this.title,
    required this.body,
    required this.vis,
    required this.ontap(vis),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  vis
                      ? Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      : Icon(
                          Icons.arrow_right_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              ontap(vis);
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
            child: Visibility(
              visible: vis,
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}

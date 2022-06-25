import 'package:flutter/material.dart';

class SecondCard extends StatelessWidget {
  final Widget body;

  const SecondCard({
    Key? key,
    required this.body,
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
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: body,
      ),
    );
  }
}

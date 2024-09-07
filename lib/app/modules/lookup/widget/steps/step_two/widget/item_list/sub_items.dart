import 'package:flutter/material.dart';

class SubItems extends StatefulWidget {
  final bool isOpened;

  const SubItems({
    required this.isOpened,
    super.key,
  });

  @override
  State<SubItems> createState() => _SubItemsState();
}

class _SubItemsState extends State<SubItems> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 2000),
      curve: Curves.bounceOut,
      height: widget.isOpened ? 200 : 0,
      color: Colors.red,
      child: ListView.builder(
        itemCount: widget.isOpened ? 10 : 0,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}

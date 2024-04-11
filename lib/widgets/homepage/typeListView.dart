import 'package:flutter/material.dart';

class TypeListView extends StatelessWidget {
  final List<String> types;
  final Function(String) onTypeSelected;

  TypeListView({required this.types, required this.onTypeSelected});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: types.map((type) {
          return Padding(
            padding: const EdgeInsets.only(right: 36.0),
            child: _buildItem(type),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildItem(String type) {
    return GestureDetector(
      onTap: () {
        onTypeSelected(type);
      },
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              type,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

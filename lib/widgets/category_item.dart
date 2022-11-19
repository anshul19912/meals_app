import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {Key? key, required this.id, required this.title, required this.color})
      : super(key: key);
  final String id;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/category-meals',
            arguments: {
              'id': id,
              'title': title,
            },
          );
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.7),
                  color,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}

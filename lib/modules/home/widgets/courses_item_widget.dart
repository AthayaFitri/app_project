// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../../utils/helpers/color_helper.dart';
import '../../../utils/helpers/hive_service.dart';

class CoursesItemWidget extends StatefulWidget {
  final int id;
  final String name;
  final int year;
  final String courseColor;
  final String courseNumber;

  const CoursesItemWidget(
      this.id, this.name, this.year, this.courseColor, this.courseNumber,
      {super.key});

  @override
  _CoursesItemWidgetState createState() => _CoursesItemWidgetState();
}

class _CoursesItemWidgetState extends State<CoursesItemWidget> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = FavoriteService.isFavorite(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: ListTile(
          leading: Container(
            width: 60,
            height: 250,
            color: widget.courseColor.toColor(),
          ),
          title: Text(
            widget.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Container(
            margin: const EdgeInsets.only(
              top: 6,
            ),
            child: Text(
              '${widget.year} | ${widget.courseNumber}',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          trailing: IconButton(
            icon: isFavorite
                ? const Icon(Icons.favorite, color: Colors.red) // Favorit
                : const Icon(Icons.favorite_border), // Bukan favorit
            onPressed: () async {
              setState(() {
                isFavorite = !isFavorite;
              });

              // Simpan atau hapus dari daftar favorit
              if (isFavorite) {
                await FavoriteService.addToFavorites(widget.id);
                _showSnackBar(
                    'Added to favorites: ${widget.name}', Colors.blue);
              } else {
                await FavoriteService.removeFromFavorites(widget.id);
                _showSnackBar(
                    'Removed from favorites: ${widget.name}', Colors.red);
              }
            },
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}

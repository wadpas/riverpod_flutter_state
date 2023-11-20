import 'package:flutter/material.dart';

@immutable
class Film {
  final String id;
  final String name;
  final String description;
  final bool isFavorite;

  const Film({
    required this.id,
    required this.name,
    required this.description,
    required this.isFavorite,
  });

  Film copy({required bool isFavorite}) => Film(
        id: id,
        name: name,
        description: description,
        isFavorite: isFavorite,
      );
}

import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Recipe extends Equatable {
  Recipe({
    this.id,
    @required this.calories,
    @required this.causions,
    @required this.image,
    @required this.instructions,
    @required this.recipeName,
    this.rating,
  });

  final int id;
  final int rating;
  final String calories;
  final String image;
  final String recipeName;
  final String causions;
  final String instructions;

  @override
  List<Object> get props =>
      [id, calories, image, recipeName, causions, instructions, rating];

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      calories: json['calories'],
      rating: json['rating'],
      image: json['image'],
      recipeName: json['name'],
      causions: json['causions'],
      instructions: json['instructions'],
    );
  }

  @override
  String toString() =>
      'Election {name: $recipeName, instruction: $instructions , cousions:$causions, calories:$calories}';
}

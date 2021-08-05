import 'package:flutter/material.dart';

class Manga {
  final int id;
  final String name;
  final int cap;

  const Manga({
    this.id,
    @required this.name,
    @required this.cap,
  });
}

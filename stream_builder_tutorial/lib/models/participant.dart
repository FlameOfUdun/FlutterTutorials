import 'package:flutter/material.dart';

@immutable
class Participant {
  final String name;
  final String email;

  const Participant({
    required this.name,
    required this.email,
  });
}

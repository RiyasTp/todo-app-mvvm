import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext{
  TextTheme  get textTheme  {
    return Theme.of(this).textTheme;
  }
  ColorScheme  get colorScheme  {
    return Theme.of(this).colorScheme;
  }
}
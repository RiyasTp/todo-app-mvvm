import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle setColor(Color? color) {
    return copyWith(color: color);
  }

  TextStyle setWeight(double fontWeight) {
    return copyWith(
      fontVariations: [FontVariation('wght', fontWeight)],
    );
  }

  
}

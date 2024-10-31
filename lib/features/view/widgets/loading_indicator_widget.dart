import 'package:flutter/material.dart';
import 'package:interview/utility/spacer/spacers.dart';

class LoadingIndicator extends StatelessWidget {
  final bool _isLoading;
  const LoadingIndicator(this._isLoading, {super.key});

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LinearProgressIndicator();
    } else {
      return Spacers.voidBox;
    }
  }
}

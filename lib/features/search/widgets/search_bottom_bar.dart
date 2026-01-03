import 'package:flutter/material.dart';

class SearchBottomBar extends StatelessWidget {
  final VoidCallback onClear;
  final VoidCallback onNext;

  const SearchBottomBar({
    super.key,
    required this.onClear,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            TextButton(onPressed: onClear, child: const Text('Clear All')),
            const Spacer(),
            ElevatedButton(onPressed: onNext, child: const Text('Next')),
          ],
        ),
      ),
    );
  }
}

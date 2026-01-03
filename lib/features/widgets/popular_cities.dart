import 'package:flutter/material.dart';

/// Popular city suggestions
/// Static for now – API later
class PopularCities extends StatelessWidget {
  final ValueChanged<String> onCitySelected;

  const PopularCities({super.key, required this.onCitySelected});

  @override
  Widget build(BuildContext context) {
    final cities = [
      'Noida',
      'Delhi',
      'Mumbai',
      'Chennai',
      'Gurgaon',
      'Bangalore',
      'Hyderabad',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular cities in India',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 12),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: cities.map((city) {
              return InputChip(
                label: Text(city),

                // ✅ Only select city
                onPressed: () {
                  debugPrint('[PopularCities] City tapped: $city');
                  onCitySelected(city);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

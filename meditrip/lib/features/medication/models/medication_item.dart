class MedicationItem {
  final String name;
  final String manufacturer;
  final String ingredient;
  final String imageAsset;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final String dosage;
  final String maxLimit;
  final String caution;
  final String details;

  const MedicationItem({
    required this.name,
    required this.manufacturer,
    required this.ingredient,
    required this.imageAsset,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    required this.dosage,
    required this.maxLimit,
    required this.caution,
    required this.details,
  });
}

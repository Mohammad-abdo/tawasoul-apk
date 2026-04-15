double calculateAverageRating(List<double> ratings) {
  if (ratings.isEmpty) return 0.0;

  final sum = ratings.reduce((a, b) => a + b);
  return sum / ratings.length;
}

void filterList(
  String query,
  List<String> allItems,
  List<String> filteredItems,
) {
  filteredItems = allItems
      .where((item) => item.toLowerCase().contains(query.toLowerCase()))
      .toList();
}

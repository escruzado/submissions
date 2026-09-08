extension StringExtension on String {
  String toPascalCase() {
    if (isEmpty) return this;
    return split(' ')
        .where((word) => word.isNotEmpty)
        .map(
          (word) => word.isEmpty
              ? word
              : word[0].toUpperCase() + word.substring(1).toLowerCase(),
        )
        .join(' ');
  }
}

extension StringExtension on String {
    String firstLetterCapitalize() {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    }
}
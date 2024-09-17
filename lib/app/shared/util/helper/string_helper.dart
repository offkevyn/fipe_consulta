extension StringHelper on String {
  String formatter(
      {bool capitalize = false, bool titleCase = false, bool trim = false}) {
    if (capitalize == true && titleCase == true) {
      throw ArgumentError(
          'capitalize and titleCase cannot be true at the same time');
    }

    String text = this;

    text = text.trim();
    text = text.replaceAll(RegExp(' +'), ' ');

    if (capitalize) {
      text = text._toCapitalized(txt: text);
    } else if (titleCase) {
      text = text._toTitleCase(txt: text);
    }

    return text;
  }

  String _toCapitalized({required String txt}) {
    return txt.isNotEmpty
        ? '${txt[0].toUpperCase()}${txt.substring(1).toLowerCase()}'
        : '';
  }

  String _toTitleCase({required String txt}) {
    return txt
        .split(' ')
        .map((str) => str.length > 2 ? str._toCapitalized(txt: str) : str)
        .join(' ');
  }
}

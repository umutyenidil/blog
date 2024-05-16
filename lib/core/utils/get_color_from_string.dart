import 'dart:ui';

Color getColorFromString(String string) {
  // Generate a hash code from the input string
  int hashCode = string.hashCode;

  // Extract the red, green, and blue components from the hash code
  int red = (hashCode & 0xFF0000) >> 16;
  int green = (hashCode & 0x00FF00) >> 8;
  int blue = hashCode & 0x0000FF;

  // Generate a color using the extracted components
  return Color.fromARGB(255, red, green, blue);
}

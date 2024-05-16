Duration getReadingTime(String text) {
  List<String> words = text.split(RegExp(r'\s+'));

  double minutes = words.length / 200;

  if(minutes < 1){
    minutes = 1;
  }

  return Duration(minutes: minutes.toInt());
}

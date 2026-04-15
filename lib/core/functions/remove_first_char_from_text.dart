String fixText({String text='',int number =1}) {
  return text.isNotEmpty ? text.substring(number) : text;
}
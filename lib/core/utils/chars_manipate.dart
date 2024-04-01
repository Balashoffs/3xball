RegExp firstWordStart = RegExp('^[а-яё]\$',);
RegExp firstWordEnd = RegExp('^[А-ЯЁ][а-яё]{1,}\\s[а-яё]\$',);

List<RegExp> wordsRegexps = [firstWordStart,firstWordEnd];

bool isChangeFirstLetter(String value){
  return wordsRegexps.indexWhere((element) => element.hasMatch(value)) != -1;
}

RegExp days = RegExp('^[\\d]{2}\$',);
RegExp month = RegExp('^[\\d]{2}\\.[\\d]{2}\$',);

List<RegExp> datesRegexps = [days,month];

bool isAddDot(String value){
  return datesRegexps.indexWhere((element) => element.hasMatch(value)) != -1;
}

//TODO Add regex compute
String scoreSubtitle(int score){
  return 'очки';
}


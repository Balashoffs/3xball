String convertDate(String date){
  List<String> chunks = date.split('.');
  return '${chunks[2]}-${chunks[1]}-${chunks[0]}';
}
Map<RegExp, String> ageRegexTemplates ={RegExp('^[1]\$|^[2-7][1]\$'):'год', RegExp('[2-4]\$|^[2-7][2-4]\$') : 'года', RegExp('^[5-9]\$|^[1][0-9]|[2-9][05-9]\$'): 'лет'};

String getAgeLabel (int age){
  String ageAsString = '$age';

  RegExp found = ageRegexTemplates.keys.firstWhere((element) => element.hasMatch(ageAsString));

  return ageRegexTemplates[found] ?? '';
}

String toStringTimer(int duration){
  final minutes = ((duration/60) % 60).floor().toString().padLeft(2, '0');
  final seconds = (duration % 60).floor().toString().padLeft(2, '0');
  return '$minutes : $seconds';
}
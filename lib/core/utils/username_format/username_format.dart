String usernameFormat(String fullName) {
  List<String> names = fullName.split(' '); // Разделяем полное имя на части
  String initials = "";
  
  // Перебираем полученные слова и берем первую букву каждого слова
  for (String name in names) {
    if (name.isNotEmpty) {
      initials += name[0].toUpperCase();
    }
  }

  return initials;
}
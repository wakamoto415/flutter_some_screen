enum UserStatus {
  online('オンライン'),
  offline('オフライン'),
  withdrawn('退会済み');

  const UserStatus(this.label);

  final String label;
}

class User {
  const User({
    required this.id,
    required this.name,
    required this.updatedAt,
    required this.status,
  });

  final String id;
  final String name;
  final DateTime updatedAt;
  final UserStatus status;
}

String formatUserDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}/$month/$day';
}

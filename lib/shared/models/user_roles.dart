enum UserRole {
  admin,
  salesperson,
  accountant;

  String get value => name;

  static UserRole fromString(String value) => UserRole.values
      .firstWhere((r) => r.name == value, orElse: () => UserRole.salesperson);

  String get displayName => switch (this) {
        UserRole.admin => 'Admin',
        UserRole.salesperson => 'Salesperson',
        UserRole.accountant => 'Accountant',
      };
}

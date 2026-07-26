class AppExceptions {
  static String fromSupabaseAuth(String message) {
    final m = message.toLowerCase();
    if (m.contains('already registered') || m.contains('already exists')) {
      return 'This email is already registered. Try logging in instead.';
    }
    if (m.contains('invalid credentials') || m.contains('invalid login')) {
      return 'Email or password is incorrect';
    }
    if (m.contains('email not confirmed')) {
      return 'Please verify your email address first.';
    }
    if (m.contains('too many requests')) {
      return 'Too many attempts. Please wait for few minutes';
    }
    if (m.contains('weak password')) {
      return 'Password must be at least 8 characters';
    }
    return 'Something went wrong. Please try again.';
  }

  static String fromDatabase(Object e) {
    final m = e.toString().toLowerCase();
    if (m.contains('permission denied')) {
      return 'You do not have permission.';
    }
    if (m.contains('unique') || m.contains('duplicate')) {
      return 'Record already exists.';
    }
    return 'Database error. Please try again.';
  }
}

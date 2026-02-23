String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }

  // 1. Kam az kam 8 characters (Aap 6 bhi kar sakte hain requirement ke mutabiq)
  if (value.length < 8) {
    return 'Must be at least 8 characters';
  }

  // 2. Kam az kam ek Uppercase letter
  if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
    return 'At least one uppercase letter (A-Z)';
  }

  // 3. Kam az kam ek Lowercase letter
  if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
    return 'At least one lowercase letter (a-z)';
  }

  // 4. Kam az kam ek Number
  if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
    return 'At least one number (0-9)';
  }

  // 5. Kam az kam ek Special Character
  if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
    return 'At least one special character (!@#\$&*~)';
  }

  return null; // Agar sab sahi hai
}
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static bool isLoggedIn = false;

  static final List<Map<String, String>> _users = [
    {
      'email': 'demo@gmail.com',
      'password': '1234567',
      'name': 'Demo User',
    },
  ];


Future<bool> login(String email, String password) async {
  await Future.delayed(const Duration(seconds: 1));
  final foundUser = _users.firstWhere(
    (user) => user['email'] == email && user['password'] == password,
    orElse: () => {},
  );

  if (foundUser.isNotEmpty) {
    isLoggedIn = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', foundUser['email']!);
    await prefs.setString('name', foundUser['name']!);

    return true;
  }

  return false;
}

Future<bool> signup(String name, String email, String password) async {
  await Future.delayed(const Duration(seconds: 1));

  final exists = _users.any((user) => user['email'] == email);
  if (exists) return false;

  _users.add({
    'name': name,
    'email': email,
    'password': password,
  });

  isLoggedIn = true;

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('email', email);
  await prefs.setString('name', name);

  return true;
}

  static Future<void> logout() async {
    isLoggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }
}

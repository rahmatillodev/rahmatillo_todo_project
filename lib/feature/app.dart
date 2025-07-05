import 'package:go_router/go_router.dart';
import 'package:todo/feature/auth/presentation/pages/splash_page.dart';
import 'package:todo/feature/notes/data/models/note_model.dart';
import 'package:todo/feature/auth/presentation/pages/forgot_password_page.dart';
import 'package:todo/feature/auth/presentation/pages/login_page.dart';
import 'package:todo/feature/auth/presentation/pages/onboarding_screen.dart';
import 'package:todo/feature/auth/presentation/pages/signup_page.dart';
import 'package:todo/feature/home/presentation/home_page.dart';
import 'package:todo/feature/notes/presentation/pages/add_note_page.dart';
import 'package:todo/feature/notes/presentation/pages/add_todo_page.dart';
import 'package:todo/feature/profile/presentation/pages/about_page.dart';
import 'package:todo/feature/profile/presentation/pages/settings_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/signup', builder: (context, state) => SignupPage()),
    GoRoute(path: '/forgot', builder: (context, state) => ForgotPasswordPage()),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(
      path: '/addNote',
      builder: (context, state) {
        final note = state.extra as Note?;
        final isEditing = note != null;
        return AddNotePage(note: note, isEditing: isEditing);
      },
    ),
    GoRoute(
      path: '/addTodo',
      builder: (context, state) {
        final note = state.extra as Note?;
        final isEditing = note != null;
        return AddToDoPage(note: note, isEditing: isEditing);
      },
    ),
    GoRoute(path: '/about', builder: (context, state) => const AboutPage()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/welcome/welcome_screen.dart';
import 'features/auth/auth_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/reporting/report_lost_screen.dart';
import 'features/reporting/report_found_screen.dart';
import 'features/matching/matching_screen.dart';
import 'features/item_details/item_details_screen.dart';
import 'features/claim/claim_verification_screen.dart';
import 'features/admin/admin_screen.dart';
import 'features/profile/profile_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/matching',
            builder: (context, state) => const AiMatchingScreen(),
          ),
          GoRoute(
            path: '/admin',
            builder: (context, state) => const AdminScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/report/lost',
        builder: (context, state) => const ReportLostScreen(),
      ),
      GoRoute(
        path: '/report/found',
        builder: (context, state) => const ReportFoundScreen(),
      ),
      GoRoute(
        path: '/item/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ItemDetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: '/claim/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ClaimVerificationScreen(id: id);
        },
      ),
    ],
  );
}

class ScaffoldWithBottomNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            activeIcon: Icon(Icons.auto_awesome_rounded),
            label: 'AI Match',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings_outlined),
            activeIcon: Icon(Icons.admin_panel_settings_rounded),
            label: 'Admin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/matching')) return 1;
    if (location.startsWith('/admin')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/matching');
        break;
      case 2:
        context.go('/admin');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
}

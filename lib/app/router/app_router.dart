import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_shell.dart';

import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';

import '../../features/auth/presentation/screens/choose_mess_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';

import '../../features/chat/presentation/screens/group_chat_screen.dart';

import '../../features/expenses/presentation/screens/expenses_screen.dart';

import '../../features/home/presentation/screens/home_screen.dart';

import '../../features/meals/presentation/screens/meal_details_screen.dart';
import '../../features/meals/presentation/screens/meal_history_screen.dart';
import '../../features/meals/presentation/screens/meal_management_screen.dart';

import '../../features/mess/presentation/screens/create_mess_screen.dart';
import '../../features/mess/presentation/screens/join_mess_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/auth/signup',
    //initialLocation: '/home',

    // NO AUTO REDIRECTS
    redirect: (context, state) {
      return null;
    },

    routes: [
      // AUTH
      GoRoute(
        path: '/auth/signup',
        builder: (context, state) => const SignupScreen(),
      ),

      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/auth/forgot',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      GoRoute(
        path: '/auth/choose-mess',
        builder: (context, state) => const ChooseMessScreen(),
      ),

      // MESS
      GoRoute(
        path: '/mess/create',
        builder: (context, state) => const CreateMessScreen(),
      ),

      GoRoute(
        path: '/mess/join',
        builder: (context, state) => const JoinMessScreen(),
      ),

      // MAIN APP
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),

          GoRoute(
            path: '/chat',
            builder: (context, state) => const GroupChatScreen(),
          ),

          GoRoute(
            path: '/expenses',
            builder: (context, state) => const ExpensesScreen(),
          ),

          GoRoute(
            path: '/meals',
            builder: (context, state) => const MealManagementScreen(),
          ),

          GoRoute(
            path: '/meals/details',
            builder: (context, state) => const MealDetailsScreen(),
          ),

          GoRoute(
            path: '/meals/history',
            builder: (context, state) => const MealHistoryScreen(),
          ),

          GoRoute(
            path: '/admin',
            builder: (context, state) => const AdminDashboardScreen(),
          ),
        ],
      ),
    ],
  );
});
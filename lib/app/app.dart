import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
import 'theme.dart';

import '../features/auth/login/login_screen.dart';
import '../features/auth/forgot_password/forgot_password_screen.dart';
import '../features/auth/register/register_screen.dart';
import '../features/auth/register/register_controller.dart';
import '../features/management/management_shell.dart';

class ApnaSalonManagementApp extends StatelessWidget {
  const ApnaSalonManagementApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'ApnaSalon Management',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getTheme(themeNotifier.currentTheme),
            initialRoute: AppRoutes.login,
            routes: {
              // ======================================================
              // LOGIN
              // ======================================================
              AppRoutes.login: (_) => const LoginScreen(),

              // ======================================================
              // REGISTER
              // ======================================================
              AppRoutes.register: (_) => ChangeNotifierProvider(
                    create: (_) => RegisterController(),
                    child: const RegisterScreen(),
                  ),

              // ======================================================
              // FORGOT PASSWORD
              // ======================================================
              AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),

              // ======================================================
              // MANAGEMENT HOME
              // Requests is default.
              // ======================================================
              AppRoutes.home: (_) => const ManagementShell(
                    initialIndex: 1,
                  ),
            },
          );
        },
      ),
    );
  }
}
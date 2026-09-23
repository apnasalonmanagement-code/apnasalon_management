import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../app/theme.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final controller =
        context.read<ForgotPasswordController>();

    final success =
        await controller.sendResetEmail(
      _emailController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: const Text(
            'Password reset email sent.',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Text(
            controller.errorMessage ??
                'Unable to send reset email.',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();
    final isBoy = themeNotifier.currentTheme == SalonGenderTheme.boy;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordController(),
      child: Consumer<ForgotPasswordController>(
        builder: (context, controller, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Forgot Password', style: TextStyle(fontWeight: FontWeight.bold)),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.boy, color: isBoy ? Colors.white : Colors.white70, size: 28),
                        onPressed: () => themeNotifier.setTheme(SalonGenderTheme.boy),
                        tooltip: 'Blue Boy Theme',
                      ),
                      IconButton(
                        icon: Icon(Icons.girl, color: !isBoy ? Colors.white : Colors.white70, size: 28),
                        onPressed: () => themeNotifier.setTheme(SalonGenderTheme.girl),
                        tooltip: 'Pink Girl Theme',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isBoy
                      ? [const Color(0xFFE3F2FD), Colors.white]
                      : [const Color(0xFFFCE4EC), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 480,
                      ),
                      child: Card(
                        elevation: 8,
                        shadowColor: primaryColor.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.lock_reset,
                                      size: 54,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                Text(
                                  'Reset Password',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight:
                                            FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                ),

                                const SizedBox(height: 10),

                                const Text(
                                  'Enter your registered email and '
                                  'we will send you a password reset link.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),

                                const SizedBox(height: 30),

                                TextFormField(
                                  controller:
                                      _emailController,
                                  keyboardType:
                                      TextInputType.emailAddress,
                                  decoration:
                                      InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon:
                                        Icon(Icons.email_outlined, color: primaryColor),
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    final email =
                                        value?.trim() ?? '';

                                    if (email.isEmpty) {
                                      return 'Enter your email.';
                                    }

                                    if (!email.contains('@')) {
                                      return 'Enter a valid email.';
                                    }

                                    return null;
                                  },
                                ),

                                const SizedBox(height: 20),

                                SizedBox(
                                  height: 52,
                                  child: FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    onPressed:
                                        controller.isLoading
                                            ? null
                                            : _sendResetEmail,
                                    child:
                                        controller.isLoading
                                            ? const SizedBox(
                                                height: 22,
                                                width: 22,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const Text(
                                                'SEND RESET LINK',
                                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1),
                                              ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                TextButton(
                                  onPressed:
                                      controller.isLoading
                                          ? null
                                          : () {
                                              Navigator.pop(
                                                  context);
                                            },
                                  child: Text(
                                    'Back to Login',
                                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

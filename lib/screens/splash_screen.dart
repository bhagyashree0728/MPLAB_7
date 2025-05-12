import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/theme.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.restaurant_menu,
                size: 64,
                color: AppTheme.goldenYellow,
              ),
            )
            .animate()
            .scale(
              duration: 600.ms,
              curve: Curves.easeOutBack,
              delay: 400.ms,
            )
            .fadeIn(duration: 500.ms),

            const SizedBox(height: 24),

            // App Name
            Text(
              'Bitebox',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
            )
            .animate()
            .slideY(
              begin: 0.3,
              duration: 600.ms,
              curve: Curves.easeOutBack,
              delay: 600.ms,
            )
            .fadeIn(delay: 600.ms),

            const SizedBox(height: 12),

            // Tagline
            Text(
              'Delicious bites at your doorstep',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            )
            .animate()
            .slideY(
              begin: 0.3,
              duration: 600.ms,
              curve: Curves.easeOutBack,
              delay: 800.ms,
            )
            .fadeIn(delay: 800.ms),

            const SizedBox(height: 48),

            // Loading Indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.goldenYellow),
              strokeWidth: 3,
            )
            .animate()
            .scale(
              duration: 400.ms,
              delay: 1200.ms,
            )
            .fadeIn(delay: 1200.ms),
          ],
        ),
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../main_nav/presentation/screens/main_nav_screen.dart';

class ProfileSelectionScreen extends StatelessWidget {
  const ProfileSelectionScreen({super.key});

  void _onProfileSelected(BuildContext context, String profileName) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, _, _) => const MainNavScreen(),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Header: Centered Logo & Right Edit Icon
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      AssetConstants.netflixLogo,
                      height: 38,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => Text(
                        'NETFLIX',
                        style: AppTypography.headingLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Edit Profiles'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Centered Profiles Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row 1: Emenalo & Onyeka
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildProfileItem(
                        context: context,
                        name: 'Emenalo',
                        imagePath: AssetConstants.profileBlue,
                      ),
                      _buildProfileItem(
                        context: context,
                        name: 'Onyeka',
                        imagePath: AssetConstants.profileYellow,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Row 2: Thelma & Kids
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildProfileItem(
                        context: context,
                        name: 'Thelma',
                        imagePath: AssetConstants.profileRed,
                      ),
                      _buildProfileItem(
                        context: context,
                        name: 'Kids',
                        imagePath: AssetConstants.profileKids,
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  // Add Profile Item
                  _buildAddProfileItem(context),
                ],
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required BuildContext context,
    required String name,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () => _onProfileSelected(context, name),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: AppColors.surfaceLight,
                child: const Icon(Icons.person, color: Colors.white, size: 40),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddProfileItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Add profile functionality'),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AssetConstants.addIcon,
            width: 58,
            height: 58,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(color: Colors.white, width: 2.0),
              ),
              child: const Center(
                child: Icon(Icons.add, color: Colors.white, size: 32),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Add Profile',
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

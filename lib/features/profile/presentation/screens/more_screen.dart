import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../profile_selection/presentation/screens/profile_selection_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  final List<Map<String, String>> _profiles = const [
    {'name': 'Emenalo', 'asset': AssetConstants.profileBlue},
    {'name': 'Onyeka', 'asset': AssetConstants.profileYellow},
    {'name': 'Thelma', 'asset': AssetConstants.profileRed},
    {'name': 'Kids', 'asset': AssetConstants.profileKids},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // 1. Profile Avatars Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._profiles.map((p) => _buildProfileItem(context, p['name']!, p['asset']!)),
                    _buildAddProfileItem(context),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // 2. Manage Profiles Button
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ProfileSelectionScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.edit,
                        size: 14,
                        color: Color(0xFFC4C4C4),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Manage Profiles',
                        style: AppTypography.caption.copyWith(
                          color: const Color(0xFFC4C4C4),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 3. Tell Friends About Netflix Card
              Container(
                width: double.infinity,
                color: const Color(0xFF1A1A1A),
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Image.asset(
                          AssetConstants.chat,
                          width: 22,
                          height: 22,
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Tell friends about Netflix.',
                          style: AppTypography.titleMedium.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Body
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit quam dui, vivamus bibendum ut. A morbi mi tortor ut felis non accumsan accumsan quis. Massa,',
                      style: AppTypography.bodySmall.copyWith(
                        color: const Color(0xFFC4C4C4),
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Terms Link
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          color: Color(0xFF8C8787),
                          fontSize: 11,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Copy Link Row
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 38,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.black,
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'https://www.netflix.com/refer/emenalo',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              const ClipboardData(
                                text: 'https://www.netflix.com/refer/emenalo',
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Referral link copied to clipboard!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Container(
                            height: 38,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: const Text(
                              'Copy Link',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Social Share Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // WhatsApp
                        _buildSocialIcon(
                          AssetConstants.whatsappIcon,
                          'WhatsApp',
                          () => _share(context, 'WhatsApp'),
                        ),
                        _buildDivider(),
                        // Facebook
                        _buildSocialIcon(
                          AssetConstants.fbIcon,
                          'Facebook',
                          () => _share(context, 'Facebook'),
                        ),
                        _buildDivider(),
                        // Gmail
                        _buildSocialIcon(
                          AssetConstants.gmailIcon,
                          'Gmail',
                          () => _share(context, 'Gmail'),
                        ),
                        _buildDivider(),
                        // More
                        GestureDetector(
                          onTap: () => _share(context, 'More Options'),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                                size: 28,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'More',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 4. Menu Items
              const SizedBox(height: 8),

              // My List
              _buildMenuItem(
                context,
                icon: Icons.check,
                title: 'My List',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening My List...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
              const Divider(color: Color(0xFF242424), thickness: 1, height: 1),

              // App Settings
              _buildMenuItem(
                context,
                title: 'App Settings',
                onTap: () {},
              ),

              // Account
              _buildMenuItem(
                context,
                title: 'Account',
                onTap: () {},
              ),

              // Help
              _buildMenuItem(
                context,
                title: 'Help',
                onTap: () {},
              ),

              // Sign Out
              _buildMenuItem(
                context,
                title: 'Sign Out',
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const ProfileSelectionScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, String name, String asset) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Switched to profile "$name"'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              asset,
              width: 58,
              height: 58,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
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
            content: Text('Add profile requested'),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFF424242), width: 1.5),
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Color(0xFFC4C4C4),
                size: 32,
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String asset, String name, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        asset,
        width: 38,
        height: 38,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 32,
      color: const Color(0xFF333333),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    IconData? icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 12),
            ],
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _share(BuildContext context, String platform) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing via $platform...'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

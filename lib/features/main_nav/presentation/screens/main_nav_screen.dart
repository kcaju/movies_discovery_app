import 'package:flutter/material.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../coming_soon/presentation/screens/coming_soon_screen.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../../../profile/presentation/screens/more_screen.dart';
import '../../../search/presentation/screens/search_screen.dart';
import '../../../watchlist/presentation/screens/watchlist_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    SearchScreen(),
    ComingSoonScreen(),
    WatchlistScreen(),
    MoreScreen(),
  ];

  Widget _buildNavIcon(String assetPath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Image.asset(
        assetPath,
        width: 22,
        height: 22,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF121212),
          border: Border(
            top: BorderSide(color: Color(0xFF262626), width: 0.8),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF121212),
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xFF8C8787),
          selectedLabelStyle: AppTypography.caption.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          unselectedLabelStyle: AppTypography.caption.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF8C8787),
          ),
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: _buildNavIcon(AssetConstants.home),
              activeIcon: _buildNavIcon(AssetConstants.homeActive),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(AssetConstants.search),
              activeIcon: _buildNavIcon(AssetConstants.searchActive),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(AssetConstants.comingSoon),
              activeIcon: _buildNavIcon(AssetConstants.comingSoonActive),
              label: 'Coming Soon',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(AssetConstants.download),
              activeIcon: _buildNavIcon(AssetConstants.downloadActive),
              label: 'Downloads',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(AssetConstants.more),
              activeIcon: _buildNavIcon(AssetConstants.moreActive),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}

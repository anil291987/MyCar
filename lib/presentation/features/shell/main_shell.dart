import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/app_locator.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/mb_glass.dart';
import '../../../l10n/generated/app_localizations.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: _MBBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}

class _MBBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _MBBottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = [
      _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: l10n.navHome),
      _NavItem(icon: Icons.directions_car_outlined, activeIcon: Icons.directions_car, label: l10n.navStatus),
      _NavItem(icon: Icons.settings_remote_outlined, activeIcon: Icons.settings_remote, label: l10n.navRemote),
      _NavItem(icon: Icons.map_outlined, activeIcon: Icons.map, label: l10n.navNavigate),
      _NavItem(icon: Icons.more_horiz, activeIcon: Icons.more_horiz, label: l10n.navMore),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: AppLocator.themeRepository.isDark ? 0.45 : 0.18,
                ),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: MBGlassSurface(
          borderRadius: BorderRadius.circular(28),
          blurSigma: 30,
          child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isActive = index == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isActive ? item.activeIcon : item.icon,
                          size: 22,
                          color: isActive
                              ? AppColors.textPrimary
                              : AppColors.textTertiary,
                        ),
                        const SizedBox(height: 4),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: AppTypography.caption.copyWith(
                            color: isActive
                                ? AppColors.textPrimary
                                : AppColors.textTertiary,
                            fontWeight: isActive
                                ? FontWeight.w600
                                : FontWeight.w400,
                            letterSpacing: 0.3,
                          ),
                          child: Text(
                            item.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          ),
        ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  _NavItem({required this.icon, required this.activeIcon, required this.label});
}

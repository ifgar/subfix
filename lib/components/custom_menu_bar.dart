import 'package:flutter/material.dart';
import 'package:menu_bar/menu_bar.dart';
import 'package:subfix/core/app_colors.dart';
import 'package:subfix/core/text_styles.dart';

class CustomMenuBar extends StatelessWidget {
  final Widget child;

  const CustomMenuBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MenuBarWidget(
      menuButtonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.backgroundLight),
        // TODO: Improve menuButtonStyle, possibly use backgroundBuilder for hover color and box border
      ),
      barButtonStyle: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(const Size(0, 32)),
        backgroundBuilder: (context, states, child) {
          final hovered = states.contains(WidgetState.hovered);

          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: hovered ? 26 : 0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: hovered ? AppColors.tertiary : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              child!,
            ],
          );
        },
        fixedSize: WidgetStatePropertyAll(const Size.fromHeight(36)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        overlayColor: WidgetStatePropertyAll(AppColors.backgroundLight),
      ),
      barStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.backgroundLight),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
      ),
      barButtons: [
        BarButton(
          text: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Icon(Icons.abc, color: AppColors.primary)],
          ),
          submenu: SubMenu(menuItems: []),
        ),
        BarButton(
          text: const Text(
            'File',
            style: TextStyles.bodyText,
            textAlign: TextAlign.center,
          ),
          submenu: SubMenu(
            menuItems: [
              MenuButton(
                text: const Text('Save'),
                onTap: () {},
                icon: const Icon(Icons.save),
                shortcutText: 'Ctrl+S',
              ),
              const MenuDivider(),
              MenuButton(
                text: const Text('Exit'),
                onTap: () {},
                icon: const Icon(Icons.exit_to_app),
                shortcutText: 'Ctrl+Q',
              ),
            ],
          ),
        ),
        BarButton(
          text: const Text(
            'Help',
            style: TextStyles.bodyText,
            textAlign: TextAlign.center,
          ),
          submenu: SubMenu(
            menuItems: [
              MenuButton(text: const Text('View License'), onTap: () {}),
              MenuButton(
                text: const Text('About'),
                onTap: () {},
                icon: const Icon(Icons.info),
              ),
            ],
          ),
        ),
      ],
      child: child,
    );
  }
}

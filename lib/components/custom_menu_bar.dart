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
      barStyle: MenuStyle(backgroundColor: WidgetStatePropertyAll(AppColors.backgroundLight), shape: WidgetStatePropertyAll(RoundedRectangleBorder())),
      barButtons: [
        BarButton(
            text: const Text('File', style: TextStyles.bodyText),
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
            text: const Text('Help', style: TextStyles.bodyText),
            submenu: SubMenu(
                menuItems: [
                    MenuButton(
                      text: const Text('View License'),
                      onTap: () {},
                    ),
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

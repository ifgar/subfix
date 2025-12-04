// AI-generated implementation, subject to review and refinement.

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:subfix/core/app_colors.dart';
import 'package:subfix/core/text_styles.dart';

class MainMenuBar extends StatefulWidget {
  final Widget child;

  const MainMenuBar({super.key, required this.child});

  @override
  State<MainMenuBar> createState() => _MainMenuBarState();
}

class _MainMenuBarState extends State<MainMenuBar> {
  String? _openMenuId;
  MenuController? _openController;

  final MenuController fileController = MenuController();
  final MenuController helpController = MenuController();

  PointerDataPacketCallback? _oldHandler;

@override
void initState() {
  super.initState();

  _oldHandler = PlatformDispatcher.instance.onPointerDataPacket;

  PlatformDispatcher.instance.onPointerDataPacket = (packet) {
    for (final data in packet.data) {
      if (data.change == PointerChange.remove) {
        _closeMenu();
      }
    }

    _oldHandler?.call(packet);
  };
}

@override
void dispose() {

  PlatformDispatcher.instance.onPointerDataPacket = _oldHandler;
  super.dispose();
}


  void _openMenu(String id, MenuController controller) {
    if (_openController != null && _openController != controller) {
      _openController!.close();
    }

    setState(() {
      _openMenuId = id;
      _openController = controller;
    });
  }

  void _closeMenu() {
    _openController?.close();
    setState(() {
      _openMenuId = null;
      _openController = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MenuRow(
          openMenuId: _openMenuId,
          onOpenMenu: _openMenu,
          onCloseMenu: _closeMenu,
          fileController: fileController,
          helpController: helpController,
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}

class _MenuRow extends StatelessWidget {
  final String? openMenuId;
  final void Function(String id, MenuController controller) onOpenMenu;
  final VoidCallback onCloseMenu;

  final MenuController fileController;
  final MenuController helpController;

  const _MenuRow({
    required this.openMenuId,
    required this.onOpenMenu,
    required this.onCloseMenu,
    required this.fileController,
    required this.helpController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      color: AppColors.backgroundLight,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Icon(Icons.abc, color: AppColors.primary),

          _MenuButton(
            id: 'file',
            label: 'File',
            controller: fileController,
            isOpen: openMenuId == 'file',
            isAnyOpen: openMenuId != null,
            onOpen: () => onOpenMenu('file', fileController),
            onClose: onCloseMenu,
            items: [
              MenuItemButton(
                child: const Text('Save', style: TextStyles.bodyText),
                onPressed: () {},
              ),
              MenuItemButton(
                child: const Text('Exit', style: TextStyles.bodyText),
                onPressed: () {},
              ),
            ],
          ),

          _MenuButton(
            id: 'help',
            label: 'Help',
            controller: helpController,
            isOpen: openMenuId == 'help',
            isAnyOpen: openMenuId != null,
            onOpen: () => onOpenMenu('help', helpController),
            onClose: onCloseMenu,
            items: [
              MenuItemButton(
                child: const Text('About', style: TextStyles.bodyText),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String id;
  final String label;
  final List<Widget> items;
  final MenuController controller;

  final bool isOpen;
  final bool isAnyOpen;
  final VoidCallback onOpen;
  final VoidCallback onClose;

  const _MenuButton({
    required this.id,
    required this.label,
    required this.items,
    required this.controller,
    required this.isOpen,
    required this.isAnyOpen,
    required this.onOpen,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: controller,
      alignmentOffset: const Offset(0, 6),
      menuChildren: items,
      onClose: () => onClose(),
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.backgroundLight),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: AppColors.tertiary),
          ),
        ),
        elevation: const WidgetStatePropertyAll(4),
      ),
      builder: (context, ctrl, _) {
        final active = isOpen;

        return MouseRegion(
          onEnter: (_) {
            if (isAnyOpen && !active) {
              onOpen();
              ctrl.open();
            }
          },
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              splashColor: AppColors.tertiary,
              hoverColor: active ? AppColors.tertiary : AppColors.tertiary,
              highlightColor: active ? AppColors.tertiary : Colors.transparent,
              focusColor: active ? AppColors.tertiary : Colors.transparent,
              onTap: () {
                if (active) {
                  onClose();
                } else {
                  onOpen();
                  ctrl.open();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: active ? AppColors.tertiary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(label, style: TextStyles.bodyText),
              ),
            ),
          ),
        );
      },
    );
  }
}

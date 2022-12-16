import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view/profile/profile_view.profile.view.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  final controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreen() {
    return [
      Text("Home"),
      Text("Chat "),
      Text("Add"),
      Text("Message"),
      const ProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_outlined),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: const Icon(Icons.home)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.chat_bubble_outline),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: const Icon(Icons.chat_bubble)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.add_a_photo),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: const Icon(Icons.add_a_photo)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.message_outlined),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: const Icon(Icons.message)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person_outline_outlined),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: const Icon(Icons.person)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreen(),
      items: _navBarItem(),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(1),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}

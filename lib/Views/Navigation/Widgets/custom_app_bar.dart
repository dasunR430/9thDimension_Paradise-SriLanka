import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paradise_sri_lanka/Views/ChatBot/ChatsListScreen/chats_list_screen.dart';
import 'package:paradise_sri_lanka/Views/Home/Widgets/search_screen.dart';
import 'package:paradise_sri_lanka/Views/Profile/account_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset('assets/images/Logo/paradise_sl_logo.png', height: 50),
      //centerTitle: true,
      actions: [
        IconButton(
            icon: const Icon(
              Iconsax.search_normal,
              size: 20,
            ),
            onPressed: () {
              Get.to(() => SearchScreen());
            }),
        IconButton(
            icon: const Icon(
              Iconsax.message_text_1,
              size: 20,
            ),
            onPressed: () {
              Get.to(() => ChatListScreen());
            }),
        IconButton(
            icon: const Icon(
              Iconsax.user,
              size: 20,
            ),
            onPressed: () {
              Get.to(() => const AccountScreen());
            }),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

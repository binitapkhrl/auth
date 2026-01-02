import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashboardAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.grey.shade200,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,

      title: Image.asset(
        'assets/logo/saauzi_logo.png',
        height: 180, // actual visible logo size
        fit: BoxFit.contain,
      ),

      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none_outlined,
            color: Colors.grey.shade700,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

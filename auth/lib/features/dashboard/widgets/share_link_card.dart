import 'package:flutter/material.dart';
import 'package:auth/core/services/share_service.dart';
import 'package:auth/core/widgets/social_icon.dart';

class ShareLinkCard extends StatelessWidget {
  final String storeLink;

  const ShareLinkCard({
    super.key,
    required this.storeLink,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Share store link",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          /// Store URL
          SelectableText(
            storeLink,
            style: TextStyle(
              fontSize: 16,
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.grey.shade300, height: 1),
          const SizedBox(height: 16),

          Row(
            children: [
              const Text(
                "Share on ",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(width: 16),

              SocialIcon(
                icon: Icons.facebook,
                color: const Color(0xFF1877F2),
                onTap: () =>
                    ShareService.shareToFacebook(storeLink),
              ),
              const SizedBox(width: 16),

              SocialIcon(
                icon: Icons.camera_alt_outlined,
                color: const Color(0xFFE4405F),
                onTap: () =>
                    ShareService.shareToInstagram(context, storeLink),
              ),
              const SizedBox(width: 16),

              SocialIcon(
                icon: Icons.alternate_email,
                color: Colors.black87,
                onTap: () =>
                    ShareService.shareToTwitter(storeLink),
              ),
              const SizedBox(width: 16),

              SocialIcon(
                icon: Icons.email_outlined,
                color: Colors.grey.shade700,
                onTap: () =>
                    ShareService.shareViaEmail(storeLink),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

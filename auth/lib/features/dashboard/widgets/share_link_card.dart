import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auth/core/services/share_service.dart';
import 'package:auth/core/widgets/social_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            "Share Store Link",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          /// Store URL with tap to copy
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: storeLink));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Link copied to clipboard!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                storeLink,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.grey.shade300, height: 1),
          const SizedBox(height: 16),

          /// Social Icons - horizontally scrollable
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Text(
                  "Share on ",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(width: 16),
                SocialIcon(
                  icon: FontAwesomeIcons.facebookF,
                  color:  theme.colorScheme.primary,
                  onTap: () => ShareService.shareToFacebook(storeLink),
                ),
                const SizedBox(width: 16),
                SocialIcon(
                  icon: Icons.camera_alt_outlined,
                  color:  theme.colorScheme.primary,
                  onTap: () => ShareService.shareToInstagram(context, storeLink),
                ),
                const SizedBox(width: 16),
                SocialIcon(
                  icon: FontAwesomeIcons.xTwitter,
                  color: theme.colorScheme.primary,
                  onTap: () => ShareService.shareToTwitter(storeLink),
                ),
                const SizedBox(width: 16),
                SocialIcon(
                  icon: Icons.email_outlined,
                  color:  theme.colorScheme.primary,
                  onTap: () => ShareService.shareViaEmail(storeLink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

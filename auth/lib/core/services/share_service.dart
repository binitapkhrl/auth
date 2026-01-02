import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareService {
  // Common launcher logic with specialized handling for different schemes
  static Future<void> _launchUrl(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      final bool isEmail = url.scheme == 'mailto';

      // 1. Email handling (NEVER use inAppWebView for mailto)
      if (isEmail) {
        final bool launched = await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
        if (!launched) {
          debugPrint('No email app installed to handle this request.');
        }
        return;
      }

      // 2. Social Media / Web handling
      // Try external application first (Native App)
      bool launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      // Fallback to external browser (Chrome/Safari) if App fails
      // Note: We use externalBrowser instead of inAppWebView for better compatibility 
      // with social login/sharing states.
      if (!launched) {
        await launchUrl(
          url,
          mode: LaunchMode.inAppWebView,
        );
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  static Future<void> shareToFacebook(String url) async {
    final facebookUrl =
        'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(url)}';
    await _launchUrl(facebookUrl);
  }

  static Future<void> shareToTwitter(String url) async {
    final twitterUrl =
        'https://twitter.com/intent/tweet?url=${Uri.encodeComponent(url)}&text=${Uri.encodeComponent("Check out this song!")}';
    await _launchUrl(twitterUrl);
  }

  static Future<void> shareViaEmail(String url) async {
    final String subject = Uri.encodeComponent('Check out this song');
    final String body = Uri.encodeComponent('Listen to this song: $url');
    
    // mailto:? is the correct format for no specific recipient
    final String mailtoUrl = 'mailto:?subject=$subject&body=$body';
    await _launchUrl(mailtoUrl);
  }

  static Future<void> shareToInstagram(BuildContext context, String url) async {
    // Instagram doesn't support web-based sharing via URL reliably.
    // Using share_plus is the industry standard for Instagram.
    await Share.share(
      'Check out this song: $url',
      subject: 'Check out this song',
    );
  }
}
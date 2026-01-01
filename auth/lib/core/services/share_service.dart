import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareService {
  static Future<void> shareToFacebook(String url) async {
    final facebookUrl = Uri.parse(
      'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(url)}',
    );

    if (await canLaunchUrl(facebookUrl)) {
      await launchUrl(
        facebookUrl,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  static Future<void> shareToInstagram(BuildContext context, String url) async {
    await Share.share(
      'Check out my store: $url',
      subject: 'Visit my Saauzi Store',
    );
  }

  static Future<void> shareToTwitter(String url) async {
    final twitterUrl = Uri.parse(
      'https://twitter.com/intent/tweet'
      '?url=${Uri.encodeComponent(url)}'
      '&text=${Uri.encodeComponent("Check out my store!")}',
    );

    if (await canLaunchUrl(twitterUrl)) {
      await launchUrl(
        twitterUrl,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  static Future<void> shareViaEmail(String url) async {
    final emailUrl = Uri.parse(
      'mailto:?subject=${Uri.encodeComponent("Check out my Saauzi Store")}'
      '&body=${Uri.encodeComponent("Visit my store at: $url")}',
    );

    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);
    }
  }
}

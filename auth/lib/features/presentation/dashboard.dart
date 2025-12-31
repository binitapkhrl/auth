import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auth/core/widgets/app_primary_button.dart';
import 'package:auth/core/widgets/navigation_bar.dart';
import 'package:auth/core/widgets/stat_box.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  // Share functions
  void _shareToFacebook(String url) async {
    final facebookUrl = Uri.parse('https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(url)}');
    if (await canLaunchUrl(facebookUrl)) {
      await launchUrl(facebookUrl, mode: LaunchMode.externalApplication);
    }
  }

  void _shareToInstagram(BuildContext context, String url) async {
    await Share.share('Check out my store: $url', subject: 'Visit my Saauzi Store');
  }

  void _shareToTwitter(String url) async {
    final twitterUrl = Uri.parse(
        'https://twitter.com/intent/tweet?url=${Uri.encodeComponent(url)}&text=${Uri.encodeComponent("Check out my store!")}');
    if (await canLaunchUrl(twitterUrl)) {
      await launchUrl(twitterUrl, mode: LaunchMode.externalApplication);
    }
  }

  void _shareViaEmail(String url) async {
    final emailUrl = Uri.parse(
        'mailto:?subject=${Uri.encodeComponent("Check out my Saauzi Store")}&body=${Uri.encodeComponent("Visit my store at: $url")}');
    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    const String storeLink = "https://saauzi.com/yourstore";

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 1,
              ),
            ],
          ),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 100,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Center(
                child: Image.asset(
                  'assets/logo/saauzi_logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Text(
                    "LOGO",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_none_outlined, color: Colors.grey.shade700),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 36,
                    child: AppPrimaryButton(
                      text: "Visit Store",
                      fontSize: 12,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Promo Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: theme.colorScheme.primary.withAlpha(26),
                          child: Image.asset(
                            'assets/logo/pos_new.png',
                            fit: BoxFit.cover,
                            color: Colors.black.withAlpha(50),
                            colorBlendMode: BlendMode.darken,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(102),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              "Introducing POS(Point Of Sale)Beta",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withAlpha(128),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Start sellin in-person with our all new pos system",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withAlpha(230),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: AppPrimaryButton(
                                text: "Go to POS Dashboard",
                                fontSize: 16,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Share Store Link Card
              Container(
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
                        _SocialIcon(
                          icon: Icons.facebook,
                          color: const Color(0xFF1877F2),
                          onTap: () => _shareToFacebook(storeLink),
                        ),
                        const SizedBox(width: 16),
                        _SocialIcon(
                          icon: Icons.camera_alt_outlined,
                          color: const Color(0xFFE4405F),
                          onTap: () => _shareToInstagram(context, storeLink),
                        ),
                        const SizedBox(width: 16),
                        _SocialIcon(
                          icon: Icons.alternate_email,
                          color: Colors.black87,
                          onTap: () => _shareToTwitter(storeLink),
                        ),
                        const SizedBox(width: 16),
                        _SocialIcon(
                          icon: Icons.email_outlined,
                          color: Colors.grey.shade700,
                          onTap: () => _shareViaEmail(storeLink),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Performance Summary Section
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         const Text(
              //           "Performance Summary",
              //           style: TextStyle(
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black87,
              //           ),
              //         ),
              //         TextButton.icon(
              //           onPressed: () {
              //             // TODO: Show filter dialog or bottom sheet
              //           },
              //           icon: const Icon(Icons.tune, size: 18),
              //           label: const Text("Apply Filter"),
              //           style: TextButton.styleFrom(
              //             foregroundColor: theme.colorScheme.primary,
              //           ),
              //         ),
              //       ],
              //     ),
              //     const SizedBox(height: 16),

              //     // First Row: Total Orders, Total Products, Featured Products
              //     GridView.count(
              //       shrinkWrap: true,
              //       physics: const NeverScrollableScrollPhysics(),
              //       crossAxisCount: 3,
              //       childAspectRatio: 1.1,
              //       mainAxisSpacing: 16,
              //       crossAxisSpacing: 12,
              //       children: const [
              //         StatBox(icon: Icons.shopping_bag_outlined, value: "1.3k", label: "Total Orders"),
              //         StatBox(icon: Icons.inventory_2_outlined, value: "248", label: "Total Products"),
              //         StatBox(icon: Icons.star_outline, value: "56", label: "Featured Products"),
              //       ],
              //     ),

              //     const SizedBox(height: 24),

              //     // Second Row: Total Orders, Shipped, Pending
              //     GridView.count(
              //       shrinkWrap: true,
              //       physics: const NeverScrollableScrollPhysics(),
              //       crossAxisCount: 3,
              //       childAspectRatio: 1.1,
              //       mainAxisSpacing: 12,
              //       crossAxisSpacing: 12,
              //       children: const [
              //         StatBox(icon: Icons.check_circle_outline, value: "1.1k", label: "Total Orders"),
              //         StatBox(icon: Icons.local_shipping_outlined, value: "892", label: "Shipped Orders"),
              //         StatBox(icon: Icons.pending_outlined, value: "408", label: "Pending Orders"),
              //       ],
              //     ),
              //   ],
              // ),
              Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Performance Summary",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        TextButton.icon(
          onPressed: () {
            // TODO: Show filter dialog or bottom sheet
          },
          icon: const Icon(Icons.tune, size: 18),
          label: const Text("Apply Filter"),
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.primary,
          ),
        ),
      ],
    ),
    const SizedBox(height: 16),

    // First Row: Larger, prominent stats
    Row(
      children: const [
        Expanded(
          child: StatBox(
            icon: Icons.shopping_bag_outlined,
            value: "1.3k",
            label: "Total Orders",
            height: 130,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: StatBox(
            icon: Icons.inventory_2_outlined,
            value: "248",
            label: "Total Products",
            height: 130,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: StatBox(
            icon: Icons.star_outline,
            value: "56",
            label: "Featured Products",
            height: 130,
          ),
        ),
      ],
    ),

    const SizedBox(height: 24),

    // Second Row: Smaller secondary stats
    Row(
      children: const [
        Expanded(
          child: StatBox(
            icon: Icons.check_circle_outline,
            value: "1.1k",
            label: "Total Orders",
            height: 110,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: StatBox(
            icon: Icons.local_shipping_outlined,
            value: "892",
            label: "Shipped Orders",
            height: 110,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: StatBox(
            icon: Icons.pending_outlined,
            value: "408",
            label: "Pending Orders",
            height: 110,
          ),
        ),
      ],
    ),
  ],
),

              const SizedBox(height: 100), // Bottom space for floating nav bar
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 10,
        ),
        child: const CustomBottomNavBar(),
      ),
    );
  }
}


// Social Icon Widget (unchanged, improved with InkWell)
class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _SocialIcon({
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Icon(
          icon,
          size: 24,
          color: color ?? Colors.grey.shade700,
        ),
      ),
    );
  }
}
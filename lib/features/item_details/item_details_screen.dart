import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String id;
  const ItemDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () => context.pop(),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        elevation: 2,
                        shadowColor: Colors.black12,
                      ),
                    ),
                    Text(
                      "Item Details",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.flag_outlined),
                      onPressed: () {},
                      color: Theme.of(context).colorScheme.error,
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        elevation: 2,
                        shadowColor: Colors.black12,
                      ),
                    ),
                  ],
                ),
              ),

              // Image with Blur
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Center(
                      child: Icon(Icons.account_balance_wallet, size: 100, color: Colors.grey.shade400),
                    ),
                  ),
                  Positioned(
                    top: AppSpacing.lg,
                    left: AppSpacing.lg + AppSpacing.md, // Account for margin
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: Theme.of(context).success,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                      child: Text(
                        "FOUND",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: 180,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              border: Border.all(color: Colors.white.withOpacity(0.5)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.visibility_off_rounded, color: Colors.white, size: 20),
                                const SizedBox(width: AppSpacing.sm),
                                Text(
                                  "Sensitive Info Blurred",
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Black Leather Wallet",
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            Text(
                              "Personal Effects",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                              child: Text("•", style: TextStyle(color: Theme.of(context).hintColor)),
                            ),
                            Text(
                              "Found 2 hours ago",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        _InfoTag(icon: Icons.location_on_rounded, label: "Liberty Market, Lahore"),
                        _InfoTag(icon: Icons.calendar_today_rounded, label: "Oct 24, 2023"),
                        _InfoTag(icon: Icons.category_rounded, label: "Accessories"),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Divider(color: Theme.of(context).dividerColor),
                    const SizedBox(height: AppSpacing.lg),

                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      "Found near the main entrance parking. Contains some cash and a student ID card. The name on the ID is partially visible but blurred for privacy. Please provide the name on the ID to claim.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    Text(
                      "Location",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(color: Theme.of(context).dividerColor),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Center(child: Icon(Icons.map, size: 48, color: Colors.grey.shade400)),
                          Center(child: Icon(Icons.location_on_rounded, color: Theme.of(context).colorScheme.error, size: 40)),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Secure Claim Process
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                        border: Border.all(color: Theme.of(context).primaryColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Secure Claim Process",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _StepIndicator(number: "1", title: "Identity Verification", active: true),
                          const SizedBox(height: AppSpacing.sm),
                          _StepIndicator(number: "2", title: "Challenge Question", active: false),
                          const SizedBox(height: AppSpacing.sm),
                          _StepIndicator(number: "3", title: "Handover Arrangement", active: false),
                          const SizedBox(height: AppSpacing.md),

                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(AppRadius.lg),
                              border: Border.all(color: Theme.of(context).dividerColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Founder's Challenge Question:",
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  "What is the full name printed on the ID card inside?",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.push('/claim/$id');
                            },
                            icon: const Icon(Icons.check_circle_outline_rounded),
                            label: const Text("Start Claim Process"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shield_rounded, color: Theme.of(context).success, size: 18),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          "Verified by Foundora Moderation Team",
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoTag({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final String number;
  final String title;
  final bool active;

  const _StepIndicator({required this.number, required this.title, required this.active});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: active ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(
              color: active ? Colors.transparent : Theme.of(context).dividerColor,
            ),
          ),
          child: Center(
            child: Text(
              number,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: active ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: active ? Theme.of(context).colorScheme.onSurface : Theme.of(context).hintColor,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

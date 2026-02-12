import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme.dart';

class ClaimVerificationScreen extends StatefulWidget {
  final String id;
  const ClaimVerificationScreen({super.key, required this.id});

  @override
  State<ClaimVerificationScreen> createState() => _ClaimVerificationScreenState();
}

class _ClaimVerificationScreenState extends State<ClaimVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        ),
        title: const Text("Claim Verification"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Steps
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StepIndicator(number: "1", label: "Details", active: false),
                  Container(width: 40, height: 1, color: Theme.of(context).dividerColor),
                  _StepIndicator(number: "2", label: "Verify", active: true),
                  Container(width: 40, height: 1, color: Theme.of(context).dividerColor),
                  _StepIndicator(number: "3", label: "Handover", active: false),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Item Summary
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: Theme.of(context).dividerColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Icon(Icons.account_balance_wallet, size: 40, color: Colors.grey.shade500),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Leather Wallet",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
                              const SizedBox(width: 4),
                              Text(
                                "Near Central Park",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              "ID: #FND-8291",
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Security Challenge
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9C4),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: const Color(0xFFFFF176)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.security_rounded, color: Color(0xFFFBC02D)),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Security Challenge",
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: const Color(0xFFF57F17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            "The founder has set a specific question to verify ownership. Please be as descriptive as possible.",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFFF57F17),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Question
              Text(
                "Challenge Question",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: Text(
                  "What are the specific contents inside the wallet (cards, photos, or unique markings)?",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Answer
              Text(
                "Your Answer",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                maxLines: 5,
                minLines: 3,
                decoration: InputDecoration(
                  hintText: "Describe the items in detail...",
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    borderSide: BorderSide(color: Theme.of(context).dividerColor),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.pop(); // Go back or to success screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Claim Request Submitted")),
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text("Submit Claim Request"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline_rounded, size: 16, color: Theme.of(context).hintColor),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    "Incorrect answers may lead to account flags.",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "English",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 12,
                        width: 1,
                        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        color: Theme.of(context).dividerColor,
                      ),
                      Text(
                        "اردو",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final String number;
  final String label;
  final bool active;

  const _StepIndicator({required this.number, required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: active ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(
              color: active ? Colors.transparent : Theme.of(context).dividerColor,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: active ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: active ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

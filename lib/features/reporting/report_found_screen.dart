import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:foundora/core/models/item_report.dart';
import 'package:foundora/core/services/firestore_service.dart';
import '../../theme.dart';

class ReportFoundScreen extends StatefulWidget {
  const ReportFoundScreen({super.key});

  @override
  State<ReportFoundScreen> createState() => _ReportFoundScreenState();
}

class _ReportFoundScreenState extends State<ReportFoundScreen> {
  String _selectedCategory = "Electronics";
  final List<String> _categories = ["Electronics", "Wallets", "Documents", "Keys", "Pets", "Other"];

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _challengeController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _challengeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text("Report Found Item"),
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
                children: [
                  _StepIndicator(step: "1", title: "Details", active: true),
                  Expanded(child: Container(height: 1, color: Theme.of(context).dividerColor, margin: const EdgeInsets.symmetric(horizontal: 12))),
                  _StepIndicator(step: "2", title: "Security", active: false), // Both visible as headers
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Photo
              _FormLabel(label: "Item Photo"),
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined, size: 32, color: Theme.of(context).primaryColor),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      "Upload clear photos of the item",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      "Sensitive info will be blurred automatically",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Fields
              _FormLabel(label: "Item Name"),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "e.g. Blue Leather Wallet",
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              _FormLabel(label: "Category"),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _selectedCategory = v!),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              _FormLabel(label: "Description"),
              TextField(
                controller: _descController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Describe unique features, brand, or markings...",
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              _FormLabel(label: "Found Location"),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on_rounded, color: Theme.of(context).colorScheme.error, size: 24),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select on Map",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Tap to tag the exact spot",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, color: Theme.of(context).hintColor),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),
              Divider(color: Theme.of(context).dividerColor),
              const SizedBox(height: AppSpacing.lg),

              // Security
              Row(
                children: [
                  Icon(Icons.verified_user_outlined, color: Theme.of(context).success, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    "Ownership Verification",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                "Set a question only the real owner can answer. Do not include the answer in your description.",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _FormLabel(label: "Challenge Question"),
              TextField(
                controller: _challengeController,
                decoration: InputDecoration(
                  hintText: "e.g. What is the name of the ID inside?",
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : () => _submit(context),
                  child: Text(_isSubmitting ? 'Posting...' : 'Post Found Item'),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 56,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Save as Draft",
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    final challenge = _challengeController.text.trim();

    if (title.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields.')));
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final now = DateTime.now();
      final report = ItemReport(
        id: 'found_${now.microsecondsSinceEpoch}',
        type: ReportType.found,
        title: title,
        description: desc,
        category: _selectedCategory,
        locationText: 'Select on Map',
        challengeQuestion: challenge.isEmpty ? null : challenge,
        createdAt: now,
        updatedAt: now,
      );
      await FirestoreService.instance.createReport(report);
      if (!context.mounted) return;
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Found item reported!')));
    } catch (e) {
      debugPrint('Failed to post found report: $e');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to post report. Please try again.')));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}

class _StepIndicator extends StatelessWidget {
  final String step;
  final String title;
  final bool active;

  const _StepIndicator({required this.step, required this.title, required this.active});

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
              color: active ? Theme.of(context).primaryColor : Theme.of(context).dividerColor,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            step,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: active ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: active ? Theme.of(context).colorScheme.onSurface : Theme.of(context).hintColor,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _FormLabel extends StatelessWidget {
  final String label;

  const _FormLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

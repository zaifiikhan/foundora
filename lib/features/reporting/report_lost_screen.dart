import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:foundora/core/models/item_report.dart';
import 'package:foundora/core/services/firestore_service.dart';
import '../../theme.dart';

class ReportLostScreen extends StatefulWidget {
  const ReportLostScreen({super.key});

  @override
  State<ReportLostScreen> createState() => _ReportLostScreenState();
}

class _ReportLostScreenState extends State<ReportLostScreen> {
  String _selectedCategory = "Electronics";
  final List<String> _categories = ["Electronics", "Wallets", "Documents", "Keys", "Pets", "Others"];

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
        title: const Text("Report Lost Item"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress Bar
              Row(
                children: [
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(AppRadius.full)))),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: Theme.of(context).dividerColor, borderRadius: BorderRadius.circular(AppRadius.full)))),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: Theme.of(context).dividerColor, borderRadius: BorderRadius.circular(AppRadius.full)))),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Photos
              _FormLabel(label: "Item Photos", required: true),
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
                    Icon(Icons.add_a_photo_rounded, size: 32, color: Theme.of(context).primaryColor),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      "Upload images of the item",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      "Supports JPG, PNG (Max 5MB)",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Item Name
              _FormLabel(label: "Item Name", required: true),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "e.g. Silver iPhone 13 Pro",
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Category
              _FormLabel(label: "Category", required: true),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedCategory = cat;
                      });
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    labelStyle: TextStyle(
                      color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      side: BorderSide(
                        color: isSelected ? Colors.transparent : Theme.of(context).dividerColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Description
              _FormLabel(label: "Description", required: true),
              TextField(
                controller: _descController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Provide unique markings, scratches, or details...",
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Location
              _FormLabel(label: "Last Seen Location", required: true),
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: Theme.of(context).dividerColor),
                  color: Colors.grey.shade200,
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Mock Map
                    Image.network(
                      'https://maps.googleapis.com/maps/api/staticmap?center=40.714728,-73.998672&zoom=12&size=600x300&maptype=roadmap&key=YOUR_API_KEY', // Placeholder URL, usually use Image.asset
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade200,
                        child: Center(
                          child: Icon(Icons.map_rounded, size: 48, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    Center(
                      child: Icon(Icons.location_on_rounded, color: Theme.of(context).colorScheme.error, size: 36),
                    ),
                    Positioned(
                      bottom: AppSpacing.md,
                      right: AppSpacing.md,
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(Icons.my_location_rounded, color: Theme.of(context).primaryColor, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded, color: Theme.of(context).colorScheme.onSurfaceVariant, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        "Saddar Town, Karachi, Pakistan",
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Ownership Proof
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: const Color(0xFFBBDEFB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.security_rounded, color: Theme.of(context).primaryColor, size: 20),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          "Ownership Proof",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      "Set a challenge question for whoever finds this item.",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: _challengeController,
                      decoration: InputDecoration(
                        hintText: "e.g. What is the wallpaper on the phone?",
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : () => _submit(context),
                  icon: const Icon(Icons.campaign_rounded),
                  label: Text(_isSubmitting ? "Posting..." : "Post Report"),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline_rounded, size: 14, color: Theme.of(context).hintColor),
                  const SizedBox(width: 4),
                  Text(
                    "Your contact details are hidden until you approve a claim.",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
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
        id: 'lost_${now.microsecondsSinceEpoch}',
        type: ReportType.lost,
        title: title,
        description: desc,
        category: _selectedCategory,
        locationText: 'Saddar Town, Karachi, Pakistan',
        challengeQuestion: challenge.isEmpty ? null : challenge,
        createdAt: now,
        updatedAt: now,
      );
      await FirestoreService.instance.createReport(report);
      if (!context.mounted) return;
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Report posted successfully!')));
    } catch (e) {
      debugPrint('Failed to post lost report: $e');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to post report. Please try again.')));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}

class _FormLabel extends StatelessWidget {
  final String label;
  final bool required;

  const _FormLabel({required this.label, this.required = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (required) ...[
            const SizedBox(width: 4),
            Text("*", style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
        ],
      ),
    );
  }
}

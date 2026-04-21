import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _pushEnabled = true;
  bool _proximityEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                          color: Colors.grey.shade300,
                        ),
                        child: Icon(Icons.person, size: 40, color: Colors.grey.shade600),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
                          ),
                          child: Icon(Icons.edit_rounded, size: 14, color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Adan Shah", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                        Text("adan.s@foundora.com", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Stats
              Row(
                children: [
                  Expanded(child: _StatCard(label: "Items Lost", value: "12")),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: _StatCard(label: "Items Found", value: "08")),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: _StatCard(label: "Matches", value: "05")),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Account Settings
              Text("Account Settings", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: AppSpacing.md),
              _SettingsItem(
                icon: Icons.person_outline_rounded,
                title: "Personal Information",
                subtitle: "Edit name, email, and phone",
                onTap: () => context.push('/personal-info'),
              ),
              _SettingsItem(
                icon: Icons.security_rounded,
                title: "Security",
                subtitle: "Change your password",
                onTap: () => context.push('/security'),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Notifications
              Text("Notifications", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: AppSpacing.md),
              _ToggleSetting(
                icon: Icons.notifications_none_rounded,
                title: "Push Notifications",
                subtitle: "Real-time alerts for matches",
                value: _pushEnabled,
                onChanged: (v) => setState(() => _pushEnabled = v),
              ),
              _ToggleSetting(
                icon: Icons.radar_rounded,
                title: "Proximity Alerts",
                subtitle: "Items found near your location",
                value: _proximityEnabled,
                onChanged: (v) => setState(() => _proximityEnabled = v),
              ),
              const SizedBox(height: AppSpacing.lg),

              Divider(color: Theme.of(context).dividerColor),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.go('/welcome'),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text("Sign Out"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- HELPER WIDGETS ---
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(AppRadius.lg), border: Border.all(color: Theme.of(context).dividerColor)),
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
          Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _SettingsItem({required this.icon, required this.title, required this.subtitle, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(AppRadius.lg), border: Border.all(color: Theme.of(context).dividerColor)),
        child: Row(
          children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(AppRadius.md)), child: Icon(icon, color: Theme.of(context).primaryColor, size: 22)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)), Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis)])),
            Icon(Icons.chevron_right_rounded, color: Theme.of(context).hintColor, size: 20),
          ],
        ),
      ),
    );
  }
}

class _ToggleSetting extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _ToggleSetting({required this.icon, required this.title, required this.subtitle, required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(AppRadius.lg), border: Border.all(color: Theme.of(context).dividerColor)),
      child: Row(
        children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(AppRadius.md)), child: Icon(icon, color: Theme.of(context).primaryColor, size: 22)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)), Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant))])),
          Switch(value: value, onChanged: onChanged, activeColor: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}
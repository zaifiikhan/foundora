import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedCategory = "All";
  final List<String> _categories = ["All", "Electronics", "Wallets", "Pets", "Keys"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showReportOptions(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text("Report Item"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.md, AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Foundora",
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "Lost it? Find it. Found it? Return it.",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).dividerColor),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.notifications_none_rounded,
                              color: Theme.of(context).colorScheme.onSurface,
                              size: 24,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '3',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onError,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search for lost items, keys, pets...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      borderSide: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      borderSide: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // AI Banner
              GestureDetector(
                onTap: () => context.push('/matching'),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).colorScheme.tertiary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.auto_awesome_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "AI Smart Match",
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              "We found 2 potential matches for your reported wallet!",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, color: Colors.white),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  "Categories",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: _categories.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    IconData icon;
                    switch (cat) {
                      case "Electronics": icon = Icons.devices_rounded; break;
                      case "Wallets": icon = Icons.account_balance_wallet_rounded; break;
                      case "Pets": icon = Icons.pets_rounded; break;
                      case "Keys": icon = Icons.vpn_key_rounded; break;
                      default: icon = Icons.all_inclusive; break;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: ActionChip(
                        onPressed: () => setState(() => _selectedCategory = cat),
                        avatar: Icon(
                          icon,
                          size: 16,
                          color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        label: Text(
                          cat,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        backgroundColor: isSelected ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.surface,
                        side: BorderSide(
                          color: isSelected ? Colors.transparent : Theme.of(context).dividerColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Recent Reports
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Reports",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See All",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    _ItemCard(
                      type: "LOST",
                      labelBg: const Color(0xFFFFEBEE),
                      labelText: Theme.of(context).colorScheme.error,
                      title: "Golden Retriever",
                      location: "Central Park, NY",
                      date: "2 hours ago",
                      // Placeholder color/icon instead of image for now
                      color: Colors.orange.shade100,
                      icon: Icons.pets,
                    ),
                    _ItemCard(
                      type: "FOUND",
                      labelBg: const Color(0xFFE8F5E9),
                      labelText: Theme.of(context).success,
                      title: "iPhone 13 Pro - Blue",
                      location: "Starbucks, 5th Ave",
                      date: "5 hours ago",
                      color: Colors.blue.shade100,
                      icon: Icons.smartphone,
                    ),
                    _ItemCard(
                      type: "LOST",
                      labelBg: const Color(0xFFFFEBEE),
                      labelText: Theme.of(context).colorScheme.error,
                      title: "Leather Wallet",
                      location: "Subway Station",
                      date: "Yesterday",
                      color: Colors.brown.shade100,
                      icon: Icons.account_balance_wallet,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80), // Fab space
            ],
          ),
        ),
      ),
    );
  }

  void _showReportOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.search_off_rounded, color: Colors.red),
              title: const Text("I Lost Something"),
              onTap: () {
                Navigator.pop(context);
                context.push('/report/lost');
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle_outline_rounded, color: Colors.green),
              title: const Text("I Found Something"),
              onTap: () {
                Navigator.pop(context);
                context.push('/report/found');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final String type;
  final Color labelBg;
  final Color labelText;
  final String title;
  final String location;
  final String date;
  final Color color;
  final IconData icon;

  const _ItemCard({
    required this.type,
    required this.labelBg,
    required this.labelText,
    required this.title,
    required this.location,
    required this.date,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/item/1'); // Mock ID
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 160,
              child: Stack(
                children: [
                  Container(
                    color: color,
                    child: Center(
                      child: Icon(icon, size: 64, color: Colors.black12),
                    ),
                  ),
                  Positioned(
                    top: AppSpacing.md,
                    left: AppSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: labelBg,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                      child: Text(
                        type,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: labelText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          location,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Icon(Icons.arrow_forward_rounded, size: 18, color: Theme.of(context).primaryColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:foundora/core/models/item_report.dart';
import 'package:foundora/core/services/firestore_service.dart';
import '../../theme.dart';

class AiMatchingScreen extends StatefulWidget {
  const AiMatchingScreen({super.key});

  @override
  State<AiMatchingScreen> createState() => _AiMatchingScreenState();
}

class _AiMatchingScreenState extends State<AiMatchingScreen> {
  String _selectedCategory = "All Matches";
  final List<String> _categories = ["All Matches", "High Confidence", "Electronics", "Accessories", "Pets", "Wallets", "Keys", "Documents", "Others"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showReportOptions(context),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.black, width: 2)),
        backgroundColor: const Color(0xFFB9710D),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        icon: const Icon(Icons.add, color: Colors.white,),
        label: const Text("Report New", style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AI Matcher",
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Foundora Intelligent Assistant",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),

                    // MODIFIED: Calls the bottom sheet just like the dashboard!
                    InkWell(
                      onTap: () => showNotificationsSheet(context),
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Theme.of(context).dividerColor),
                        ),
                        child: Center(
                          child: Icon(Icons.notifications_outlined, size: 22, color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Banner
              Container(
                margin: const EdgeInsets.all(AppSpacing.lg),
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
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
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.psychology_rounded, color: Colors.white, size: 28),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          "AI Analysis Complete",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      "We match your Lost reports against Found reports using title/description/category/location signals.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bolt, color: Colors.white, size: 16),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            "Updates live as you post reports",
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Filters
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: _categories.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: ActionChip(
                        onPressed: () => setState(() => _selectedCategory = cat),
                        label: Text(
                          cat,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: isSelected ? Colors.orange : Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        backgroundColor: isSelected ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.surface,
                        side: BorderSide(
                          color: isSelected ? Colors.transparent : Theme.of(context).dividerColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Potential Matches Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  "Potential Matches",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: StreamBuilder<List<ItemReport>>(
                  stream: FirestoreService.instance.watchReports(),
                  builder: (context, snapshot) {
                    final reports = snapshot.data;
                    if (reports == null) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
                        child: Center(
                          child: SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      );
                    }

                    final matches = _filterMatches(_computeMatches(reports));
                    if (matches.isEmpty) {
                      return _EmptyMatchesCard(onReport: () => _showReportOptions(context));
                    }

                    return Column(
                      children: [
                        for (final m in matches)
                          _MatchItemCard(
                            title: m.found.title,
                            category: m.category,
                            date: _MatchItemCard.relativeTime(m.found.createdAt),
                            location: m.found.locationText,
                            matchPct: m.matchPct,
                            badgeBg: m.matchPct >= 85 ? Theme.of(context).success : Theme.of(context).colorScheme.tertiary,
                            badgeText: Colors.white,
                            color: _MatchItemCard.swatchForCategory(m.category),
                            icon: _MatchItemCard.iconForCategory(m.category),
                          ),
                      ],
                    );
                  },
                ),
              ),

              // Chart
              Container(
                margin: const EdgeInsets.all(AppSpacing.lg),
                padding: const EdgeInsets.all(AppSpacing.lg),
                height: 300,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Matching Accuracy",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const titles = ["Mon", "Tue", "Wed", "Thu", "Fri"];
                                  if (value.toInt() >= 0 && value.toInt() < titles.length) {
                                    return Text(titles[value.toInt()], style: TextStyle(fontSize: 10));
                                  }
                                  return const Text("");
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 45),
                                FlSpot(1, 60),
                                FlSpot(2, 55),
                                FlSpot(3, 80),
                                FlSpot(4, 95),
                              ],
                              isCurved: true,
                              color: Theme.of(context).primaryColor,
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: true),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Efficiency improved by 12% this week",
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).success,
                          ),
                        ),
                        Icon(Icons.trending_up, size: 16, color: Theme.of(context).success),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  void _showReportOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      showDragHandle: true,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.search_off_rounded, color: Theme.of(context).colorScheme.error),
                title: const Text('I Lost Something'),
                onTap: () {
                  ctx.pop();
                  context.push('/report/lost');
                },
              ),
              ListTile(
                leading: Icon(Icons.check_circle_outline_rounded, color: Theme.of(context).success),
                title: const Text('I Found Something'),
                onTap: () {
                  ctx.pop();
                  context.push('/report/found');
                },
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        );
      },
    );
  }

  List<_MatchCandidate> _filterMatches(List<_MatchCandidate> matches) {
    if (_selectedCategory == 'All Matches') return matches;
    if (_selectedCategory == 'High Confidence') return matches.where((m) => m.matchPct >= 85).toList();
    return matches.where((m) => m.category == _selectedCategory).toList();
  }

  List<_MatchCandidate> _computeMatches(List<ItemReport> reports) {
    final lost = reports.where((r) => r.type == ReportType.lost).toList();
    final found = reports.where((r) => r.type == ReportType.found).toList();
    if (lost.isEmpty || found.isEmpty) return const [];

    final all = <_MatchCandidate>[];
    for (final l in lost) {
      final scored = <_MatchCandidate>[];
      for (final f in found) {
        final pct = _scorePct(l, f);
        if (pct < 40) continue;
        scored.add(_MatchCandidate(lost: l, found: f, matchPct: pct));
      }
      scored.sort((a, b) => b.matchPct.compareTo(a.matchPct));
      all.addAll(scored.take(3));
    }

    all.sort((a, b) {
      final s = b.matchPct.compareTo(a.matchPct);
      if (s != 0) return s;
      return b.found.createdAt.compareTo(a.found.createdAt);
    });
    return all.take(24).toList();
  }

  int _scorePct(ItemReport lost, ItemReport found) {
    double score = 0;

    // Category signal.
    if (lost.category.trim().isNotEmpty && lost.category.toLowerCase() == found.category.toLowerCase()) score += 0.35;

    // Title/description token overlap.
    final lostTokens = _tokens('${lost.title} ${lost.description}');
    final foundTokens = _tokens('${found.title} ${found.description}');
    if (lostTokens.isNotEmpty && foundTokens.isNotEmpty) {
      final intersection = lostTokens.intersection(foundTokens).length;
      final union = lostTokens.union(foundTokens).length;
      if (union > 0) score += 0.45 * (intersection / union);
    }

    // Location string similarity (very lightweight).
    final locA = lost.locationText.toLowerCase();
    final locB = found.locationText.toLowerCase();
    if (locA.isNotEmpty && locB.isNotEmpty) {
      if (locA == locB) {
        score += 0.20;
      } else {
        final a = _tokens(locA);
        final b = _tokens(locB);
        final union = a.union(b).length;
        if (union > 0) score += 0.20 * (a.intersection(b).length / union);
      }
    }

    final pct = (score.clamp(0, 1) * 100).round();
    return pct.clamp(0, 99); // leave room for true AI later
  }

  Set<String> _tokens(String text) {
    final cleaned = text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    if (cleaned.isEmpty) return {};
    final stop = {'the', 'a', 'an', 'and', 'or', 'of', 'to', 'in', 'on', 'near', 'with', 'for', 'at'};
    return cleaned.split(' ').where((t) => t.length >= 3 && !stop.contains(t)).toSet();
  }
}

class _MatchCandidate {
  final ItemReport lost;
  final ItemReport found;
  final int matchPct;
  const _MatchCandidate({required this.lost, required this.found, required this.matchPct});
  String get category => lost.category;
}

class _EmptyMatchesCard extends StatelessWidget {
  final VoidCallback onReport;
  const _EmptyMatchesCard({required this.onReport});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome_rounded, color: Theme.of(context).primaryColor),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'No matches yet',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Post at least one Lost and one Found report to see real-time matches here.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant, height: 1.4),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: onReport,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Create a report'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchItemCard extends StatelessWidget {
  final String title;
  final String category;
  final String date;
  final String location;
  final int matchPct;
  final Color badgeBg;
  final Color badgeText;
  final Color color;
  final IconData icon;

  const _MatchItemCard({
    required this.title,
    required this.category,
    required this.date,
    required this.location,
    required this.matchPct,
    required this.badgeBg,
    required this.badgeText,
    required this.color,
    required this.icon,
  });

  static String relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  static IconData iconForCategory(String category) {
    switch (category) {
      case 'Electronics':
        return Icons.phone_iphone;
      case 'Accessories':
      case 'Wallets':
        return Icons.account_balance_wallet;
      case 'Pets':
        return Icons.pets;
      case 'Keys':
        return Icons.vpn_key;
      case 'Documents':
        return Icons.badge_outlined;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  static Color swatchForCategory(String category) {
    switch (category) {
      case 'Electronics':
        return Colors.blue.shade200;
      case 'Accessories':
      case 'Wallets':
        return Colors.brown.shade200;
      case 'Pets':
        return Colors.orange.shade200;
      case 'Keys':
        return Colors.amber.shade200;
      case 'Documents':
        return Colors.indigo.shade200;
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
                  child: Center(child: Icon(icon, size: 64, color: Colors.black12)),
                ),
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.auto_awesome, size: 12, color: badgeText),
                        const SizedBox(width: 4),
                        Text(
                          "$matchPct% Match",
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: badgeText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: AppSpacing.sm,
                  left: AppSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(
                      category,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    const SizedBox(width: 4),
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
                Divider(color: Theme.of(context).dividerColor),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          context.push('/item/2');
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Theme.of(context).primaryColor),
                          foregroundColor: Theme.of(context).primaryColor,
                        ),
                        child: const Text("View Details"),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/claim/2');
                        },
                        child: const Text("Claim Item"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Optional: Shared helper function included here so it runs instantly.
// If you plan to use this across many files, consider moving it to a 'utils/bottom_sheets.dart' file later!
void showNotificationsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    showDragHandle: true,
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Notifications",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.orange.shade100,
                  child: const Icon(Icons.auto_awesome, color: Colors.orange)
              ),
              title: const Text("High Match Found!"),
              subtitle: const Text("We found a 95% match for your reported wallet."),
              onTap: () => ctx.pop(),
            ),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: const Icon(Icons.check_circle, color: Colors.green)
              ),
              title: const Text("Item Claimed"),
              subtitle: const Text("Someone claimed the keys you found."),
              onTap: () => ctx.pop(),
            ),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.info_outline, color: Colors.blue)
              ),
              title: const Text("Welcome to Foundora"),
              subtitle: const Text("Keep your campus lost-and-found clean and smart!"),
              onTap: () => ctx.pop(),
            ),
          ],
        ),
      );
    },
  );
}
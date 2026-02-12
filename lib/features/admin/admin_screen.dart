import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String _selectedFilter = "All Items";
  final List<String> _filters = ["All Items", "ID Cards", "Electronics", "Wallets", "Pets"];

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Moderation Desk",
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Review and manage platform reports",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                          child: Icon(Icons.notifications_none_rounded, size: 24, color: Theme.of(context).colorScheme.onSurface),
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
                            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                            child: Text(
                              "3",
                              style: TextStyle(color: Theme.of(context).colorScheme.onError, fontSize: 10, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Stats
              Row(
                children: [
                  Expanded(child: _StatCard(label: "Pending", value: "24")),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: _StatCard(label: "Flagged", value: "12")),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: _StatCard(label: "Resolved", value: "158")),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Chart
              Container(
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
                      "Report Volume (Weekly)",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
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
                                  const titles = ["M", "T", "W", "T", "F", "S", "S"];
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
                                FlSpot(0, 12),
                                FlSpot(1, 18),
                                FlSpot(2, 15),
                                FlSpot(3, 25),
                                FlSpot(4, 20),
                                FlSpot(5, 30),
                                FlSpot(6, 24),
                              ],
                              isCurved: true,
                              color: Theme.of(context).primaryColor,
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: true),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Filters
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((f) {
                    final isSelected = _selectedFilter == f;
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: ActionChip(
                        onPressed: () => setState(() => _selectedFilter = f),
                        label: Text(
                          f,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant,
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
              const SizedBox(height: AppSpacing.md),

              // List Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pending Review (24)",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "View History",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Items
              _ReportItem(
                title: "Found: CNIC Card near Metro",
                category: "IDENTITY",
                time: "2m ago",
                reporter: "Ahmed_99",
                icon: Icons.credit_card,
                categoryColor: const Color(0xFFF57C00),
                categoryBg: const Color(0xFFFFF4E5),
              ),
              _ReportItem(
                title: "Lost: iPhone 13 Pro Max",
                category: "ELECTRONICS",
                time: "15m ago",
                reporter: "Sara_Khan",
                icon: Icons.phone_iphone,
                categoryColor: const Color(0xFFF57C00),
                categoryBg: const Color(0xFFFFF4E5),
              ),

              // Flagged Item
              Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: Theme.of(context).colorScheme.error),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: Icon(Icons.inventory_2, color: Colors.grey.shade600),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFEBEE),
                                      borderRadius: BorderRadius.circular(AppRadius.sm),
                                    ),
                                    child: Text(
                                      "FLAGGED",
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: Theme.of(context).colorScheme.error,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "1h ago",
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                "Suspicious: Mystery Package",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Reason: Potential prohibited item",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.delete_outline, size: 16),
                            label: const Text("Delete Post"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.error,
                              foregroundColor: Theme.of(context).colorScheme.onError,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility, size: 16),
                            label: const Text("Keep Post"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              _ReportItem(
                title: "Found: Golden Retriever",
                category: "PETS",
                time: "3h ago",
                reporter: "PetLover_PK",
                icon: Icons.pets,
                categoryColor: const Color(0xFFF57C00),
                categoryBg: const Color(0xFFFFF4E5),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportItem extends StatelessWidget {
  final String title;
  final String category;
  final String time;
  final String reporter;
  final IconData icon;
  final Color categoryColor;
  final Color categoryBg;

  const _ReportItem({
    required this.title,
    required this.category,
    required this.time,
    required this.reporter,
    required this.icon,
    required this.categoryColor,
    required this.categoryBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(icon, color: Colors.grey.shade600),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: categoryBg,
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                          child: Text(
                            category,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: categoryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          time,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Reported by: $reporter",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Divider(color: Theme.of(context).dividerColor),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.block, size: 16),
                  label: const Text("Reject"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                    side: BorderSide(color: Theme.of(context).colorScheme.error),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check_circle_outline, size: 16),
                  label: const Text("Approve"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).success,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

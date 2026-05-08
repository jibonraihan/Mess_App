import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/home_dashboard_providers.dart';
import '../../domain/home_dashboard.dart';
import '../../../../core/responsive/responsive_breakpoints.dart';
import '../widgets/animated_chart_placeholder.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/recent_activity_list.dart';
import '../widgets/statistics_card.dart';
import 'package:mess_app/core/widgets/member_avatar_row.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveBreakpoints.isDesktop(context);
    final dashboard = ref.watch(homeDashboardProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: dashboard.when(
        data: (snapshot) => _DashboardContent(
          snapshot: snapshot,
          isDesktop: isDesktop,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: FilledButton.tonal(
            onPressed: () => ref.invalidate(homeDashboardProvider),
            child: const Text('Retry dashboard'),
          ),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({
    required this.snapshot,
    required this.isDesktop,
  });

  final DashboardSnapshot snapshot;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const MemberAvatarRow(),
        Text(
          'Dashboard overview',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 4),
        Text(
          'Daily operations, finance and updates in one place.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        _buildPrimaryMetrics(context),
        const SizedBox(height: 12),
        _buildSecondaryMetrics(context),
        const SizedBox(height: 12),
        _buildQuickActions(context),
        const SizedBox(height: 12),
        DashboardCard(
          title: 'Monthly expense summary',
          trailing: TextButton(
            onPressed: () => context.go('/expenses'),
            child: const Text('Open'),
          ),
          child: const AnimatedChartPlaceholder(),
        ),
        const SizedBox(height: 12),
        _buildStatsGrid(snapshot.stats),
        const SizedBox(height: 12),
        DashboardCard(
          title: 'Recent activities',
          child: RecentActivityList(activities: snapshot.activities),
        ),
        const SizedBox(height: 12),
        DashboardCard(
          title: 'Admin notices',
          trailing: const Icon(Icons.campaign_rounded),
          child: Column(
            children: snapshot.adminNotices
                .map(
                  (notice) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(notice.title),
                    subtitle: Text(notice.message),
                    leading: const Icon(Icons.notifications_active_rounded),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryMetrics(BuildContext context) {
    return isDesktop
        ? Row(
            children: [
              Expanded(
                child: _AmountCard(
                  title: 'Current balance',
                  amount: snapshot.currentBalance,
                  icon: Icons.account_balance_wallet_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _AmountCard(
                  title: 'Pending dues',
                  amount: snapshot.pendingDues,
                  icon: Icons.pending_actions_rounded,
                ),
              ),
            ],
          )
        : Column(
            children: [
              _AmountCard(
                title: 'Current balance',
                amount: snapshot.currentBalance,
                icon: Icons.account_balance_wallet_rounded,
              ),
              const SizedBox(height: 12),
              _AmountCard(
                title: 'Pending dues',
                amount: snapshot.pendingDues,
                icon: Icons.pending_actions_rounded,
              ),
            ],
          );
  }

  Widget _buildSecondaryMetrics(BuildContext context) {
    return isDesktop
        ? Row(
            children: [
              Expanded(
                child: DashboardCard(
                  title: "Today's meal",
                  child: Text(snapshot.todayMeal),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DashboardCard(
                  title: 'Upcoming market duty',
                  child: Text(snapshot.upcomingMarketDuty),
                ),
              ),
            ],
          )
        : Column(
            children: [
              DashboardCard(
                title: "Today's meal",
                child: Text(snapshot.todayMeal),
              ),
              const SizedBox(height: 12),
              DashboardCard(
                title: 'Upcoming market duty',
                child: Text(snapshot.upcomingMarketDuty),
              ),
            ],
          );
  }

  Widget _buildQuickActions(BuildContext context) {
    return DashboardCard(
      title: 'Quick actions',
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _QuickActionChip(
            icon: Icons.add_card_rounded,
            label: 'Add Expense',
            onTap: () => context.go('/expenses'),
          ),
          _QuickActionChip(
            icon: Icons.restaurant_menu_rounded,
            label: 'Update Meal',
            onTap: () => context.go('/meals'),
          ),
          _QuickActionChip(
            icon: Icons.forum_rounded,
            label: 'Open Chat',
            onTap: () => context.go('/chat'),
          ),
          _QuickActionChip(
            icon: Icons.admin_panel_settings_rounded,
            label: 'Admin Panel',
            onTap: () => context.go('/admin'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(List<DashboardStat> stats) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 4 : 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: isDesktop ? 1.55 : 1.15,
      ),
      itemBuilder: (context, index) => StatisticsCard(stat: stats[index]),
    );
  }
}

class _AmountCard extends StatelessWidget {
  const _AmountCard({
    required this.title,
    required this.amount,
    required this.icon,
  });

  final String title;
  final double amount;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: title,
      trailing: Icon(icon),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        tween: Tween(begin: 0, end: amount),
        builder: (context, value, child) {
          return Text(
            '৳${value.toStringAsFixed(0)}',
            style: Theme.of(context).textTheme.headlineMedium,
          );
        },
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: QuickActionButton(
        icon: icon,
        label: label,
        onTap: onTap,
      ),
    );
  }
}

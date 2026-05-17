import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final memberName = 'Raihan';
    final avatarBytes = null;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B16),

      appBar: AppBar(
        title: const Text('Profile'),

        backgroundColor: const Color(0xFF111120),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            Text(
              'Welcome $memberName 👋',

              textAlign: TextAlign.center,

              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 28),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),

              decoration: BoxDecoration(
                color: const Color(0xFF141425),

                borderRadius: BorderRadius.circular(34),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.28),

                    blurRadius: 40,

                    offset: const Offset(0, 14),
                  ),
                ],
              ),

              child: Column(
                children: [
                  /// AVATAR
                  CircleAvatar(
                    radius: 62,

                    backgroundColor: const Color(0xFF5B55A3),

                    backgroundImage: avatarBytes != null
                        ? MemoryImage(avatarBytes)
                        : null,

                    child: avatarBytes == null
                        ? Text(
                            memberName.substring(0, 1).toUpperCase(),

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),

                  const SizedBox(height: 22),

                  /// NAME
                  Text(
                    memberName,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Member of Bosonto Bilash',

                    style: TextStyle(color: Colors.white54, fontSize: 16),
                  ),

                  const SizedBox(height: 40),

                  /// STATS ROW
                  Wrap(
                    spacing: 14,
                    runSpacing: 14,

                    alignment: WrapAlignment.center,

                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width < 500
                            ? 120
                            : 150,

                        child: _ProfileStatCard(
                          icon: Icons.account_balance_wallet_rounded,

                          title: 'Total Deposit',

                          value: '৳ 12,500',
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width < 500
                            ? 120
                            : 150,

                        child: _ProfileStatCard(
                          icon: Icons.restaurant_rounded,

                          title: 'Total Meal',

                          value: '128',
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width < 500
                            ? 120
                            : 150,

                        child: _ProfileStatCard(
                          icon: Icons.savings_rounded,

                          title: 'Balance',

                          value: '৳ 2,340',
                        ),
                      ),
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

class _ProfileStatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileStatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFF111120),

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),

            blurRadius: 24,

            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF8B80F8), size: 30),

          const SizedBox(height: 16),

          Text(
            value,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,

            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

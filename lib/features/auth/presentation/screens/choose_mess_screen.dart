import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseMessScreen extends StatelessWidget {
  const ChooseMessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B16),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {

            final isSmallScreen =
                constraints.maxWidth < 900;

            final leftSection = Container(
              width: double.infinity,

              color: const Color(0xFF5B55A3),

              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 24 : 40,
                vertical: isSmallScreen ? 40 : 60,
              ),

              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    'Choose Your Mess',

                    style: TextStyle(
                      fontSize:
                          isSmallScreen ? 36 : 52,

                      fontWeight: FontWeight.bold,

                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Create a new mess or join an existing one using an invite code.',

                    style: TextStyle(
                      fontSize:
                          isSmallScreen ? 18 : 22,

                      color: Colors.white70,

                      height: 1.5,
                    ),
                  ),
                ],
              ),
            );

            final rightSection = Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width:
                      isSmallScreen
                          ? double.infinity
                          : 500,

                  child: Padding(
                    padding: const EdgeInsets.all(24),

                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        MouseRegion(
                          cursor:
                              SystemMouseCursors.click,

                          child: GestureDetector(
                            onTap: () {
                              context.go(
                                '/mess/create',
                              );
                            },

                            child: _OptionCard(
                              title:
                                  'Create New Mess',

                              subtitle:
                                  'Become admin and generate an invite code.',

                              icon: Icons
                                  .add_business_rounded,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        MouseRegion(
                          cursor:
                              SystemMouseCursors.click,

                          child: GestureDetector(
                            onTap: () {
                              context.go(
                                '/mess/join',
                              );
                            },

                            child: _OptionCard(
                              title:
                                  'Join Existing Mess',

                              subtitle:
                                  'Enter an invite code to join a mess.',

                              icon: Icons
                                  .group_add_rounded,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );

            return isSmallScreen

                ? Column(
                    children: [

                      Expanded(
                        flex: 2,
                        child: leftSection,
                      ),

                      Expanded(
                        flex: 3,
                        child: rightSection,
                      ),
                    ],
                  )

                : Row(
                    children: [

                      Expanded(
                        flex: 2,
                        child: leftSection,
                      ),

                      Expanded(
                        flex: 4,
                        child: rightSection,
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _OptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),

        color: const Color(0xFF171727),

        border: Border.all(
          color: Colors.white.withOpacity(0.06),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),

            blurRadius: 20,

            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 30,

            backgroundColor:
                const Color(0xFF5B55A3),

            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,

                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  subtitle,

                  style: TextStyle(
                    color: Colors.grey.shade400,

                    fontSize: 15,

                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          const Icon(
            Icons.arrow_forward_ios_rounded,

            color: Colors.white70,
          ),
        ],
      ),
    );
  }
}
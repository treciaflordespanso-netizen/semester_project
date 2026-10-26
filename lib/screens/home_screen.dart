import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'report_form_screen.dart';

class HomeScreen extends StatelessWidget {
  final String email;

  const HomeScreen({
    super.key,
    required this.email,
  });

  static const brown = Color(0xFF622B14);
  static const lightBrown = Color(0xFF995F2F);
  static const olive = Color(0xFF978F66);
  static const cream = Color(0xFFE4D6A9);
  static const background = Color(0xFFF8F6F0);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= 800;

        return Scaffold(
          backgroundColor: background,

          drawer: desktop
              ? null
              : Drawer(
                  child: _sidebar(context),
                ),

          appBar: desktop
              ? null
              : AppBar(
                  title: const Text(
                    'TindaSmart',
                    style: TextStyle(
                      color: brown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: background,
                  iconTheme: const IconThemeData(
                    color: brown,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => _logout(context),
                      icon: const Icon(Icons.logout),
                      tooltip: 'Logout',
                    ),
                  ],
                ),

          body: Row(
            children: [
              if (desktop)
                SizedBox(
                  width: 240,
                  child: _sidebar(context),
                ),

              Expanded(
                child: Column(
                  children: [
                    if (desktop) _topBar(),

                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _welcomeCard(),

                            const SizedBox(height: 28),

                            const Text(
                              'Store Overview',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: brown,
                              ),
                            ),

                            const SizedBox(height: 16),

                            _summaryCards(),

                            const SizedBox(height: 28),

                            _sectionTitle('Inventory Status'),

                            const SizedBox(height: 14),

                            _inventoryCard(),

                            const SizedBox(height: 28),

                            _sectionTitle(
                              'Restock Recommendations',
                            ),

                            const SizedBox(height: 14),

                            _restockCard(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // SIDEBAR

  Widget _sidebar(BuildContext context) {
    return Container(
      color: brown,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  Icon(
                    Icons.storefront,
                    color: cream,
                    size: 32,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'TindaSmart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'MAIN MENU',
                style: TextStyle(
                  color: cream,
                  fontSize: 11,
                  letterSpacing: 1,
                ),
              ),
            ),

            const SizedBox(height: 12),

            _navItem(
              context,
              Icons.dashboard_outlined,
              'Dashboard',
              true,
            ),

            _navItem(
              context,
              Icons.inventory_2_outlined,
              'Products',
              false,
            ),

            _navItem(
              context,
              Icons.warehouse_outlined,
              'Inventory',
              false,
            ),

            _navItem(
              context,
              Icons.point_of_sale_outlined,
              'Sales',
              false,
            ),

            _navItem(
              context,
              Icons.people_outline,
              'Customers',
              false,
            ),

            _navItem(
              context,
              Icons.trending_up,
              'Demand Forecast',
              false,
            ),

            _navItem(
              context,
              Icons.shopping_cart_outlined,
              'Restock Recommendations',
              false,
            ),

            _navItem(
              context,
              Icons.notifications_none,
              'Notifications',
              false,
            ),

            _navItem(
              context,
              Icons.assignment_outlined,
              'Inventory Report',
              false,
            ),

            const Spacer(),

            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () => _logout(context),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // NAVIGATION ITEMS

  Widget _navItem(
    BuildContext context,
    IconData icon,
    String title,
    bool selected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: selected ? cream : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: selected ? brown : Colors.white70,
          size: 21,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: selected ? brown : Colors.white,
            fontSize: 12,
            fontWeight:
                selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          if (title == 'Inventory Report') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ReportFormScreen(),
              ),
            );
          }
        },
      ),
    );
  }

  // TOP BAR

  Widget _topBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 20,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Store Management Dashboard',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: brown,
              ),
            ),
          ),

          const Icon(
            Icons.account_circle,
            color: lightBrown,
            size: 30,
          ),

          const SizedBox(width: 10),

          Flexible(
            child: Text(
              email,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // WELCOME CARD

  Widget _welcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            brown,
            lightBrown,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.storefront,
            color: cream,
            size: 38,
          ),

          SizedBox(height: 16),

          Text(
            'Welcome to TindaSmart!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8),

          Text(
            'Manage your inventory, monitor sales, '
            'and plan your store restocking.',
            style: TextStyle(
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // SUMMARY CARDS

  Widget _summaryCards() {
    final cards = [
      (
        'Total Products',
        '0',
        Icons.inventory_2_outlined,
        brown,
      ),
      (
        'Low Stock',
        '0',
        Icons.warning_amber_rounded,
        olive,
      ),
      (
        'Out of Stock',
        '0',
        Icons.remove_shopping_cart,
        Colors.redAccent,
      ),
      (
        "Today's Sales",
        '₱0.00',
        Icons.payments_outlined,
        Colors.green,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 4
            : constraints.maxWidth >= 500
                ? 2
                : 1;

        final width =
            (constraints.maxWidth - ((columns - 1) * 12)) /
                columns;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards.map((card) {
            return SizedBox(
              width: width,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFECE5D9),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      card.$3,
                      color: card.$4,
                      size: 26,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      card.$1,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      card.$2,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: brown,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  // SECTION TITLE

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: brown,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // INVENTORY STATUS

  Widget _inventoryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: const Column(
        children: [
          _StatusRow(
            icon: Icons.check_circle_outline,
            title: 'In Stock',
            subtitle: 'Products with sufficient inventory',
            color: olive,
          ),

          Divider(height: 24),

          _StatusRow(
            icon: Icons.warning_amber_rounded,
            title: 'Low Stock',
            subtitle: 'Products that may need replenishment',
            color: lightBrown,
          ),

          Divider(height: 24),

          _StatusRow(
            icon: Icons.remove_circle_outline,
            title: 'Out of Stock',
            subtitle: 'Products currently unavailable',
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }

  // RESTOCK RECOMMENDATIONS

  Widget _restockCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: const Column(
        children: [
          Icon(
            Icons.shopping_cart_checkout_outlined,
            color: olive,
            size: 42,
          ),

          SizedBox(height: 12),

          Text(
            'No Recommendations Yet',
            style: TextStyle(
              color: brown,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8),

          Text(
            'Restocking recommendations will appear here '
            'when inventory and sales data are available.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // CARD DECORATION

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color(0xFFECE5D9),
      ),
    );
  }

  // LOGOUT

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }
}

// INVENTORY STATUS ROW

class _StatusRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _StatusRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 27,
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


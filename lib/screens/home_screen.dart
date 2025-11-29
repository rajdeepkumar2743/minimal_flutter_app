import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../widgets/service_card.dart';

import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fabController.forward();
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final items = appState.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern Services'),
        elevation: 0,
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(appState.isDark ? Icons.dark_mode : Icons.light_mode, key: ValueKey(appState.isDark)),
            ),
            onPressed: () => appState.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showOptionsModal(context),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: CurvedAnimation(parent: _fabController, curve: Curves.elasticOut),
        child: FloatingActionButton.extended(
          onPressed: () => _showCreateModal(context),
          label: const Text('Add'),
          icon: const Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _searchHeader(context),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                final crossAxis = constraints.maxWidth > 600 ? 3 : 2;
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxis,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.05,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final item = items[i];
                    // Staggered appearance
                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 350 + i * 60),
                      builder: (context, value, child) {
                        return Opacity(opacity: value, child: Transform.translate(offset: Offset(0, (1 - value) * 20), child: child));
                      },
                      child: ServiceCard(
                        item: item,
                        onTap: () => _openDetail(context, item),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.indigo.shade400, Colors.indigo.shade200]),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 12),
                Expanded(child: Text('Search services', style: TextStyle(color: Colors.white70))),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(onTap: () => _showProfileModal(context), child: const CircleAvatar(child: Icon(Icons.person_outline))),
      ],
    );
  }

  void _openDetail(BuildContext context, item) {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 520),
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(opacity: animation, child: DetailScreen(item: item)),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        return ScaleTransition(scale: curved, child: child);
      },
    ));
  }

  void _showOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 60, height: 6, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 12),
            ListTile(leading: const Icon(Icons.sort), title: const Text('Sort by'), onTap: () => Navigator.pop(context)),
            ListTile(leading: const Icon(Icons.filter_list), title: const Text('Filter'), onTap: () => Navigator.pop(context)),
            const SizedBox(height: 8),
          ]),
        );
      },
    );
  }

  void _showProfileModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Center(child: CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36))),
                  const SizedBox(height: 12),
                  Center(child: Text('Rajdeep', style: Theme.of(context).textTheme.titleLarge)),
                  const SizedBox(height: 20),
                  const ListTile(leading: Icon(Icons.email), title: Text('rajdeep@example.com')),
                  const ListTile(leading: Icon(Icons.logout), title: Text('Sign out')),
                  const SizedBox(height: 30),
                ]),
              ),
            );
          },
        );
      },
    );
  }

  void _showCreateModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 260,
            child: Column(children: [
              Container(width: 60, height: 6, margin: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('Create new service', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: TextField(decoration: InputDecoration(hintText: 'Service name'))),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const SizedBox(width: double.infinity, child: Center(child: Text('Create')))),
              )
            ]),
          ),
        );
      },
    );
  }
}

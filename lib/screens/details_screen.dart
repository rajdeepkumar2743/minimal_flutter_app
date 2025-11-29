import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/app_state.dart';

class DetailScreen extends StatelessWidget {
  final Item item;
  const DetailScreen({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final fav = appState.isFavorite(item.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Hero(
            tag: 'card_${item.id}',
            child: Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.indigo.shade700, Colors.indigo.shade300]),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 8))],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(item.title,
                        style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 5),
                    Text(item.subtitle,
                        style: const TextStyle(color: Colors.white70),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.schedule),
                            label: const Text('Book')),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () => appState.toggleFavorite(item.id),
                          icon: Icon(fav ? Icons.favorite : Icons.favorite_border, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text('About', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  const Text(
                      'This is a polished minimal detail screen with smooth hero transition and actionable buttons. You can add more content here.'),
                  const SizedBox(height: 16),
                  Text('Reviews', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: Theme.of(context).cardColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: Text('User ${index + 1}'),
                        subtitle: const Text('Great service!'),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

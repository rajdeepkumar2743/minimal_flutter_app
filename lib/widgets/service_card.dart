import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/app_state.dart';

class ServiceCard extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;
  const ServiceCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final fav = appState.isFavorite(item.id);

    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: 'card_${item.id}',
        flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
          return ScaleTransition(scale: animation, child: toHeroContext.widget);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.indigo.shade600.withOpacity(0.95), Colors.indigo.shade300]),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 6))],
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                  IconButton(
                    onPressed: () => appState.toggleFavorite(item.id),
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(fav ? Icons.favorite : Icons.favorite_border, key: ValueKey(fav), color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Text(
                  item.subtitle,
                  style: const TextStyle(color: Colors.white70),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    onPressed: onTap,
                    child: const Text('View'),
                  ),
                  Text('From ₹${item.price}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

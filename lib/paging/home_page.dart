import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paging Example'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Users'),
            onTap: () => context.go('/users'),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            title: const Text('API Users'),
            onTap: () => context.go('/api_users'),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  runApp(const NestlessExampleApp());
}

class NestlessExampleApp extends StatelessWidget {
  const NestlessExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nestless Flutter'),
      ),
      body: NScrollColumn(
        padding: const EdgeInsets.all(16),
        gap: 16,
        children: const [
          _OriginalCard(),
          _NestlessCard(),
          _ModifierCard(),
        ],
      ),
    );
  }
}

class _OriginalCard extends StatelessWidget {
  const _OriginalCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Original Flutter',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            const Text('Card → Padding → Column → manual gaps'),
          ],
        ),
      ),
    );
  }
}

class _NestlessCard extends StatelessWidget {
  const _NestlessCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: NColumn(
        padding: const EdgeInsets.all(16),
        gap: 12,
        children: [
          Text(
            'Nestless layout',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Text('One semantic layout with automatic gaps.'),
          NRow(
            gap: 8,
            children: [
              FilledButton(
                onPressed: () {},
                child: const Text('Save'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ModifierCard extends StatelessWidget {
  const _ModifierCard();

  @override
  Widget build(BuildContext context) {
    return const Text('Short modifier chain')
        .nAlign(Alignment.centerLeft)
        .nPadAll(16)
        .nWidth(double.infinity);
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_oracle_digital/features/search/presentation/logic/riverpod/search_state.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesAsyncValue = ref.watch(citiesProviderSecond);
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Cities'),
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Search City',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  ref.read(searchQueryProvider.notifier).state =
                      searchController.text;
                },
              ),
            ),
          ),
          citiesAsyncValue.when(
            data: (cities) => Expanded(
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cities[index].name),
                  );
                },
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_item_tracker/presentation/widget/size_aware_widget.dart';
import 'package:provider/provider.dart';

import '../controller/item_provider.dart';
import 'add_item_screen.dart';

class ItemTrackerScreen extends StatelessWidget {
  const ItemTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Tracker'),
      ),
      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, child) {
          return SizeAwareWidget(
            child: ListView.builder(
              itemCount: itemProvider.items.length,
              itemBuilder: (context, index) {
                final item = itemProvider.items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddItemScreen(
                                item: item,
                                index: index,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          itemProvider.removeItem(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

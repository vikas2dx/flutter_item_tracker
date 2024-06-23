import 'package:flutter_item_tracker/data/model/item_model.dart';
import 'package:flutter_item_tracker/presentation/controller/item_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Add item to list', () {
    final itemProvider = ItemProvider();
    final item = Item(name: 'Test Item', description: 'Test Description');

    itemProvider.addItem(item);

    expect(itemProvider.items.contains(item), true);
  });

  test('Edit item in list', () {
    final itemProvider = ItemProvider();
    final item = Item(name: 'Test Item', description: 'Test Description');
    final newItem =
        Item(name: 'Edited Item', description: 'Edited Description');

    itemProvider.addItem(item);
    itemProvider.editItem(0, newItem);

    expect(itemProvider.items[0].name, 'Edited Item');
    expect(itemProvider.items[0].description, 'Edited Description');
  });

  test('Remove item from list', () {
    final itemProvider = ItemProvider();
    final item = Item(name: 'Test Item', description: 'Test Description');

    itemProvider.addItem(item);
    itemProvider.removeItem(0);

    expect(itemProvider.items.contains(item), false);
  });
}

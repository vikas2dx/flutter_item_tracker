import 'package:flutter/material.dart';
import 'package:flutter_item_tracker/data/model/item_model.dart';
import 'package:flutter_item_tracker/presentation/controller/item_provider.dart';
import 'package:flutter_item_tracker/presentation/screen/item_tracker_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Add item to list via UI', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ItemProvider(),
        child: const MaterialApp(
          home: ItemTrackerScreen(),
        ),
      ),
    );

    // Verify the list is empty
    expect(find.byType(ListTile), findsNothing);

    // Add a new item
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Test Item');
    await tester.enterText(
        find.byType(TextFormField).at(1), 'Test Description');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify the item is added
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('Test Item'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
  });

  testWidgets('Edit item in list via UI', (WidgetTester tester) async {
    final itemProvider = ItemProvider();
    final item = Item(name: 'Test Item', description: 'Test Description');
    itemProvider.addItem(item);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: itemProvider,
        child: const MaterialApp(
          home: ItemTrackerScreen(),
        ),
      ),
    );

    // Verify the initial item is displayed
    expect(find.text('Test Item'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);

    // Edit the item
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Edited Item');
    await tester.enterText(
        find.byType(TextFormField).at(1), 'Edited Description');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify the item is edited
    expect(find.text('Edited Item'), findsOneWidget);
    expect(find.text('Edited Description'), findsOneWidget);
  });

  testWidgets('Remove item from list via UI', (WidgetTester tester) async {
    final itemProvider = ItemProvider();
    final item = Item(name: 'Test Item', description: 'Test Description');
    itemProvider.addItem(item);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: itemProvider,
        child: const MaterialApp(
          home: ItemTrackerScreen(),
        ),
      ),
    );

    // Verify the initial item is displayed
    expect(find.text('Test Item'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);

    // Remove the item
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Verify the item is removed
    expect(find.byType(ListTile), findsNothing);
  });
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/item_model.dart';
import '../controller/item_provider.dart';

class AddItemScreen extends StatefulWidget {
  final Item? item;
  final int? index;

  const AddItemScreen({super.key, this.item, this.index});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name ?? '';
    _description = widget.item?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Add Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(hintText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(hintText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade800),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final item = Item(name: _name, description: _description);
                      if (widget.index == null) {
                        Provider.of<ItemProvider>(context, listen: false)
                            .addItem(item);
                      } else {
                        Provider.of<ItemProvider>(context, listen: false)
                            .editItem(widget.index!, item);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

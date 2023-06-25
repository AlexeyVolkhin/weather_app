import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchField extends HookWidget {
  final String? initial;
  final void Function(String val) onChange;

  const SearchField(this.initial, this.onChange, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initial);

    return Container(
        padding: const EdgeInsets.fromLTRB(7, 7, 7, 0),
        child: TextField(
          controller: controller,
          style: const TextStyle(
              fontSize: 15, height: 1.5, color: Color.fromARGB(255, 0, 0, 0)),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            prefixIcon: const Icon(Icons.search),
            hintText: 'Поиск по названию',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  30,
                )),
          ),
          onChanged: onChange,
        ));
  }
}

import 'package:flutter/material.dart';

class InputDropDownButton<T> extends StatelessWidget {
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final List<T> items;
  final String displayText;
  final String txt;

  const InputDropDownButton({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.items,
    required this.displayText, 
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: DropdownButtonFormField<T>(
        value: selectedValue,
        decoration: InputDecoration(
          prefixText: txt,
          prefixStyle: const TextStyle(color: Color(0xff757575), fontSize: 18),
          filled: true,
          fillColor: const Color(0xffFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        hint: Text(displayText),
        items: items.map((item) {
          return DropdownMenuItem<T>(value: item, child: Text(item.toString()));
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null) return "Please select a value";
          return null;
        },
      ),
    );
  }
}

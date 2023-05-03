import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CurrencyDropDownButton extends StatelessWidget {
  final List<String> genderItems = [
    'EUR',
    'USD',
  ];
  final Function(String) onChanged;
  String? selectedValue;

  CurrencyDropDownButton({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            isExpanded: true,
            hint: const Text(
              'Wybierz walutę',
              style: TextStyle(fontSize: 14),
            ),
            items: genderItems
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select currency.';
              }
              return null;
            },
            onChanged: (value) {
              //Do something when changing the item if you want.

              onChanged(value!);
            },
            buttonStyleData: const ButtonStyleData(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 10),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

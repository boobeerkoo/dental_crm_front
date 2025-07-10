import 'package:flutter/material.dart';

class DateSelection extends StatefulWidget {
  final void Function(DateTime) onDateSelected;
  final int? day;
  final int? month;
  final int? year;

  const DateSelection(
      {Key? key, required this.onDateSelected, this.day, this.month, this.year})
      : super(key: key);

  @override
  State<DateSelection> createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  int _day = 1;
  int _month = 1;
  int _year = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _day = widget.day ?? 1;
    _month = widget.month ?? 1;
    _year = widget.year ?? DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Дата народження:'),
        const SizedBox(width: 10),
        DropdownButton<int>(
          value: _day,
          items: List.generate(31, (index) => index + 1)
              .map((day) => DropdownMenuItem(
                    value: day,
                    child: Text(day.toString()),
                  ))
              .toList(),
          onChanged: (int? value) {
            setState(() {
              _day = value!;
              _notifyDateSelected(); // Step 3
            });
          },
        ),
        const SizedBox(width: 10),
        DropdownButton<int>(
          value: _month,
          items: List.generate(12, (index) => index + 1)
              .map((month) => DropdownMenuItem(
                    value: month,
                    child: Text(month.toString()),
                  ))
              .toList(),
          onChanged: (int? value) {
            setState(() {
              _month = value!;
              _notifyDateSelected(); // Step 3
            });
          },
        ),
        const SizedBox(width: 10),
        DropdownButton<int>(
          value: _year,
          items: List.generate(121, (index) => DateTime.now().year - index)
              .map((year) => DropdownMenuItem(
                    value: year,
                    child: Text(year.toString()),
                  ))
              .toList(),
          onChanged: (int? value) {
            setState(() {
              _year = value!;
              _notifyDateSelected(); // Step 3
            });
          },
        ),
      ],
    );
  }

  void _notifyDateSelected() {
    final selectedDate = DateTime(_year, _month, _day);
    widget.onDateSelected(selectedDate); // Step 2
  }
}

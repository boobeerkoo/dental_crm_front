import 'dart:io';

import 'package:dental_crm_flutter_front/utils/utils.dart';
import 'package:flutter/material.dart';

class HistoryTabHeader extends StatelessWidget {
  const HistoryTabHeader({
    super.key,
    required String? pickedImagePath,
    required TextEditingController surnameController,
    required TextEditingController nameController,
    required TextEditingController phone1Controller,
    required this.year,
  })  : _pickedImagePath = pickedImagePath,
        _surnameController = surnameController,
        _nameController = nameController,
        _phone1Controller = phone1Controller;

  final String? _pickedImagePath;
  final TextEditingController _surnameController;
  final TextEditingController _nameController;
  final TextEditingController _phone1Controller;
  final int year;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 241, 240, 240),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: 80,
              color: AppColors.tilesBgColor,
              child: _pickedImagePath != null
                  ? Image.file(
                File(_pickedImagePath!), // Додав ! для non-null assertion
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/images/profile2.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Пацієнт: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '${_surnameController.text} ${_nameController.text}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    ' ${DateTime.now().year - year} років', // Змінив на динамічний розрахунок року
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                _phone1Controller.text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
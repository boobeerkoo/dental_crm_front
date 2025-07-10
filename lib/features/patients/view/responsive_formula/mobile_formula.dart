import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MobileFormula extends StatefulWidget {
  const MobileFormula({super.key});

  @override
  State<MobileFormula> createState() => _MobileFormulaState();
}

class _MobileFormulaState extends State<MobileFormula> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Формула зубів'),
      ),
      drawer: const SideMenu(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Сторінка з формулою зубів'),
          ),
        ],
      ),
    );
  }
}

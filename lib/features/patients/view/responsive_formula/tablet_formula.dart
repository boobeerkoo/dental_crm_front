import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TabletFormula extends StatefulWidget {
  const TabletFormula({super.key});

  @override
  State<TabletFormula> createState() => _TabletFormulaState();
}

class _TabletFormulaState extends State<TabletFormula> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Формула зубів'),
      ),
      drawer: const SideMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text('Сторінка з формулою зубів'),
          ),
        ],
      ),

    );
  }
}

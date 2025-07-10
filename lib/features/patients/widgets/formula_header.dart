import 'package:flutter/material.dart';

class FormulaHeader extends StatelessWidget {
  const FormulaHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
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
          const Image(
            image: AssetImage("assets/images/tooth.png"),
            height: 50,
            width: 50,
          ),
          const SizedBox(width: 10),
          const Text(
            'Зубна формула',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:dental_crm_flutter_front/features/patients/widgets/widgets.dart';
import 'package:dental_crm_flutter_front/utils/utils.dart';
import 'package:flutter/material.dart';

class CreateCommentTile extends StatelessWidget {
  const CreateCommentTile({
    super.key,
    required TextEditingController etapController,
    required this.onTap,
    this.onAddTooth,
  }) : _etapController = etapController;

  final TextEditingController _etapController;
  final Function()? onTap;
  final Function()? onAddTooth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
          Expanded(
            child: TextField(
              controller: _etapController,
              decoration: const InputDecoration(
                hintText: 'Введіть назву етапу',
              ),
            ),
          ),
          // const SizedBox(width: 10),
          // FormButton(
          //   horizontalEI: 30,
          //   verticalEI: 10,
          //   color: AppColors.mainBlueColor,
          //   prefixImage: const AssetImage('assets/images/tooth.png'),
          //   text: 'Зубна формула',
          //   onTap: onAddTooth,
          // ),
          const SizedBox(width: 10),
          FormButton(
            horizontalEI: 30,
            verticalEI: 10,
            color: Colors.green,
            text: 'Створити',
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:dental_crm_flutter_front/features/patients/widgets/widgets.dart';

import 'package:dental_crm_flutter_front/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CommentTile extends StatefulWidget {
  CommentTile({
    super.key,
    String? pickedImagePath,
    required this.userName,
    required TextEditingController historyComment,
    required this.etap,
    required this.updatedDate,
    required this.onDeleteTap,
    this.isEditing = false,
    required this.onSaveTap,
  })  : _pickedImagePath = pickedImagePath,
        _historyComment = historyComment;

  final String? _pickedImagePath;
  final String userName;
  final TextEditingController _historyComment;
  final String? etap;
  final DateTime updatedDate;
  final Function() onDeleteTap;
  final Function() onSaveTap;
  bool isEditing;

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 35,
                      color: AppColors.tilesBgColor,
                      child: widget._pickedImagePath != null
                          ? Image.file(
                              File(widget._pickedImagePath!),
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
                      Text(
                        widget.etap == ' ' || widget.etap == ''
                            ? 'Новий етап'
                            : widget.etap!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.userName,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainBlueColor),
                          ),
                          const SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              widget.updatedDate.toString().substring(0, 16),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Ionicons.trash_outline,
                  color: Colors.red,
                  size: 30,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.mainBlueColor,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Видалити етап?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              widget.onDeleteTap();
                              Navigator.pop(context);
                            },
                            child: const Text('Так'),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.mainBlueColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ні'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          TextField(
            controller: widget._historyComment,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          const SizedBox(height: 20),
          if (!widget.isEditing) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FormButton(
                  horizontalEI: 30,
                  verticalEI: 10,
                  text: 'Редагувати',
                  color: AppColors.mainBlueColor,
                  onTap: () {
                    setState(() {
                      widget.isEditing = true;
                    });
                  },
                ),
              ],
            ),
          ],
          if (widget.isEditing) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FormButton(
                  horizontalEI: 30,
                  verticalEI: 10,
                  text: 'Зберегти',
                  color: AppColors.mainBlueColor,
                  onTap: () {
                    setState(() {
                      widget.isEditing = false;
                    });
                    widget.onSaveTap();
                  },
                ),
                const SizedBox(width: 10),
                FormButton(
                  horizontalEI: 30,
                  verticalEI: 10,
                  text: 'Відмінити',
                  textColor: Colors.black,
                  color: const Color.fromARGB(255, 201, 199, 199),
                  onTap: () {
                    setState(() {
                      widget.isEditing = false;
                    });
                  },
                ),
              ],
            )
          ],
        ],
      ),
    );
  }
}

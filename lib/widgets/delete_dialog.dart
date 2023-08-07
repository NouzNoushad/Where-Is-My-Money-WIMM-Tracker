import 'package:flutter/material.dart';

import '../core/colors.dart';

showDeleteDialog(BuildContext context, void Function()? onPressed) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Delete this record',
                  style: TextStyle(
                    color: CustomColors.background4,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Are you sure?',
                  style: TextStyle(
                    color: CustomColors.background4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.background4),
                        child: const Text(
                          'No',
                          style: TextStyle(
                            color: CustomColors.background1,
                          ),
                        )),
                    ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.background4),
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            color: CustomColors.background1,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ));
}
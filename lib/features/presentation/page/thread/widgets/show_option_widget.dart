import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/widgets.dart';

class ShowOptionWidget extends StatelessWidget {
  final VoidCallback deleteThread;
  const ShowOptionWidget({super.key, required this.deleteThread});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.15,
      child: Container(
        padding: const EdgeInsets.only(
          top: 7,
          left: 16,
          right: 16,              
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5/2),
                color: grey
              ),
            ),
            sizeVer(15),
            InkWell(
              splashColor: backgroundColor,
              onTap: deleteThread,
              child: Container(                                      
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade200
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 15
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text('Delete', 14.0, FontWeight.w700, textColorNormal),                      
                      const Icon(
                        CupertinoIcons.delete,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
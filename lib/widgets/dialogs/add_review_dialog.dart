import 'package:flutter/material.dart';
import '/shared/style.dart';

class AddReviewDialog extends StatelessWidget {
  final String? id;
  final String title;
  final String content;
  final String button;
  final void Function() onTap;

  const AddReviewDialog({
    super.key,
    this.id,
    required this.title,
    required this.content,
    required this.button,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: cWhiteColor,
      title: Text(
        title,
        style: blackTextStyle.copyWith(
          fontSize: 20,
          fontWeight: semiBold,
          letterSpacing: 0.2,
        ),
        textAlign: TextAlign.center,
      ),
      alignment: Alignment.center,
      content: Text(
        content,
        style: blackTextStyle.copyWith(
          fontSize: 16,
          fontWeight: medium,
          letterSpacing: 0.2,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: cOrangeColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              button,
              style: whiteTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '/shared/style.dart';

class DialogLoginGagal extends StatelessWidget {
  const DialogLoginGagal({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/alert-circle.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Login Gagal',
          style: redTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
            letterSpacing: 0.2,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Email Atau Password Anda Salah',
          style: greyTextStyle.copyWith(
            fontSize: 14,
            fontWeight: regular,
            letterSpacing: 0.2,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: cOrangeColor,
            ),
            child: Text(
              'Ok',
              style: whiteTextStyle.copyWith(
                fontSize: 14,
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

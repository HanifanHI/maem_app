import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/widgets/dialogs/logout.dart';
import '/pages/login_page.dart';
import '/shared/style.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const String routeName = '/profile';

  _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(75),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: padding),
            alignment: Alignment.bottomCenter,
            color: cWhiteColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: const LinearGradient(
                      colors: [cRedColor, cOrangeColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          defaultTargetPlatform == TargetPlatform.iOS
              ? showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Center(
                      child: Image.asset(
                        'assets/icons/info.png',
                        width: 80,
                      ),
                    ),
                    content: Column(
                      children: [
                        Text(
                          'Logout',
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
                          'Apakah Anda Yakin Ingin Keluar?',
                          style: greyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: regular,
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: CupertinoButton(
                          child: Text(
                            'Ya',
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginPage.routeName,
                              (route) => false,
                            );
                          },
                        ),
                      ),
                      CupertinoDialogAction(
                        child: CupertinoButton(
                          child: Text(
                            'Tidak',
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : showDialog(
                  context: context,
                  builder: (context) => const DialogLogout(),
                  barrierDismissible: false,
                );
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(padding),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
            color: cOrangeColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Text(
            'Logout',
            style: TextStyle(
              fontSize: 18,
              fontWeight: bold,
              color: cWhiteColor,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }
}

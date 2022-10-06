import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/widgets/dialogs/login_gagal.dart';
import '/pages/main_page.dart';
import '/shared/style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  void _validateForm(BuildContext context) {
    FormState form = _formKey.currentState!;

    if (form.validate()) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainPage.routeName,
        (route) => false,
        arguments: _emailController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Selamat Datang\n${_emailController.text}',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: regular,
              letterSpacing: 0.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: padding,
            vertical: 10,
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: cOrangeColor,
        ),
      );
    } else {
      defaultTargetPlatform == TargetPlatform.iOS
          ? showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: Center(
                  child: Image.asset(
                    'assets/icons/alert-circle.png',
                    width: 80,
                  ),
                ),
                content: Column(
                  children: [
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
                  ],
                ),
                actions: [
                  CupertinoDialogAction(
                    child: CupertinoButton(
                      child: Text(
                        'Ok',
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
              builder: (context) => const DialogLoginGagal(),
              barrierDismissible: false,
            );
    }
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60 + MediaQuery.of(context).padding.top),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          left: padding,
          top: MediaQuery.of(context).padding.top,
        ),
        decoration: const BoxDecoration(
          color: Colors.amber,
          gradient: LinearGradient(
            colors: [cRedColor, cOrangeColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Image.asset(
          'assets/icons/icon-logo-white.png',
          width: 120,
        ),
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(padding),
            child: Column(
              children: [
                Text(
                  'Login',
                  style: blackTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: const LinearGradient(
                          colors: [
                            cRedColor,
                            cOrangeColor,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      width: 10,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: const LinearGradient(
                          colors: [
                            cRedColor,
                            cOrangeColor,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: LayoutBuilder(builder: (context, constraint) {
              return Container(
                margin: constraint.maxWidth <= 700
                    ? const EdgeInsets.symmetric(horizontal: padding)
                    : EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.2,
                      ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      autocorrect: false,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                          return 'Masukan email dengan benar';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: greyTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: cGreyColor,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: cOrangeColor,
                          ),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: cRedAlertColor,
                          ),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: cRedAlertColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      autocorrect: false,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password minimal 8 karakter';
                        } else {
                          return null;
                        }
                      },
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: greyTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: _isObscure
                                ? Image.asset(
                                    'assets/icons/eye.png',
                                    width: 24,
                                  )
                                : Image.asset(
                                    'assets/icons/eye-off.png',
                                    width: 24,
                                  ),
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: cGreyColor,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: cOrangeColor,
                          ),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: cRedAlertColor,
                          ),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: cRedAlertColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _validateForm(context);
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: padding),
                        alignment: Alignment.center,
                        height: 56,
                        decoration: BoxDecoration(
                          color: cOrangeColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          'Login',
                          style: whiteTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: bold,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}

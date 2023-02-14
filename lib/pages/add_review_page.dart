import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/dialogs/add_review_dialog.dart';
import '../provider/add_new_review_provider.dart';
import '../pages/detail_page.dart';
import '../shared/style.dart';

class AddNewReviewPage extends StatefulWidget {
  const AddNewReviewPage({super.key});

  static const String routeName = '/review';

  @override
  State<AddNewReviewPage> createState() => _AddNewReviewPageState();
}

class _AddNewReviewPageState extends State<AddNewReviewPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerReview = TextEditingController();

  @override
  void dispose() {
    _controllerName.clear();
    _controllerReview.clear();
    super.dispose();
  }

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
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/icons/arrow-left.png',
                        width: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Add New Review',
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
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

  Widget _buildBody() {
    final id = ModalRoute.of(context)!.settings.arguments as String;

    return Consumer<AddNewReviewProvider>(
      builder: (context, value, _) => Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name :',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              textInputAction: TextInputAction.next,
              controller: _controllerName,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: cOrangeColor),
                  borderRadius: BorderRadius.circular(14),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: cGreyColor),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Review :',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              textInputAction: TextInputAction.done,
              controller: _controllerReview,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: cOrangeColor),
                  borderRadius: BorderRadius.circular(14),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: cGreyColor),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                if (_controllerName.text.isNotEmpty &&
                    _controllerReview.text.isNotEmpty) {
                  await value
                      .postAddNewReview(
                    id,
                    _controllerName.text,
                    _controllerReview.text,
                  )
                      .then(
                    (_) {
                      if (value.resultState == ResultState.hasData) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AddReviewDialog(
                            id: id,
                            title: 'Sukses',
                            content: 'Berhasil menambahkan ulasan',
                            button: 'Lihat Detail',
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                DetailPage.routeName,
                                (route) => false,
                                arguments: id,
                              );
                            },
                          ),
                        );
                      } else {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AddReviewDialog(
                            title: 'Gagal',
                            content: 'Gagal menambahkan ulasan',
                            button: 'Kembali',
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AddReviewDialog(
                      title: 'Gagal',
                      content: 'Form harus diisi',
                      button: 'Kembali',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: cOrangeColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: value.resultState == ResultState.loading
                    ? const CircularProgressIndicator(
                        color: cWhiteColor,
                      )
                    : Text(
                        'Kirim',
                        style: whiteTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                          letterSpacing: 0.2,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}

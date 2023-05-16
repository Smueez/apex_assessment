import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Alerts {
  final BuildContext context;

  Alerts({required this.context});

  void floatingLoading({String? message}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.sp)),
              height: 25.w,
              width: 10.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.sp),
                    child: Text(
                      message ?? "অপেক্ষা করুন",
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showModalWithWidget(
      {required Widget child, bool dismissible = false}) async {
    await showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return dismissible;
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.sp)),
            child: child,
          ),
        );
      },
    );
  }



  void snackBar(
      {required String massage, int duration = 3, bool isSuccess = true}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // margin: EdgeInsets.only(bottom: 40.h),
      content: Text(
        massage,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: duration),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    ));
  }

}

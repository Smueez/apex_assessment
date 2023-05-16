import 'package:apex_assessment/api/company_api.dart';
import 'package:apex_assessment/global/constants.dart';
import 'package:apex_assessment/main.dart';
import 'package:apex_assessment/model/returned_data_model.dart';
import 'package:apex_assessment/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../global/enum.dart';
import '../ui/custom_dialog.dart';

class CompanyController {
  WidgetRef ref;
  BuildContext context;
  late Alerts _alerts;
  CompanyController({required this.ref, required this.context}):_alerts = Alerts(context: context);
  TextEditingController companyNameController = TextEditingController();
  TextEditingController workEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  disposeController(){
    companyNameController.dispose();
    workEmailController.dispose();
    passwordController .dispose();
    phoneController.dispose();
  }
  createCompanyOnTap(){
    companyNameController.clear();
    workEmailController.clear();
    passwordController .clear();
    phoneController.clear();
    _alerts.showModalWithWidget(
        dismissible: true,
        child: Padding(
          padding: EdgeInsets.only(top: 2.h, right: 2.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: (){
                      navigatorKey.currentState?.pop();
                    },
                    child: Icon(Icons.close),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h, left: 5.w, right: 3.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Create a New Company",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      TextFormField(
                        controller: companyNameController,
                        enableSuggestions: false,
                        autocorrect: false,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13.sp),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)
                            ),
                            hintText: "Company Name",
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      TextFormField(
                        controller: workEmailController,
                        enableSuggestions: false,
                        autocorrect: false,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13.sp),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor)
                          ),
                          hintText: "Work Email",
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      TextFormField(
                        controller: passwordController,
                        enableSuggestions: false,
                        autocorrect: false,
                        obscureText: true,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13.sp),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor)
                          ),
                          hintText: "Password",
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      TextFormField(
                        controller: phoneController,
                        enableSuggestions: false,
                        autocorrect: false,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13.sp),
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]*')),
                          TextInputFormatter.withFunction(
                                (oldValue, newValue) => newValue.copyWith(
                              text: newValue.text.replaceAll('.', ','),
                            ),
                          ),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor)
                          ),
                          hintText: "Phone",
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      SizedBox(
                        width: 100.w,
                        height: 6.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                            onPressed: (){
                              createCompany();
                            },
                            child: const Text(
                              "Create a New Company"
                            )
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        )
    );
  }

  createCompany()async{
    String email = workEmailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String companyName = companyNameController.text.trim();
    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if(!emailValid){
      navigatorKey.currentState?.pop();
      _alerts.snackBar(massage: "Email is not valid!");
      return;
    }
    if(phone.length <  9 || phone.length > 15){
      navigatorKey.currentState?.pop();
      _alerts.snackBar(massage: "The phone must be between 9 and 15 digits.");
      return;
    }
    if(password.length < 7){
      navigatorKey.currentState?.pop();
      _alerts.snackBar(massage: "The password must be at least 7 characters.");
      return;
    }
    if(companyName.isEmpty){
      navigatorKey.currentState?.pop();
      _alerts.snackBar(massage: "Company name can not be empty.");
      return;
    }
    Map payload = {
      "company_name": companyNameController.text,
      "email": workEmailController.text,
      "password": passwordController.text,
      "phone": phoneController.text
    };
    _alerts.floatingLoading();
    ReturnedDataModel returnedDataModel = await CompanyAPI().createCompanyAPICall(payload);
    navigatorKey.currentState?.pop();
    if(returnedDataModel.status == ReturnedStatus.success){
      navigatorKey.currentState?.pop();
      ref.refresh(companyListProvider);
      _alerts.snackBar(massage: "Company created successfully");
    }
    else{
      navigatorKey.currentState?.pop();
      _alerts.snackBar(massage: returnedDataModel.errorMessage??"Couldn't create new company",isSuccess: false);
    }
  }
}
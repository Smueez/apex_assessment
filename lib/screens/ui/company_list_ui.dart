import 'package:apex_assessment/global/constants.dart';
import 'package:apex_assessment/model/company_model.dart';
import 'package:apex_assessment/providers/providers.dart';
import 'package:apex_assessment/screens/controller/company_controller.dart';
import 'package:apex_assessment/screens/ui/company_list_tile_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class CompanyListUI extends ConsumerStatefulWidget {
  const CompanyListUI({Key? key}) : super(key: key);
  static const routeName = "/company_list_ui";
  @override
  ConsumerState<CompanyListUI> createState() => _CompanyListUIState();
}

class _CompanyListUIState extends ConsumerState<CompanyListUI> {

  late CompanyController companyController;
  @override
  void initState() {
    super.initState();
    companyController = CompanyController(ref: ref, context: context);
  }

  @override
  void dispose() {
    super.dispose();
    companyController.disposeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          companyController.createCompanyOnTap();
        },
        child: Container(
          // width: 50.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.sp),
            color: primaryColor
          ),
          padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
          child: Text(
            "Create Company",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
            "Company List",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, _){
          AsyncValue<List<CompanyModel>> asyncCompanyList = ref.watch(companyListProvider);
          return asyncCompanyList.when(
              data: (companyList){
                if(companyList.isEmpty){
                  return const NoDataUI();
                }
                return ListView.builder(
                  itemCount: companyList.length,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 14.h),
                    itemBuilder: (context, index){
                      return CompanyListTile(company: companyList[index]);
                    }
                );
              },
              error: (error, stack)=> const NoDataUI(),
              loading: ()=> const Center(child: CircularProgressIndicator(),)
          );

        },
      ),
    );
  }
}

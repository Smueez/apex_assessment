import 'package:apex_assessment/model/company_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../global/constants.dart';

class CompanyListTile extends StatelessWidget {
  const CompanyListTile({required this.company, Key? key}) : super(key: key);
  final CompanyModel company;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: borderColor
          )
        )
      ),
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              company.companyName??"N/A",
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
              fontSize: 17.sp
            ),
          ),
          Text(
              company.email??"N/A",
            style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey
            ),
          ),
          Text(
              company.phone??"N/A",
            style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }
}

class NoDataUI extends StatelessWidget {
  const NoDataUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No Data Found"
      ),
    );
  }
}


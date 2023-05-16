import 'dart:convert';

import 'package:apex_assessment/global/enum.dart';
import 'package:apex_assessment/api/global_http.dart';
import 'package:apex_assessment/model/company_model.dart';
import 'package:apex_assessment/model/returned_data_model.dart';

import 'links.dart';

class CompanyAPI {
  Future<List<CompanyModel>> getCompanyListAPICall()async{
    List<CompanyModel> list = [];
    try{
      ReturnedDataModel returnedDataModel = await GlobalHttp(httpType: HttpType.get, uri: Links.companyListUrl).fetch();

      if(returnedDataModel.status == ReturnedStatus.success){
        Map companyData = returnedDataModel.data;

        if(companyData.containsKey("company_list")){
          if(companyData["company_list"].containsKey("data")){
            for(Map company in companyData["company_list"]["data"]){
              list.add(CompanyModel.fromJson(company));
            }
          }
        }
      }
    }
    catch(e,s){
      print("inside CompanyAPI class getCompanyListAPICall error $e $s");
    }
    return list;
  }
  Future<ReturnedDataModel>createCompanyAPICall(Map payload)async{
    ReturnedDataModel returnedDataModel = ReturnedDataModel(status: ReturnedStatus.error);
    try{
      returnedDataModel = await GlobalHttp(httpType: HttpType.post, uri: Links.createCompanyUrl, body: jsonEncode(payload)).fetch();


    }
    catch(e,s){
      print("inside CompanyAPI class createCompanyAPICall error $e $s");
    }
    return returnedDataModel;
  }
}
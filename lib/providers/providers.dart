// company list provider
import 'package:apex_assessment/api/company_api.dart';
import 'package:apex_assessment/model/company_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final companyListProvider = FutureProvider.autoDispose<List<CompanyModel>>((ref) async => await CompanyAPI().getCompanyListAPICall());
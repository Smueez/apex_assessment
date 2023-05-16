import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:internet_popup/internet_popup.dart';

import '../model/returned_data_model.dart';
import '../global/enum.dart';

class GlobalHttp {
  final String uri;
  final HttpType httpType;
  final String? accessToken;
  final String? refreshToken;
  Uint8List? byteImage;
  String? imagePath;
  String? body;
  String? path;

  GlobalHttp({required this.uri, required this.httpType, this.body,this.path, this.byteImage, this.imagePath, this.accessToken, this.refreshToken});

  Future<ReturnedDataModel> fetch() async {
    var response;

    bool isOnline = await InternetPopup().checkInternet();
    if (isOnline) {
      try {
        var url = Uri.parse(uri);

        Map<String, String> header = {'Accept': 'application/json', 'Content-Type': 'application/json'};
        if (accessToken != null) {
          header['Authorization'] = "Bearer $accessToken";
        }
        if (refreshToken != null) {
          header["refreshToken"] = refreshToken!;
        }
        String responseStr = "";
        switch (httpType) {
          case HttpType.get:
            response = await http.get(url, headers: header);
            responseStr = response.body;
            break;
          case HttpType.post:
            response = await http.post(url, headers: header, body: body,);
            responseStr = response.body;
            break;
          case HttpType.file:
            var req = http.MultipartRequest("POST", url);
            req.headers.addAll(header);
            req.files.add(await http.MultipartFile.fromPath("file", imagePath!));
            req.fields["path"] = path??"others";
            response = await req.send();
            responseStr = await response.stream.bytesToString();
        }

        var jsonData = jsonDecode(responseStr);

        print(response.statusCode);
        print(responseStr);
        if (jsonData['status_code'] == "1") {
          return ReturnedDataModel(status: ReturnedStatus.success, data: jsonData);
        } else {
          return ReturnedDataModel(status: ReturnedStatus.error, errorMessage: jsonData['status_message'].toString());
        }
      } catch (e, s) {
        print('global http class catch block : $e $s');
        return ReturnedDataModel(status: ReturnedStatus.error, errorMessage: e.toString());
      }
    } else {
      return ReturnedDataModel(status: ReturnedStatus.error, errorMessage: 'No Internet connection');
    }
  }
}

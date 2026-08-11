import 'dart:convert';
import 'dart:io';

import 'package:ecommerceapp/data/remote/ApiHelper/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  Future getAPI({
    required String url,
    Map<String, String>? mheaders,
    bool isAuth = false,
  }) async {
    if (!isAuth) {
      mheaders ??= {};

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = prefs.getString('token') ?? "";

      mheaders["Authorization"] = "Bearer $token";
    }

    try {
      var response = await http.get(Uri.parse(url), headers: mheaders);

      return returnResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(message: e.toString());
    } catch (e) {
      throw FetchDataException(message: e.toString());
    }
  }

  Future<dynamic> postAPI({
    required String url,
    Map<String, dynamic>? mBodyParams,
    Map<String, String>? mheaders,
    bool isAuth = false,
  }) async {
    if (!isAuth) {
      mheaders ??= {};
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? "";
      mheaders["Authorization"] = "Bearer $token";
    }
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: mheaders,
        body: mBodyParams != null ? jsonEncode(mBodyParams) : null,
      );
      return returnResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(message: e.toString());
    } catch (e) {
      throw FetchDataException(message: e.toString());
    }
  }

  dynamic returnResponse(http.Response res) {
    var data = jsonDecode(res.body);
    switch (res.statusCode) {
      case 200:
        {
          return data;
        }
      case 300:
        {
          throw UnauthorisedException(message: data['message']);
        }
      case 400:
        {
          throw BadRequestException(message: data['message']);
        }

      case 500:
      case 502:
      default:
        {
          throw ServerException(message: data['message']);
        }
    }
  }
}

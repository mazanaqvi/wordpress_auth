import 'package:flutter/material.dart';
import 'package:wp_json_api/enums/wp_auth_type.dart';
import 'package:wp_json_api/models/responses/wp_user_info_response.dart';
import 'package:wp_json_api/models/responses/wp_user_login_response.dart';
import 'package:wp_json_api/wp_json_api.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  late TextEditingController _tfEmailController;
  late TextEditingController _tfPasswordController;

  @override
  void initState() {
    super.initState();

    // INSTALL THE WP JSON API PLUGIN
    // FIRST ON YOUR WORDPRESS STORE
    // LINK https://woosignal.com/plugins/wordpress/wp-json-api

    WPJsonAPI.instance
        .initWith(baseUrl: "https://matabpublication.com/wp-login.php");

    _tfEmailController = TextEditingController();
    _tfPasswordController = TextEditingController();
  }

  _login() async {
    String email = _tfEmailController.text;
    String password = _tfPasswordController.text;

    WPUserLoginResponse? wpUserLoginResponse;
    // LOGIN
    try {
      wpUserLoginResponse = await WPJsonAPI.instance.api((request) =>
          request.wpLogin(
              email: email, password: password, authType: WPAuthType.WpEmail));
    } on Exception catch (e) {
      print(e);
    }

    if (wpUserLoginResponse != null) {
      print(wpUserLoginResponse.data?.userToken);
      print(wpUserLoginResponse.data?.userId);

      // GET USER INFO
      WPUserInfoResponse? wpUserInfoResponse =
          await WPJsonAPI.instance.api((request) {
        return request.wpGetUserInfo(wpUserLoginResponse!.data!.userToken!);
      });

      if (wpUserInfoResponse != null) {
        print(wpUserInfoResponse.data?.firstName);
        print(wpUserInfoResponse.data?.lastName);
      } else {
        print("something went wrong");
      }
    } else {
      print("invalid login details");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _tfEmailController,
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _tfPasswordController,
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            MaterialButton(
              child: const Text("Login"),
              onPressed: _login,
            )
          ],
        ),
      ),
    );
  }
}

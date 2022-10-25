import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordpress_api/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Word to HTML',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordpress and woocomerce'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => {Get.to(Login(title: "Login"))},
            child: const Text('Login to Wordpress')),
      ),
    );
  }
}

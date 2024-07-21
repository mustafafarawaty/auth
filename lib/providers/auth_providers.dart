import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');

final loginProvider = FutureProvider<String>((ref) async {
  final email = ref.watch(emailProvider.notifier).state;
  final password = ref.watch(passwordProvider.notifier).state;
  print(email);

  final String url =
      'http://192.168.1.108:8000/api/login'; // Replace with your API URL

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // return jsonDecode(response.body);
    return 'Success';
  } else {
    return 'Failed';
  }
});

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CallToAuth extends StatelessWidget {
  const CallToAuth(
      {super.key,
      required this.prefix,
      required this.buttonText,
      required this.authType});

  final String prefix;
  final String buttonText;
  final String authType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prefix),
        TextButton(
            onPressed: () {
              context.go(
                  Uri(path: '/auth', queryParameters: {'authType': authType})
                      .toString());
            },
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.black),
            )),
      ],
    );
  }
}

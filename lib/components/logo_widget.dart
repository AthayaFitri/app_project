import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      child: Image.network(
        'https://prodihumas.upnyk.ac.id/asset/images/Logo_UPN_Yogyakarta_Terbaru_resmi.png',
        width: 250,
        height: 240,
      ),
    );
  }
}

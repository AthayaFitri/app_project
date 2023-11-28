import 'package:flutter/material.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Colors.indigo,
            Colors.indigo.shade800,
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(
          top: 25,
          left: 20,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Athaya Rizqia Fitriani',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  child: const Text(
                    '124210071',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Text(
                  'Sistem Informasi 2021',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    right: 16,
                  ),
                  child: const Icon(
                    Icons.notification_add_outlined,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 45,
                  height: 45,
                  child: CircleAvatar(
                    foregroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

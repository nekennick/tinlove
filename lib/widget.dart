import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: const TextSpan(
      style: TextStyle(fontSize: 30),
      children: <TextSpan>[
        TextSpan(
            text: 'Bói',
            style:
                TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
        TextSpan(
            text: 'Theo',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.pink)),
        TextSpan(
            text: 'Tên',
            style:
                TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
      ],
    ),
  );
}

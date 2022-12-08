/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
import 'package:flutter/material.dart';

class QuoteTextWidget extends StatelessWidget {
  final String message;
  const QuoteTextWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

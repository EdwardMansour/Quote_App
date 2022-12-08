/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speeches/features/quotes/presantation/bloc/bloc.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(16.0),
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: () =>
          BlocProvider.of<QuoteBloc>(context).add(GetRandomQuote()),
      child: const Text('Get Your Quote'),
    );
  }
}

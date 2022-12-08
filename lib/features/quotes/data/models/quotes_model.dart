/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
import 'dart:convert';
import '../../domain/entities/quote.dart';

class QuotesModel extends Quote {
  final String html;
  const QuotesModel(
      {required this.html, required super.quote, required super.author});

  factory QuotesModel.fromMap(Map<String, dynamic> map) {
    return QuotesModel(
      quote: (map['q'] is String) ? map['q'] : map['q'].toString(),
      author: (map['a'] is String) ? map['a'] : map['a'].toString(),
      html: (map['h'] is String) ? map['h'] : map['h'].toString(),
    );
  }
  factory QuotesModel.fromJson(String source) =>
      QuotesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'q': quote,
      'a': author,
      'h': html,
    };
  }

  String toJson() => json.encode(toMap());
}

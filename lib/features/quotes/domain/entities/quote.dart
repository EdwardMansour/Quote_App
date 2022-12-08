/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String quote;
  final String author;
  const Quote({
    required this.quote,
    required this.author,
  });
  @override
  List<Object?> get props => [quote, author];
}

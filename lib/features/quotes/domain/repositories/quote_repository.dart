/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
import 'package:dartz/dartz.dart';
import '../../data/models/quotes_model.dart';
import '../../../../core/error/failures.dart';

abstract class QuoteRepository {
  Future<Either<Failure, List<QuotesModel>>> getRandomQuote();
}

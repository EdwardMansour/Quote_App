/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
import 'package:dartz/dartz.dart';
import '../../data/models/quotes_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCase/use_case.dart';
import 'package:speeches/features/quotes/domain/repositories/quote_repository.dart';

class GetRandomQuoteUsecase implements UseCase<List<QuotesModel>, NoParams> {
  final QuoteRepository repository;

  GetRandomQuoteUsecase(this.repository);

  @override
  Future<Either<Failure, List<QuotesModel>>> call(NoParams params) async {
    return await repository.getRandomQuote();
  }
}

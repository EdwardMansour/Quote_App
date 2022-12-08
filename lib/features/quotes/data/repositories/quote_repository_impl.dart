/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/quote_repository.dart';
import 'package:speeches/features/quotes/data/models/quotes_model.dart';
import 'package:speeches/features/quotes/data/dataSources/quotes_local_data_source.dart';
import 'package:speeches/features/quotes/data/dataSources/quotes_remote_data_source.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuotesRemoteDataSource remoteDataSource;
  final QuotesLocalDataSource localDataSource;

  QuoteRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<QuotesModel>>> getRandomQuote() async {
    try {
      final remoteQuotes = await remoteDataSource.getRandomQuote();
      return Right(remoteQuotes);
    } on ServerException {
      return Left(ServerFailure());
    } on TimeOutException {
      return Left(TimeoutFailure());
    }
  }
}

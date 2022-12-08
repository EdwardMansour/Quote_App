/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
import '../bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/dataSources/quotes_local_data_source.dart';
import 'package:speeches/features/quotes/presantation/widgets/button.dart';
import 'package:speeches/features/quotes/presantation/widgets/loading.dart';
import 'package:speeches/features/quotes/domain/useCases/get_random_quote.dart';
import 'package:speeches/features/quotes/data/repositories/quote_repository_impl.dart';
import 'package:speeches/features/quotes/data/dataSources/quotes_remote_data_source.dart';

class QuotePage extends StatelessWidget {
  const QuotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///! once we will move for another topic it will be moved from here for a reason
    final getRandomQuote = GetRandomQuoteUsecase(QuoteRepositoryImpl(
        localDataSource: QuotesLocalDataSource(),
        remoteDataSource: QuotesRemoteDataSourceImpl(client: http.Client())));

    ///! Builder
    return BlocProvider(
      create: (_) => QuoteBloc(getRandomQuote: getRandomQuote),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Quotes"),
        ),
        body: Center(
          child: BlocBuilder<QuoteBloc, QuoteState>(
            builder: (context, state) {
              return state is Loading
                  ? const LoadingWidget()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          child: Text(
                            _fetchText(state),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        const ButtonWidget()
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  String _fetchText(QuoteState state) => state is Succeded
      ? state.model!.first.quote
      : state is Error
          ? state.message
          : "Quote unavailable!";
}

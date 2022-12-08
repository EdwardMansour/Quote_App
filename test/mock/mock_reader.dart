/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
import 'dart:io';

import 'package:speeches/features/quotes/data/models/quotes_model.dart';

String reader(String name) => File('test/mock/data/$name').readAsStringSync();

const quotesModel = QuotesModel(
    quote: "Don't be pushed by your problems; be led by your dreams.",
    author: "Edward Mansour",
    html:
        "<blockquote>&ldquo;Don't be pushed by your problems; be led by your dreams.&rdquo; &mdash; <footer>Unknown</footer></blockquote>");

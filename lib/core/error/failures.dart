/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

///! General failures
class ServerFailure extends Failure {}

class TimeoutFailure extends Failure {}

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class Result<T> extends Equatable {
  final T? data;

  Result({this.data});
  @override
  List<dynamic> get props => [
        this.data,
      ];
}

@immutable
class Fetching<T> extends Result<T> {
  Fetching(T? data) : super(data: data);
}

class Complete<T> extends Result<T> {
  Complete() : super();
}

// class Error<T> extends Result<T> {
//   Error() : super();
// }

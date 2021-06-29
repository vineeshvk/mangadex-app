import 'package:equatable/equatable.dart';

abstract class BaseEquatable extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  String toString() => runtimeType.toString();
}

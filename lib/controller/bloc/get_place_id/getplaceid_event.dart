part of 'getplaceid_bloc.dart';

@immutable
abstract class GetplaceidEvent {}

class GetIdofPlace extends GetplaceidEvent {
  final String start;
  final String end;

  GetIdofPlace({required this.start,required this.end});
}

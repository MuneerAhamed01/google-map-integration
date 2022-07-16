import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'getplaceid_event.dart';
part 'getplaceid_state.dart';

class GetplaceidBloc extends Bloc<GetplaceidEvent, GetplaceidState> {
  GetplaceidBloc() : super(GetplaceidInitial()) {
    on<GetIdofPlace>((event, emit) {
      
    });
  }
}

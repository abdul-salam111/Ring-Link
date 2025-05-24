import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(const NavbarState()) {
    on<NavbarIndexChanged>((event, emit) {
      emit(state.copyWith(currentIndex: event.index));
    });
   
  }
}

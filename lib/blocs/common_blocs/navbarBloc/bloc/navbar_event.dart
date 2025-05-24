part of 'navbar_bloc.dart';

abstract class NavbarEvent extends Equatable {
  const NavbarEvent();

  @override
  List<Object> get props => [];
}

class NavbarIndexChanged extends NavbarEvent {
  final int index;

  const NavbarIndexChanged(this.index);

  @override
  List<Object> get props => [index];
}

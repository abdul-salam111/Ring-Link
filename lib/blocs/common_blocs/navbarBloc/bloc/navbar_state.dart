part of 'navbar_bloc.dart';

class NavbarState extends Equatable {
  final int currentIndex;
  const NavbarState({this.currentIndex = 0});

  NavbarState copyWith({int? currentIndex}) {
    return NavbarState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [currentIndex];
}

import 'package:equatable/equatable.dart';
import 'package:to_do/my_color/color.dart';

abstract class ColorState extends Equatable{
  const ColorState ();
  @override
  List<Object> get props => [];
}

class ColorLoading extends ColorState {}

class ColorLoaded extends ColorState {
  final TodoColor todoColor;
  final AppBarColors appBarColors;
 const ColorLoaded(this.todoColor, this.appBarColors);
  @override
  List<Object> get props => [todoColor, appBarColors];
}

class ColorError extends ColorState {
  final String massage;
  const ColorError (this.massage);
  @override
  List<Object> get props => [massage];
}

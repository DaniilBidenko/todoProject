
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/bloc/color_event.dart';
import 'package:to_do/bloc/color_state.dart';
import 'package:to_do/my_color/color.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState>{
  ColorBloc() : super(ColorLoading()) {
    on<ColorLoad>(_onColorLoad);
    on<ColorUpdateTitle>(_onColorUpdateTitle);
    on<ColorUpdateDescription>(_onColorUpdateDescription);
    on<ColorUpdateCreatedData>(_onUpdateCreatedData);
    on<ColorUpdateIconTask>(_onUpdateIconTask);
    on<ColorUpdateIconDelete>(_onUpdateIconDelete);
    on<ColorUpdateAppBarTitle>(_onUpdateAppBarTitle);
    on<ColorUpdateButtonAdded>(_onUpdateButtonAdded);
    on<ColorUpdateButtonSettings>(_onUpdateButtonSettings);
  }

  Future<void> _onColorLoad (ColorLoad event, Emitter<ColorState> emit) async{
    try {
      emit (ColorLoading()); 
      final todoColor = await TodoColor.loadFromPrefs();
      final appBarColor = await AppBarColors.loadFromPrefs();
      emit(ColorLoaded(todoColor, appBarColor));
    } catch (e) {
      emit(ColorError('Ошибка загрузки цветов ${e.toString()}'));
    }
  }

  Future<void> _onColorUpdateTitle (ColorUpdateTitle event, Emitter<ColorState> emit) async{
    if (state is ColorLoaded) {
      final currentState = state as ColorLoaded;
      final updatedTodoColor = currentState.todoColor.copyWith(
        titleColor: event.color
      );
      emit(ColorLoaded(updatedTodoColor, currentState.appBarColors));
    } 
  }

  Future<void> _onColorUpdateDescription (ColorUpdateDescription event, Emitter<ColorState> emit) async{
    if(state is ColorLoaded) {
      final currentState = state as ColorLoaded;
      final updatedTodoColor = currentState.todoColor.copyWith(
        descriptionColor: event.color
        );
        emit(ColorLoaded(updatedTodoColor, currentState.appBarColors));
    } 
  }

  Future<void> _onUpdateCreatedData (ColorUpdateCreatedData event, Emitter<ColorState> emit) async{
    if(state is ColorLoaded) {
      final currentState =  state as ColorLoaded;
      final updateColor = currentState.todoColor.copyWith(
        createdData: event.color
      );
      emit(ColorLoaded(updateColor, currentState.appBarColors));
    } 
  }
  Future<void> _onUpdateIconTask (ColorUpdateIconTask event, Emitter<ColorState> emit) async{
    if(state is ColorLoaded) {
      final currentState =  state as ColorLoaded;
      final updateColor = currentState.todoColor.copyWith(
        iconTaskColor: event.color
      );
      emit(ColorLoaded(updateColor, currentState.appBarColors));
    } 
  }
  Future<void> _onUpdateIconDelete (ColorUpdateIconDelete event, Emitter<ColorState> emit) async{
    if(state is ColorLoaded) {
      final currentState =  state as ColorLoaded;
      final updateColor = currentState.todoColor.copyWith(
        iconDeleteColor: event.color
      );
      emit(ColorLoaded(updateColor, currentState.appBarColors));
    } 
  }
  Future<void> _onUpdateAppBarTitle (ColorUpdateAppBarTitle event, Emitter<ColorState> emit) async{
    if(state is ColorLoaded) {
      final currentState =  state as ColorLoaded;
      final updateColor = currentState.appBarColors.copyWith(
        titleAppBarColor: event.color
      );
      emit(ColorLoaded(currentState.todoColor, updateColor));
    } 
  }
  Future<void> _onUpdateButtonSettings (ColorUpdateButtonSettings event, Emitter<ColorState> emit) async{
    if(state is ColorLoaded) {
      final currentState =  state as ColorLoaded;
      final updateColor = currentState.appBarColors.copyWith(
        buttonSettingsTextColor: event.color
      );
      emit(ColorLoaded(currentState.todoColor, updateColor));
    } 
  }
  Future<void> _onUpdateButtonAdded (ColorUpdateButtonAdded event, Emitter<ColorState> emit) async{
    if(state is ColorLoaded) {
      final currentState =  state as ColorLoaded;
      final updateColor = currentState.appBarColors.copyWith(
        buttonAddedTextColor: event.color
      );
      emit(ColorLoaded(currentState.todoColor, updateColor));
    } 
  }

  Future<void> _onSaveColors (SaveColors event, Emitter<ColorState> emit) async{
    if (state is ColorLoaded) {
      try {
        final currentstate = state as ColorLoaded;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(TodoColor.titleColorKey, currentstate.todoColor.titleColor.toARGB32());
        await prefs.setInt(TodoColor.descriptionColorKey, currentstate.todoColor.descriptionColor.toARGB32());
        await prefs.setInt(TodoColor.iconTaskColorKey, currentstate.todoColor.iconTaskColor.toARGB32());
        await prefs.setInt(TodoColor.iconDeleteColorKey, currentstate.todoColor.iconDeleteColor.toARGB32());
        await prefs.setInt(TodoColor.createdDataColorKey, currentstate.todoColor.createdData.toARGB32());

        await prefs.setInt(AppBarColors.titleAppBarColorKey, currentstate.appBarColors.titleAppBarColor.toARGB32());
        await prefs.setInt(AppBarColors.buttonAddedTextColorKey, currentstate.appBarColors.buttonAddedTextColor.toARGB32());
        await prefs.setInt(AppBarColors.buttonSettingsTextColorKey, currentstate.appBarColors.buttonSettingsTextColor.toARGB32());

        emit(ColorLoaded(currentstate.todoColor, currentstate.appBarColors));
      } catch (e) {
        emit(ColorError('Ошибка сохранения цвета ${e.toString()}'));
      }
    }
  }
}
 import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ColorEvent extends Equatable{
  const ColorEvent();
  @override
  List<Object> get props => [];
}

class ColorLoad extends ColorEvent {}

class ColorUpdateTitle extends ColorEvent {
  final Color color;
  ColorUpdateTitle(this.color);
  @override
  List<Object> get props => [color];
}

class ColorUpdateDescription extends ColorEvent {
  final Color color;
  ColorUpdateDescription(this.color);
  @override
  List<Object> get props => [color];
}

class ColorUpdateCreatedData extends ColorEvent {
  final Color color;
  ColorUpdateCreatedData(this.color);
  @override
  List<Object> get props => [color];
}

class ColorUpdateIconTask extends ColorEvent {
  final Color color;
  ColorUpdateIconTask(this.color);
  @override
  List<Object> get props => [color];
}

class ColorUpdateIconDelete extends ColorEvent {
  final Color color;
  ColorUpdateIconDelete(this.color);
  @override
  List<Object> get props => [color];
}

class ColorUpdateAppBarTitle extends ColorEvent {
  final Color color;
  ColorUpdateAppBarTitle(this.color);
  @override
  List<Object> get props => [color];
}

class ColorUpdateButtonSettings extends ColorEvent {
  final Color color;
  ColorUpdateButtonSettings(this.color);
  @override
  List<Object> get props => [color];
}

class ColorUpdateButtonAdded extends ColorEvent {
  final Color color;
  ColorUpdateButtonAdded(this.color);
  @override
  List<Object> get props => [color];
}

class SaveColors extends ColorEvent {}
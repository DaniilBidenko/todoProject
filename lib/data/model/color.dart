import 'package:equatable/equatable.dart';

class Color extends Equatable{
  final Color titleColor;
  final Color descriptionColor;
  final Color createdDataColor;
  final Color iconTaskColor;
  final Color iconDeleteColor;
  final Color appBarTitleColor;
  final Color buttonSettingsColor;
  final Color buttonAddedColor;
  Color({
  required this.appBarTitleColor,
  required this.buttonAddedColor,
  required this.buttonSettingsColor,
  required this.createdDataColor,
  required this.descriptionColor,
  required this.iconDeleteColor,
  required this.iconTaskColor,
  required this.titleColor
  });

  Color copyWith ({
      Color? titleColor,
      Color? descriptionColor,
      Color? createdDataColor,
      Color? iconTaskColor,
      Color? iconDeleteColor,
      Color? appBarTitleColor,
      Color? buttonSettingsColor,
      Color? buttonAddedColor
  }) {
    return Color(
      appBarTitleColor: appBarTitleColor ?? this.appBarTitleColor, 
      buttonAddedColor: buttonAddedColor ?? this.buttonAddedColor, 
      buttonSettingsColor: buttonSettingsColor ?? this.buttonSettingsColor, 
      createdDataColor: createdDataColor ?? this.createdDataColor, 
      descriptionColor: descriptionColor ?? this.descriptionColor, 
      iconDeleteColor: iconDeleteColor ?? this.iconDeleteColor, 
      iconTaskColor: iconTaskColor ?? this.iconTaskColor, 
      titleColor: titleColor ?? this.titleColor);
  }

  Map<String, dynamic> toJson () {
    return {
      'titleColor': titleColor,
      'descriptionColor' : descriptionColor,
      'createdDataColor': createdDataColor,
      'iconTaskColor': iconTaskColor,
      'iconDeleteColor': iconDeleteColor,
      'appBarTitleColor': appBarTitleColor,
      'buttonSettingsColor': buttonSettingsColor,
      'buttonAddedColor': buttonAddedColor
    };
  }

  static Color fromJson (Map<String, dynamic> json) {
    return Color(
      appBarTitleColor: json['appBarTitleColor'] as Color, 
      buttonAddedColor: json['buttonAddedColor'] as Color, 
      buttonSettingsColor: json['buttonSettingsColor'] as Color, 
      createdDataColor:  json['createdDataColor'] as Color,
      descriptionColor: json['descriptionColor'] as Color, 
      iconDeleteColor: json['iconDeleteColor'] as Color, 
      iconTaskColor: json['iconTaskColor'] as Color, 
      titleColor: json['titleColor'] as Color
      );
  }

  @override
  List<Object> get props => [
    titleColor,
    descriptionColor,
    createdDataColor,
    iconTaskColor,
    iconDeleteColor,
    appBarTitleColor,
    buttonAddedColor,
    buttonSettingsColor
  ];
}
import 'package:alg_bucket/core/logic/navigation/navigation_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';

abstract class WebIconMapper {
  static IconData icon(NavigationDestinationEnum item) {
    return switch (item) {
      NavigationDestinationEnum.signInUserHomePage =>     FluentIcons.border_dash,
      NavigationDestinationEnum.signInUserSettings =>    FluentIcons.settings,
      NavigationDestinationEnum.newUserHomePage =>
      FluentIcons.apps_content,
      NavigationDestinationEnum.newUserAbout ||
      NavigationDestinationEnum.signInUserAboutPage =>
      FluentIcons.info,
    };
  }
}
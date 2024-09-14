part of 'navigation_bloc.dart';

enum NavigationDestinationEnum {
  /// log in user menu items
  signInUserHomePage(
    0,
    'sign-in-user-algset_list-page',
    'Your algorithms',
    'Click here to get to the algorithms',
  ),
  signInUserSettings(
    1,
    'sign-in-user-settings-page',
    'Settings',
    'Click here to change app settings',
  ),
  signInUserAboutPage(
    2,
    'sign-in-user-about-page',
    'About',
    'Click here to learn more about project',
  ),

  /// not logged in user menu items
  newUserHomePage(
    0,
    'not-logged-in-user-algset_list-page',
    'Getting started',
    'Click here to get started',
  ),
  newUserAbout(
    1,
    'not-logged-in-user-about-page',
    'About',
    'Click here to lear more about project',
  ),
  ;

  const NavigationDestinationEnum(
    this.destinationIndex,
    this.destinationName,
    this.title,
    this.tooltip,
  );

  final String destinationName;

  final String title;

  final String tooltip;

  final int destinationIndex;

  static final List<NavigationDestinationEnum> logInUserNavigationDestinationItems = [
    signInUserHomePage,
    signInUserSettings,
    signInUserAboutPage,
  ];

  static final List<NavigationDestinationEnum> newUserNavigationDestinationItems = [
    newUserHomePage,
    newUserAbout,
  ];
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get navStatus;

  /// No description provided for @navRemote.
  ///
  /// In en, this message translates to:
  /// **'Remote'**
  String get navRemote;

  /// No description provided for @navNavigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get navNavigate;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @brandName.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Connect'**
  String get brandName;

  /// No description provided for @onlineStatus.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get onlineStatus;

  /// No description provided for @sectionVehicleStatus.
  ///
  /// In en, this message translates to:
  /// **'VEHICLE STATUS'**
  String get sectionVehicleStatus;

  /// No description provided for @statBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get statBattery;

  /// No description provided for @statSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get statSecurity;

  /// No description provided for @statTires.
  ///
  /// In en, this message translates to:
  /// **'Tires'**
  String get statTires;

  /// No description provided for @statLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get statLocation;

  /// No description provided for @statusLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get statusLocked;

  /// No description provided for @statusUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get statusUnlocked;

  /// No description provided for @allDoorsClosed.
  ///
  /// In en, this message translates to:
  /// **'All doors closed'**
  String get allDoorsClosed;

  /// No description provided for @tirePressureNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get tirePressureNormal;

  /// No description provided for @allPressuresOk.
  ///
  /// In en, this message translates to:
  /// **'All pressures OK'**
  String get allPressuresOk;

  /// No description provided for @vehicleParked.
  ///
  /// In en, this message translates to:
  /// **'Parked'**
  String get vehicleParked;

  /// No description provided for @sectionQuickActions.
  ///
  /// In en, this message translates to:
  /// **'QUICK ACTIONS'**
  String get sectionQuickActions;

  /// No description provided for @actionLock.
  ///
  /// In en, this message translates to:
  /// **'Lock'**
  String get actionLock;

  /// No description provided for @actionUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get actionUnlock;

  /// No description provided for @actionClimate.
  ///
  /// In en, this message translates to:
  /// **'Climate'**
  String get actionClimate;

  /// No description provided for @actionFlash.
  ///
  /// In en, this message translates to:
  /// **'Flash'**
  String get actionFlash;

  /// No description provided for @actionHorn.
  ///
  /// In en, this message translates to:
  /// **'Horn'**
  String get actionHorn;

  /// No description provided for @sectionLastJourney.
  ///
  /// In en, this message translates to:
  /// **'LAST JOURNEY'**
  String get sectionLastJourney;

  /// No description provided for @statDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get statDistance;

  /// No description provided for @statDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get statDuration;

  /// No description provided for @statEfficiency.
  ///
  /// In en, this message translates to:
  /// **'Efficiency'**
  String get statEfficiency;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @vehicleStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Status'**
  String get vehicleStatusTitle;

  /// No description provided for @allSecured.
  ///
  /// In en, this message translates to:
  /// **'All Secured'**
  String get allSecured;

  /// No description provided for @sectionBatteryRange.
  ///
  /// In en, this message translates to:
  /// **'BATTERY & RANGE'**
  String get sectionBatteryRange;

  /// No description provided for @batteryLevel.
  ///
  /// In en, this message translates to:
  /// **'Battery Level'**
  String get batteryLevel;

  /// No description provided for @notCharging.
  ///
  /// In en, this message translates to:
  /// **'Not Charging'**
  String get notCharging;

  /// No description provided for @sectionDoorsSecurity.
  ///
  /// In en, this message translates to:
  /// **'DOORS & SECURITY'**
  String get sectionDoorsSecurity;

  /// No description provided for @doorFrontLeft.
  ///
  /// In en, this message translates to:
  /// **'Front Left Door'**
  String get doorFrontLeft;

  /// No description provided for @doorFrontRight.
  ///
  /// In en, this message translates to:
  /// **'Front Right Door'**
  String get doorFrontRight;

  /// No description provided for @doorRearLeft.
  ///
  /// In en, this message translates to:
  /// **'Rear Left Door'**
  String get doorRearLeft;

  /// No description provided for @doorRearRight.
  ///
  /// In en, this message translates to:
  /// **'Rear Right Door'**
  String get doorRearRight;

  /// No description provided for @trunk.
  ///
  /// In en, this message translates to:
  /// **'Trunk'**
  String get trunk;

  /// No description provided for @sunroof.
  ///
  /// In en, this message translates to:
  /// **'Sunroof'**
  String get sunroof;

  /// No description provided for @doorOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get doorOpen;

  /// No description provided for @doorClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get doorClosed;

  /// No description provided for @sectionTirePressure.
  ///
  /// In en, this message translates to:
  /// **'TIRE PRESSURE'**
  String get sectionTirePressure;

  /// No description provided for @tirePressureRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended: 33 – 35 psi'**
  String get tirePressureRecommended;

  /// No description provided for @sectionMileage.
  ///
  /// In en, this message translates to:
  /// **'MILEAGE'**
  String get sectionMileage;

  /// No description provided for @totalMileage.
  ///
  /// In en, this message translates to:
  /// **'Total Mileage'**
  String get totalMileage;

  /// No description provided for @lastJourney.
  ///
  /// In en, this message translates to:
  /// **'Last Journey'**
  String get lastJourney;

  /// No description provided for @journeyTime.
  ///
  /// In en, this message translates to:
  /// **'Journey Time'**
  String get journeyTime;

  /// No description provided for @remoteControlTitle.
  ///
  /// In en, this message translates to:
  /// **'Remote Control'**
  String get remoteControlTitle;

  /// No description provided for @lastSynced.
  ///
  /// In en, this message translates to:
  /// **'Vehicle last synced: just now'**
  String get lastSynced;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @sectionSecurity.
  ///
  /// In en, this message translates to:
  /// **'SECURITY'**
  String get sectionSecurity;

  /// No description provided for @unlockVehicleTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock Vehicle'**
  String get unlockVehicleTitle;

  /// No description provided for @lockVehicleTitle.
  ///
  /// In en, this message translates to:
  /// **'Lock Vehicle'**
  String get lockVehicleTitle;

  /// No description provided for @unlockVehicleMessage.
  ///
  /// In en, this message translates to:
  /// **'This will unlock all doors. Are you sure?'**
  String get unlockVehicleMessage;

  /// No description provided for @lockVehicleMessage.
  ///
  /// In en, this message translates to:
  /// **'This will lock all doors and activate the alarm.'**
  String get lockVehicleMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @allDoorsAreLocked.
  ///
  /// In en, this message translates to:
  /// **'All doors are locked'**
  String get allDoorsAreLocked;

  /// No description provided for @vehicleIsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Vehicle is unlocked'**
  String get vehicleIsUnlocked;

  /// No description provided for @sectionClimate.
  ///
  /// In en, this message translates to:
  /// **'CLIMATE'**
  String get sectionClimate;

  /// No description provided for @preEntryClimateControl.
  ///
  /// In en, this message translates to:
  /// **'Pre-entry Climate Control'**
  String get preEntryClimateControl;

  /// No description provided for @climateActivatingSoon.
  ///
  /// In en, this message translates to:
  /// **'Climate will activate in ~5 minutes'**
  String get climateActivatingSoon;

  /// No description provided for @climateOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get climateOn;

  /// No description provided for @climateOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get climateOff;

  /// No description provided for @deactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get deactivate;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @sectionControls.
  ///
  /// In en, this message translates to:
  /// **'CONTROLS'**
  String get sectionControls;

  /// No description provided for @flashLights.
  ///
  /// In en, this message translates to:
  /// **'Flash\nLights'**
  String get flashLights;

  /// No description provided for @soundHorn.
  ///
  /// In en, this message translates to:
  /// **'Sound\nHorn'**
  String get soundHorn;

  /// No description provided for @openSunroof.
  ///
  /// In en, this message translates to:
  /// **'Open\nSunroof'**
  String get openSunroof;

  /// No description provided for @closeSunroof.
  ///
  /// In en, this message translates to:
  /// **'Close\nSunroof'**
  String get closeSunroof;

  /// No description provided for @remoteStart.
  ///
  /// In en, this message translates to:
  /// **'Remote\nStart'**
  String get remoteStart;

  /// No description provided for @starting.
  ///
  /// In en, this message translates to:
  /// **'Starting...'**
  String get starting;

  /// No description provided for @navigationTitle.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navigationTitle;

  /// No description provided for @searchForDestination.
  ///
  /// In en, this message translates to:
  /// **'Search for destination...'**
  String get searchForDestination;

  /// No description provided for @searchResultSuffix.
  ///
  /// In en, this message translates to:
  /// **'{query} (Search result)'**
  String searchResultSuffix(String query);

  /// No description provided for @tapToSendToVehicle.
  ///
  /// In en, this message translates to:
  /// **'Tap to send to vehicle'**
  String get tapToSendToVehicle;

  /// No description provided for @routeSentToVehicle.
  ///
  /// In en, this message translates to:
  /// **'Route sent to your vehicle!'**
  String get routeSentToVehicle;

  /// No description provided for @sendToVehicle.
  ///
  /// In en, this message translates to:
  /// **'SEND TO VEHICLE'**
  String get sendToVehicle;

  /// No description provided for @sectionSavedPlaces.
  ///
  /// In en, this message translates to:
  /// **'SAVED PLACES'**
  String get sectionSavedPlaces;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @sectionRecentDestinations.
  ///
  /// In en, this message translates to:
  /// **'RECENT DESTINATIONS'**
  String get sectionRecentDestinations;

  /// No description provided for @servicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get servicesTitle;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back,'**
  String get welcomeBack;

  /// No description provided for @sectionMyServices.
  ///
  /// In en, this message translates to:
  /// **'MY SERVICES'**
  String get sectionMyServices;

  /// No description provided for @serviceWorkshop.
  ///
  /// In en, this message translates to:
  /// **'Workshop'**
  String get serviceWorkshop;

  /// No description provided for @serviceWorkshopSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Book Service'**
  String get serviceWorkshopSubtitle;

  /// No description provided for @serviceDigitalStore.
  ///
  /// In en, this message translates to:
  /// **'Digital Store'**
  String get serviceDigitalStore;

  /// No description provided for @serviceDigitalStoreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Extras & Features'**
  String get serviceDigitalStoreSubtitle;

  /// No description provided for @serviceFindDealer.
  ///
  /// In en, this message translates to:
  /// **'Find Dealer'**
  String get serviceFindDealer;

  /// No description provided for @serviceFindDealerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nearby Centers'**
  String get serviceFindDealerSubtitle;

  /// No description provided for @serviceGeofencing.
  ///
  /// In en, this message translates to:
  /// **'Geofencing'**
  String get serviceGeofencing;

  /// No description provided for @serviceGeofencingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Security Zones'**
  String get serviceGeofencingSubtitle;

  /// No description provided for @sectionUpcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'UPCOMING APPOINTMENTS'**
  String get sectionUpcomingAppointments;

  /// No description provided for @bookNew.
  ///
  /// In en, this message translates to:
  /// **'Book New'**
  String get bookNew;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @sectionEcoDisplay.
  ///
  /// In en, this message translates to:
  /// **'ECO DISPLAY'**
  String get sectionEcoDisplay;

  /// No description provided for @ecoScore.
  ///
  /// In en, this message translates to:
  /// **'Eco Score'**
  String get ecoScore;

  /// No description provided for @ecoAvgRange.
  ///
  /// In en, this message translates to:
  /// **'Avg Range'**
  String get ecoAvgRange;

  /// No description provided for @ecoEfficiency.
  ///
  /// In en, this message translates to:
  /// **'Efficiency'**
  String get ecoEfficiency;

  /// No description provided for @ecoRegenBrake.
  ///
  /// In en, this message translates to:
  /// **'Regen Brake'**
  String get ecoRegenBrake;

  /// No description provided for @ecoEncouragement.
  ///
  /// In en, this message translates to:
  /// **'You drive more efficiently than 73% of drivers!'**
  String get ecoEncouragement;

  /// No description provided for @sectionDigitalExtras.
  ///
  /// In en, this message translates to:
  /// **'DIGITAL EXTRAS'**
  String get sectionDigitalExtras;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @get.
  ///
  /// In en, this message translates to:
  /// **'Get'**
  String get get;

  /// No description provided for @sectionAppearance.
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE'**
  String get sectionAppearance;

  /// No description provided for @sectionBrand.
  ///
  /// In en, this message translates to:
  /// **'ACCENT COLOR'**
  String get sectionBrand;

  /// No description provided for @appearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get appearanceSystem;

  /// No description provided for @appearanceLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get appearanceLight;

  /// No description provided for @appearanceDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get appearanceDark;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsLanguageRegion.
  ///
  /// In en, this message translates to:
  /// **'Language & Region'**
  String get settingsLanguageRegion;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get settingsPrivacy;

  /// No description provided for @settingsHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settingsHelp;

  /// No description provided for @settingsSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get settingsSignOut;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get languageGerman;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your Vehicle ID'**
  String get signInSubtitle;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'EMAIL ADDRESS'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get signIn;

  /// No description provided for @createMercedesMeId.
  ///
  /// In en, this message translates to:
  /// **'CREATE VEHICLE ID'**
  String get createMercedesMeId;

  /// No description provided for @termsAndPrivacy.
  ///
  /// In en, this message translates to:
  /// **'By signing in you agree to our Terms of Service\nand Privacy Policy.'**
  String get termsAndPrivacy;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'YOUR CAR. ANY BRAND.'**
  String get splashTagline;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditProfile;

  /// No description provided for @profileSectionVehicle.
  ///
  /// In en, this message translates to:
  /// **'MY VEHICLE'**
  String get profileSectionVehicle;

  /// No description provided for @profileSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT DETAILS'**
  String get profileSectionAccount;

  /// No description provided for @profileLicensePlate.
  ///
  /// In en, this message translates to:
  /// **'License Plate'**
  String get profileLicensePlate;

  /// No description provided for @profileVin.
  ///
  /// In en, this message translates to:
  /// **'VIN'**
  String get profileVin;

  /// No description provided for @profilePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get profilePhone;

  /// No description provided for @profileMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get profileMemberSince;

  /// No description provided for @profileMercedesMeId.
  ///
  /// In en, this message translates to:
  /// **'Vehicle ID'**
  String get profileMercedesMeId;

  /// No description provided for @dataSynced.
  ///
  /// In en, this message translates to:
  /// **'Vehicle data synced'**
  String get dataSynced;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notifSectionToday.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get notifSectionToday;

  /// No description provided for @notifSectionEarlier.
  ///
  /// In en, this message translates to:
  /// **'EARLIER'**
  String get notifSectionEarlier;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get privacyTitle;

  /// No description provided for @privacyLocationSharing.
  ///
  /// In en, this message translates to:
  /// **'Location Sharing'**
  String get privacyLocationSharing;

  /// No description provided for @privacyLocationSharingDesc.
  ///
  /// In en, this message translates to:
  /// **'Share your vehicle\'s location with the app'**
  String get privacyLocationSharingDesc;

  /// No description provided for @privacyUsageAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Usage Analytics'**
  String get privacyUsageAnalytics;

  /// No description provided for @privacyUsageAnalyticsDesc.
  ///
  /// In en, this message translates to:
  /// **'Help improve the app by sharing usage data'**
  String get privacyUsageAnalyticsDesc;

  /// No description provided for @privacyMarketing.
  ///
  /// In en, this message translates to:
  /// **'Marketing Communications'**
  String get privacyMarketing;

  /// No description provided for @privacyMarketingDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive offers and product news by email'**
  String get privacyMarketingDesc;

  /// No description provided for @privacyDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'Diagnostic Reports'**
  String get privacyDiagnostics;

  /// No description provided for @privacyDiagnosticsDesc.
  ///
  /// In en, this message translates to:
  /// **'Automatically send vehicle diagnostic reports'**
  String get privacyDiagnosticsDesc;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpTitle;

  /// No description provided for @helpCallSupport.
  ///
  /// In en, this message translates to:
  /// **'Call Support'**
  String get helpCallSupport;

  /// No description provided for @helpCallSupportDesc.
  ///
  /// In en, this message translates to:
  /// **'Available 24/7'**
  String get helpCallSupportDesc;

  /// No description provided for @helpEmailSupport.
  ///
  /// In en, this message translates to:
  /// **'Email Support'**
  String get helpEmailSupport;

  /// No description provided for @helpEmailSupportDesc.
  ///
  /// In en, this message translates to:
  /// **'support@vehicleconnect.app'**
  String get helpEmailSupportDesc;

  /// No description provided for @helpLiveChat.
  ///
  /// In en, this message translates to:
  /// **'Live Chat'**
  String get helpLiveChat;

  /// No description provided for @helpLiveChatDesc.
  ///
  /// In en, this message translates to:
  /// **'Chat with an advisor'**
  String get helpLiveChatDesc;

  /// No description provided for @helpFaqSection.
  ///
  /// In en, this message translates to:
  /// **'FREQUENTLY ASKED QUESTIONS'**
  String get helpFaqSection;

  /// No description provided for @helpFaq1Q.
  ///
  /// In en, this message translates to:
  /// **'How do I unlock my vehicle remotely?'**
  String get helpFaq1Q;

  /// No description provided for @helpFaq1A.
  ///
  /// In en, this message translates to:
  /// **'Open the Remote Control tab and tap Unlock. You\'ll be asked to confirm before the command is sent to your vehicle.'**
  String get helpFaq1A;

  /// No description provided for @helpFaq2Q.
  ///
  /// In en, this message translates to:
  /// **'Why is my vehicle showing as offline?'**
  String get helpFaq2Q;

  /// No description provided for @helpFaq2A.
  ///
  /// In en, this message translates to:
  /// **'Your vehicle syncs periodically. Try refreshing on the Status screen, or check that the vehicle has cellular connectivity.'**
  String get helpFaq2A;

  /// No description provided for @helpFaq3Q.
  ///
  /// In en, this message translates to:
  /// **'How do I add a new service appointment?'**
  String get helpFaq3Q;

  /// No description provided for @helpFaq3A.
  ///
  /// In en, this message translates to:
  /// **'Go to Services > Book New under Upcoming Appointments and choose a service type and date.'**
  String get helpFaq3A;

  /// No description provided for @workshopTitle.
  ///
  /// In en, this message translates to:
  /// **'Workshop'**
  String get workshopTitle;

  /// No description provided for @workshopBookService.
  ///
  /// In en, this message translates to:
  /// **'Book Service'**
  String get workshopBookService;

  /// No description provided for @workshopSelectService.
  ///
  /// In en, this message translates to:
  /// **'Select a service'**
  String get workshopSelectService;

  /// No description provided for @workshopServiceGeneral.
  ///
  /// In en, this message translates to:
  /// **'General Service'**
  String get workshopServiceGeneral;

  /// No description provided for @workshopServiceTireRotation.
  ///
  /// In en, this message translates to:
  /// **'Tire Rotation'**
  String get workshopServiceTireRotation;

  /// No description provided for @workshopServiceBrakeCheck.
  ///
  /// In en, this message translates to:
  /// **'Brake Check'**
  String get workshopServiceBrakeCheck;

  /// No description provided for @workshopServiceBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery Health Check'**
  String get workshopServiceBattery;

  /// No description provided for @workshopBooked.
  ///
  /// In en, this message translates to:
  /// **'Appointment booked'**
  String get workshopBooked;

  /// No description provided for @workshopUpcoming.
  ///
  /// In en, this message translates to:
  /// **'UPCOMING APPOINTMENTS'**
  String get workshopUpcoming;

  /// No description provided for @workshopNoAppointments.
  ///
  /// In en, this message translates to:
  /// **'No upcoming appointments'**
  String get workshopNoAppointments;

  /// No description provided for @digitalStoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Digital Store'**
  String get digitalStoreTitle;

  /// No description provided for @digitalStoreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock extra features for your vehicle'**
  String get digitalStoreSubtitle;

  /// No description provided for @digitalStorePurchased.
  ///
  /// In en, this message translates to:
  /// **'Extra unlocked'**
  String get digitalStorePurchased;

  /// No description provided for @findDealerTitle.
  ///
  /// In en, this message translates to:
  /// **'Find Dealer'**
  String get findDealerTitle;

  /// No description provided for @findDealerCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get findDealerCall;

  /// No description provided for @findDealerDirections.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get findDealerDirections;

  /// No description provided for @findDealerCalling.
  ///
  /// In en, this message translates to:
  /// **'Calling dealer…'**
  String get findDealerCalling;

  /// No description provided for @findDealerOpeningMaps.
  ///
  /// In en, this message translates to:
  /// **'Opening directions…'**
  String get findDealerOpeningMaps;

  /// No description provided for @geofencingTitle.
  ///
  /// In en, this message translates to:
  /// **'Geofencing'**
  String get geofencingTitle;

  /// No description provided for @geofencingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get alerts when your vehicle enters or leaves a zone'**
  String get geofencingSubtitle;

  /// No description provided for @geofencingAddZone.
  ///
  /// In en, this message translates to:
  /// **'Add Zone'**
  String get geofencingAddZone;

  /// No description provided for @geofencingNewZoneName.
  ///
  /// In en, this message translates to:
  /// **'Zone name'**
  String get geofencingNewZoneName;

  /// No description provided for @geofencingNewZoneHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Office'**
  String get geofencingNewZoneHint;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your Vehicle ID email and we\'ll send you a reset link.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @forgotPasswordSend.
  ///
  /// In en, this message translates to:
  /// **'SEND RESET LINK'**
  String get forgotPasswordSend;

  /// No description provided for @forgotPasswordSent.
  ///
  /// In en, this message translates to:
  /// **'If an account exists for this email, a reset link has been sent.'**
  String get forgotPasswordSent;

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignIn;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Vehicle ID'**
  String get createAccountTitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'FULL NAME'**
  String get fullName;

  /// No description provided for @createAccountSubmit.
  ///
  /// In en, this message translates to:
  /// **'CREATE ACCOUNT'**
  String get createAccountSubmit;

  /// No description provided for @profileEditVehicle.
  ///
  /// In en, this message translates to:
  /// **'Edit Vehicle'**
  String get profileEditVehicle;

  /// No description provided for @profileAddVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle'**
  String get profileAddVehicle;

  /// No description provided for @profileVehicleMake.
  ///
  /// In en, this message translates to:
  /// **'MAKE'**
  String get profileVehicleMake;

  /// No description provided for @profileVehicleModel.
  ///
  /// In en, this message translates to:
  /// **'MODEL / NAME'**
  String get profileVehicleModel;

  /// No description provided for @profileVehiclePlate.
  ///
  /// In en, this message translates to:
  /// **'LICENSE PLATE'**
  String get profileVehiclePlate;

  /// No description provided for @profileVehicleVin.
  ///
  /// In en, this message translates to:
  /// **'VIN'**
  String get profileVehicleVin;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get save;

  /// No description provided for @profileSectionVehicles.
  ///
  /// In en, this message translates to:
  /// **'MY VEHICLES'**
  String get profileSectionVehicles;

  /// No description provided for @profileActiveVehicle.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get profileActiveVehicle;

  /// No description provided for @profileSwitchToVehicle.
  ///
  /// In en, this message translates to:
  /// **'Switch'**
  String get profileSwitchToVehicle;

  /// No description provided for @profileRemoveVehicle.
  ///
  /// In en, this message translates to:
  /// **'Remove vehicle'**
  String get profileRemoveVehicle;

  /// No description provided for @profileRemoveVehicleConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove this vehicle from your garage? This can\'t be undone.'**
  String get profileRemoveVehicleConfirm;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

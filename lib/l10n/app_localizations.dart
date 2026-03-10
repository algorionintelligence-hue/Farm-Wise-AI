import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ur'),
  ];

  String get appName;
  String get switchLanguage;
  String get english;
  String get urdu;
  String get welcome;
  String get loginTitle;
  String get loginSubtitle;
  String get emailLabel;
  String get emailHint;
  String get passwordLabel;
  String get passwordHint;
  String get continueButton;
  String get noAccount;
  String get signUp;
  String get orSignWith;
  String get signUpWithGoogle;
  String get dashboard;
  String get inventory;
  String get cash;
  String get breeding;
  String get quickAdd;
  String get registerAnimal;
  String get addToHerd;
  String get addRevenue;
  String get milkSales;
  String get addCosts;
  String get feedVet;
  String get workingCapital;
  String get cashPayables;
  String get scenarioSimulator;
  String get aiQaChat;
  String get reportPdfExport;
  String get costInput;
  String get revenueInput;
  String get logout;
  String get farmProfile;
  String get cashRunwayTitle;
  String get todaysGrowth;
  String get revenue;
  String get cost;
  String get profit;
  String get reduceOpenDays;
  String get monthlyLoss;
  String get feedCostHighMilkFlat;
  String get optimizeRationBalance;
  String get sellMaleCalvesInApril;
  String get forecastedCashInjection;
  String get signupTitle;
  String get signupSubtitle;
  String get firstName;
  String get lastName;
  String get phoneNumber;
  String get createAccount;
  String get iAgreeTo;
  String get privacyPolicy;
  String get and;
  String get termsOfUse;
  String get alreadyHaveAccount;
  String get logIn;
  String get requiredField;
  String get enterValidEmail;
  String get enterValidPhone;
  String get farmRegistrationTitle;
  String get farmRegistrationSubtitle;
  String get farmName;
  String get farmNameHint;
  String get location;
  String get selectLocation;
  String get businessType;
  String get selectBusinessType;
  String get totalAnimals;
  String get totalAnimalsHint;
  String get breedName;
  String get quantity;
  String get currency;
  String get selectCurrency;
  String get startingDate;
  String get registerFarm;
  String get dairy;
  String get mixed;
  String get fattening;
  String get scenarioSimulatorTitle;
  String get sliders;
  String get output;
  String get feedPrice;
  String get milkPrice;
  String get pregnancyRate;
  String get newProfit;
  String get days;
  String get aiFarmAdvisor;
  String get askFarmFinance;
  String get askMeAnything;
  String get tapQuestionOrType;
  String get askAboutProfitsCosts;
  String get forecast;
  String nextMonths(int count);
  String get templateProfitableLabel;
  String get templateProfitableQuestion;
  String get templateMoneyFlowLabel;
  String get templateMoneyFlowQuestion;
  String get templatePregnancyRateLabel;
  String get templatePregnancyRateQuestion;
  String get templateCostPerAnimalLabel;
  String get templateCostPerAnimalQuestion;
  String get templateCashIn3MonthsLabel;
  String get templateCashIn3MonthsQuestion;
  String get templateTop10CostlyLabel;
  String get templateTop10CostlyQuestion;
  String get templateFeedPriceUpLabel;
  String get templateFeedPriceUpQuestion;
  String get templateRepeatBreedingLabel;
  String get templateRepeatBreedingQuestion;
  String get templateSellMaleCalvesLabel;
  String get templateSellMaleCalvesQuestion;
  String get reportsTitle;
  String get monthlyPnL;
  String get breedingImpact;
  String get ninetyDayForecast;
  String get inventoryReport;
  String get workingCapitalSubtitle;
  String get workingCapitalSectionSubtitle;
  String get cashOnHandStarting;
  String get receivablesMilkBuyers;
  String get payablesFeedSupplier;
  String get loanInstalmentsExpenseOnly;
  String get loanInfoNote;
  String get netWorkingCapital;
  String get netWorkingCapitalFormula;
  String get netWorkingCapitalAuto;
  String get saveWorkingCapital;
  String get costInputsTitle;
  String get costInputsSubtitle;
  String get feedCosts;
  String get feedCostsSubtitle;
  String get feedType;
  String get quantityPerDayMonthly;
  String get pricePerUnit;
  String get deliveryFrequency;
  String get vetMedicine;
  String get visitDate;
  String get serviceType;
  String get medicineCost;
  String get vetFee;
  String get breedingCost;
  String get naturalServiceOrAiStrawCost;
  String get technicianFee;
  String get pregnancyDiagnosisFee;
  String get labour;
  String get numberOfWorkers;
  String get salariesTotalMonth;
  String get housingFoodAllowanceOptional;
  String get utilitiesOverhead;
  String get electricityWater;
  String get dieselFuel;
  String get rentLease;
  String get maintenanceShedEquipment;
  String get miscellaneous;
  String get capexAssets;
  String get capexAssetsSubtitle;
  String get assetName;
  String get purchaseCost;
  String get usefulLife;
  String get monthlyDepreciationAuto;
  String get saveCostData;
  String get revenueInputsTitle;
  String get revenueInputsSubtitle;
  String get milkRevenueTitle;
  String get milkRevenue;
  String get dailyLitresSold;
  String get pricePerLitre;
  String get collectionTransportCostOptional;
  String get animalSalesTitle;
  String get animalSalesCount;
  String get animalSoldDate;
  String get animalCategory;
  String get selectCategory;
  String get salePrice;
  String get commissionMarketFeeOptional;
  String get otherRevenueTitle;
  String get otherRevenue;
  String get manureBiogasIncomeOptional;
  String get subsidiesGrantsOptional;
  String get saveRevenueData;
  String get cow;
  String get buffalo;
  String get bull;
  String get heifer;
  String get calfMale;
  String get calfFemale;
  String get goat;
  String get sheep;
  String get other;
  String get farmDashboard;
  String get monthlyOverviewHerd;
  String get expectedCalvesNext6Months;
  String get monthlyBreakdown;
  String get monthlyProfit;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError('AppLocalizations.delegate failed to load unsupported locale "$locale".');
}

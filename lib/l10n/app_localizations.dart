import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_sd.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('en'),
    Locale('sd'),
    Locale('ur')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Farm Wise AI'**
  String get appName;

  /// No description provided for @switchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get switchLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @urdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get urdu;

  /// No description provided for @sindhi.
  ///
  /// In en, this message translates to:
  /// **'Sindhi'**
  String get sindhi;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your herd, finances, and farm performance in one place.'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Your email address'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'example@gmail.com'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **' Sign up'**
  String get signUp;

  /// No description provided for @orSignWith.
  ///
  /// In en, this message translates to:
  /// **'Or sign up with'**
  String get orSignWith;

  /// No description provided for @signUpWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get signUpWithGoogle;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @breeding.
  ///
  /// In en, this message translates to:
  /// **'Breeding'**
  String get breeding;

  /// No description provided for @quickAdd.
  ///
  /// In en, this message translates to:
  /// **'Quick Add'**
  String get quickAdd;

  /// No description provided for @registerAnimal.
  ///
  /// In en, this message translates to:
  /// **'Register Animal'**
  String get registerAnimal;

  /// No description provided for @addToHerd.
  ///
  /// In en, this message translates to:
  /// **'Add to herd'**
  String get addToHerd;

  /// No description provided for @addRevenue.
  ///
  /// In en, this message translates to:
  /// **'Add Revenue'**
  String get addRevenue;

  /// No description provided for @milkSales.
  ///
  /// In en, this message translates to:
  /// **'Milk & sales'**
  String get milkSales;

  /// No description provided for @addCosts.
  ///
  /// In en, this message translates to:
  /// **'Add Costs'**
  String get addCosts;

  /// No description provided for @feedVet.
  ///
  /// In en, this message translates to:
  /// **'Feed & vet'**
  String get feedVet;

  /// No description provided for @workingCapital.
  ///
  /// In en, this message translates to:
  /// **'Working Capital'**
  String get workingCapital;

  /// No description provided for @cashPayables.
  ///
  /// In en, this message translates to:
  /// **'Cash & payables'**
  String get cashPayables;

  /// No description provided for @scenarioSimulator.
  ///
  /// In en, this message translates to:
  /// **'Scenario Simulator'**
  String get scenarioSimulator;

  /// No description provided for @aiQaChat.
  ///
  /// In en, this message translates to:
  /// **'AI Q&A Chat'**
  String get aiQaChat;

  /// No description provided for @reportPdfExport.
  ///
  /// In en, this message translates to:
  /// **'Report & PDF Export'**
  String get reportPdfExport;

  /// No description provided for @costInput.
  ///
  /// In en, this message translates to:
  /// **'Cost Input'**
  String get costInput;

  /// No description provided for @revenueInput.
  ///
  /// In en, this message translates to:
  /// **'Revenue Input'**
  String get revenueInput;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @farmProfile.
  ///
  /// In en, this message translates to:
  /// **'Cattle Farm'**
  String get farmProfile;

  /// No description provided for @cashRunwayTitle.
  ///
  /// In en, this message translates to:
  /// **'Cash Runway'**
  String get cashRunwayTitle;

  /// No description provided for @todaysGrowth.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Growth'**
  String get todaysGrowth;

  /// No description provided for @revenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// No description provided for @cost.
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get cost;

  /// No description provided for @profit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get profit;

  /// No description provided for @reduceOpenDays.
  ///
  /// In en, this message translates to:
  /// **'Reduce open days'**
  String get reduceOpenDays;

  /// No description provided for @monthlyLoss.
  ///
  /// In en, this message translates to:
  /// **'PKR 120k/month loss'**
  String get monthlyLoss;

  /// No description provided for @feedCostHighMilkFlat.
  ///
  /// In en, this message translates to:
  /// **'Feed cost high, milk flat'**
  String get feedCostHighMilkFlat;

  /// No description provided for @optimizeRationBalance.
  ///
  /// In en, this message translates to:
  /// **'Optimize ration balance'**
  String get optimizeRationBalance;

  /// No description provided for @sellMaleCalvesInApril.
  ///
  /// In en, this message translates to:
  /// **'Sell male calves in April'**
  String get sellMaleCalvesInApril;

  /// No description provided for @forecastedCashInjection.
  ///
  /// In en, this message translates to:
  /// **'Forecasted cash injection'**
  String get forecastedCashInjection;

  /// No description provided for @signupTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Get You Registered'**
  String get signupTitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill in the details below to create your account.'**
  String get signupSubtitle;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @iAgreeTo.
  ///
  /// In en, this message translates to:
  /// **'I agree to'**
  String get iAgreeTo;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get termsOfUse;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **' Log in'**
  String get logIn;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter valid email'**
  String get enterValidEmail;

  /// No description provided for @enterValidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter valid phone'**
  String get enterValidPhone;

  /// No description provided for @farmRegistrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Register Your Farm'**
  String get farmRegistrationTitle;

  /// No description provided for @farmRegistrationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your farm so we can help you track your animals, milk, and business easily.'**
  String get farmRegistrationSubtitle;

  /// No description provided for @farmName.
  ///
  /// In en, this message translates to:
  /// **'Farm Name'**
  String get farmName;

  /// No description provided for @farmNameHint.
  ///
  /// In en, this message translates to:
  /// **'Cattle farm'**
  String get farmNameHint;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select your location'**
  String get selectLocation;

  /// No description provided for @businessType.
  ///
  /// In en, this message translates to:
  /// **'Business Type'**
  String get businessType;

  /// No description provided for @selectBusinessType.
  ///
  /// In en, this message translates to:
  /// **'Select your business type'**
  String get selectBusinessType;

  /// No description provided for @totalAnimals.
  ///
  /// In en, this message translates to:
  /// **'Total Animals'**
  String get totalAnimals;

  /// No description provided for @totalAnimalsHint.
  ///
  /// In en, this message translates to:
  /// **'Enter number of animals, for example 100'**
  String get totalAnimalsHint;

  /// No description provided for @breedName.
  ///
  /// In en, this message translates to:
  /// **'Breed Name'**
  String get breedName;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select your currency'**
  String get selectCurrency;

  /// No description provided for @startingDate.
  ///
  /// In en, this message translates to:
  /// **'Starting Date'**
  String get startingDate;

  /// No description provided for @registerFarm.
  ///
  /// In en, this message translates to:
  /// **'Register Farm'**
  String get registerFarm;

  /// No description provided for @dairy.
  ///
  /// In en, this message translates to:
  /// **'Dairy'**
  String get dairy;

  /// No description provided for @mixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed'**
  String get mixed;

  /// No description provided for @fattening.
  ///
  /// In en, this message translates to:
  /// **'Fattening'**
  String get fattening;

  /// No description provided for @scenarioSimulatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Scenario Simulator'**
  String get scenarioSimulatorTitle;

  /// No description provided for @sliders.
  ///
  /// In en, this message translates to:
  /// **'Sliders'**
  String get sliders;

  /// No description provided for @output.
  ///
  /// In en, this message translates to:
  /// **'Output'**
  String get output;

  /// No description provided for @feedPrice.
  ///
  /// In en, this message translates to:
  /// **'Feed price'**
  String get feedPrice;

  /// No description provided for @milkPrice.
  ///
  /// In en, this message translates to:
  /// **'Milk price'**
  String get milkPrice;

  /// No description provided for @pregnancyRate.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy rate'**
  String get pregnancyRate;

  /// No description provided for @newProfit.
  ///
  /// In en, this message translates to:
  /// **'New Profit'**
  String get newProfit;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @aiFarmAdvisor.
  ///
  /// In en, this message translates to:
  /// **'AI Farm Advisor'**
  String get aiFarmAdvisor;

  /// No description provided for @askFarmFinance.
  ///
  /// In en, this message translates to:
  /// **'Ask anything about your farm\'s finances and herd.'**
  String get askFarmFinance;

  /// No description provided for @askMeAnything.
  ///
  /// In en, this message translates to:
  /// **'Ask me anything!'**
  String get askMeAnything;

  /// No description provided for @tapQuestionOrType.
  ///
  /// In en, this message translates to:
  /// **'Tap a question below or type your own'**
  String get tapQuestionOrType;

  /// No description provided for @askAboutProfitsCosts.
  ///
  /// In en, this message translates to:
  /// **'Ask about profits, costs, herd...'**
  String get askAboutProfitsCosts;

  /// No description provided for @forecast.
  ///
  /// In en, this message translates to:
  /// **'Forecast'**
  String get forecast;

  /// No description provided for @nextMonths.
  ///
  /// In en, this message translates to:
  /// **'Next {count} Months'**
  String nextMonths(Object count);

  /// No description provided for @templateProfitableLabel.
  ///
  /// In en, this message translates to:
  /// **'Profitable?'**
  String get templateProfitableLabel;

  /// No description provided for @templateProfitableQuestion.
  ///
  /// In en, this message translates to:
  /// **'Am I profitable this month?'**
  String get templateProfitableQuestion;

  /// No description provided for @templateMoneyFlowLabel.
  ///
  /// In en, this message translates to:
  /// **'Money flow'**
  String get templateMoneyFlowLabel;

  /// No description provided for @templateMoneyFlowQuestion.
  ///
  /// In en, this message translates to:
  /// **'Where is my money going?'**
  String get templateMoneyFlowQuestion;

  /// No description provided for @templatePregnancyRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy rate'**
  String get templatePregnancyRateLabel;

  /// No description provided for @templatePregnancyRateQuestion.
  ///
  /// In en, this message translates to:
  /// **'If I improve pregnancy rate from 60% to 75%, what happens?'**
  String get templatePregnancyRateQuestion;

  /// No description provided for @templateCostPerAnimalLabel.
  ///
  /// In en, this message translates to:
  /// **'Cost per animal'**
  String get templateCostPerAnimalLabel;

  /// No description provided for @templateCostPerAnimalQuestion.
  ///
  /// In en, this message translates to:
  /// **'What is my cost per animal?'**
  String get templateCostPerAnimalQuestion;

  /// No description provided for @templateCashIn3MonthsLabel.
  ///
  /// In en, this message translates to:
  /// **'Cash in 3 months'**
  String get templateCashIn3MonthsLabel;

  /// No description provided for @templateCashIn3MonthsQuestion.
  ///
  /// In en, this message translates to:
  /// **'How much cash will I have after 3 months?'**
  String get templateCashIn3MonthsQuestion;

  /// No description provided for @templateTop10CostlyLabel.
  ///
  /// In en, this message translates to:
  /// **'Top 10 costly'**
  String get templateTop10CostlyLabel;

  /// No description provided for @templateTop10CostlyQuestion.
  ///
  /// In en, this message translates to:
  /// **'Which 10 animals are costing me the most?'**
  String get templateTop10CostlyQuestion;

  /// No description provided for @templateFeedPriceUpLabel.
  ///
  /// In en, this message translates to:
  /// **'Feed price +15%'**
  String get templateFeedPriceUpLabel;

  /// No description provided for @templateFeedPriceUpQuestion.
  ///
  /// In en, this message translates to:
  /// **'If feed price increases 15%, what should I change first?'**
  String get templateFeedPriceUpQuestion;

  /// No description provided for @templateRepeatBreedingLabel.
  ///
  /// In en, this message translates to:
  /// **'Repeat breeding'**
  String get templateRepeatBreedingLabel;

  /// No description provided for @templateRepeatBreedingQuestion.
  ///
  /// In en, this message translates to:
  /// **'What is the financial loss of repeat breeding?'**
  String get templateRepeatBreedingQuestion;

  /// No description provided for @templateSellMaleCalvesLabel.
  ///
  /// In en, this message translates to:
  /// **'Sell male calves'**
  String get templateSellMaleCalvesLabel;

  /// No description provided for @templateSellMaleCalvesQuestion.
  ///
  /// In en, this message translates to:
  /// **'When should I sell male calves for best cash flow?'**
  String get templateSellMaleCalvesQuestion;

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Financial & Operational Reports'**
  String get reportsTitle;

  /// No description provided for @monthlyPnL.
  ///
  /// In en, this message translates to:
  /// **'Monthly P&L'**
  String get monthlyPnL;

  /// No description provided for @breedingImpact.
  ///
  /// In en, this message translates to:
  /// **'Breeding Impact'**
  String get breedingImpact;

  /// No description provided for @ninetyDayForecast.
  ///
  /// In en, this message translates to:
  /// **'90-Day Forecast'**
  String get ninetyDayForecast;

  /// No description provided for @inventoryReport.
  ///
  /// In en, this message translates to:
  /// **'Inventory Report'**
  String get inventoryReport;

  /// No description provided for @workingCapitalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your farm\'s short-term financial position'**
  String get workingCapitalSubtitle;

  /// No description provided for @workingCapitalSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Starting position and short-term obligations'**
  String get workingCapitalSectionSubtitle;

  /// No description provided for @cashOnHandStarting.
  ///
  /// In en, this message translates to:
  /// **'Cash on Hand (Starting)'**
  String get cashOnHandStarting;

  /// No description provided for @receivablesMilkBuyers.
  ///
  /// In en, this message translates to:
  /// **'Receivables (Milk Buyers)'**
  String get receivablesMilkBuyers;

  /// No description provided for @payablesFeedSupplier.
  ///
  /// In en, this message translates to:
  /// **'Payables (Feed Supplier)'**
  String get payablesFeedSupplier;

  /// No description provided for @loanInstalmentsExpenseOnly.
  ///
  /// In en, this message translates to:
  /// **'Loan Instalments, if any (expense only)'**
  String get loanInstalmentsExpenseOnly;

  /// No description provided for @loanInfoNote.
  ///
  /// In en, this message translates to:
  /// **'Loan instalments are recorded as an expense only. This is not a lending feature.'**
  String get loanInfoNote;

  /// No description provided for @netWorkingCapital.
  ///
  /// In en, this message translates to:
  /// **'Net Working Capital'**
  String get netWorkingCapital;

  /// No description provided for @netWorkingCapitalFormula.
  ///
  /// In en, this message translates to:
  /// **'Cash + Receivables - Payables - Loan'**
  String get netWorkingCapitalFormula;

  /// No description provided for @netWorkingCapitalAuto.
  ///
  /// In en, this message translates to:
  /// **'Net Working Capital (auto)'**
  String get netWorkingCapitalAuto;

  /// No description provided for @saveWorkingCapital.
  ///
  /// In en, this message translates to:
  /// **'Save Working Capital'**
  String get saveWorkingCapital;

  /// No description provided for @costInputsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cost Inputs'**
  String get costInputsTitle;

  /// No description provided for @costInputsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter all cost details for accurate ERP tracking'**
  String get costInputsSubtitle;

  /// No description provided for @feedCosts.
  ///
  /// In en, this message translates to:
  /// **'Feed Costs'**
  String get feedCosts;

  /// No description provided for @feedCostsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'chokar, silage, bhusa, concentrate, mineral mix'**
  String get feedCostsSubtitle;

  /// No description provided for @feedType.
  ///
  /// In en, this message translates to:
  /// **'Feed Type'**
  String get feedType;

  /// No description provided for @quantityPerDayMonthly.
  ///
  /// In en, this message translates to:
  /// **'Quantity / Day (per group) or Monthly Total'**
  String get quantityPerDayMonthly;

  /// No description provided for @pricePerUnit.
  ///
  /// In en, this message translates to:
  /// **'Price / Unit'**
  String get pricePerUnit;

  /// No description provided for @deliveryFrequency.
  ///
  /// In en, this message translates to:
  /// **'Delivery Frequency'**
  String get deliveryFrequency;

  /// No description provided for @vetMedicine.
  ///
  /// In en, this message translates to:
  /// **'Vet & Medicine'**
  String get vetMedicine;

  /// No description provided for @visitDate.
  ///
  /// In en, this message translates to:
  /// **'Visit Date'**
  String get visitDate;

  /// No description provided for @serviceType.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get serviceType;

  /// No description provided for @medicineCost.
  ///
  /// In en, this message translates to:
  /// **'Medicine Cost'**
  String get medicineCost;

  /// No description provided for @vetFee.
  ///
  /// In en, this message translates to:
  /// **'Vet Fee'**
  String get vetFee;

  /// No description provided for @breedingCost.
  ///
  /// In en, this message translates to:
  /// **'Breeding Cost'**
  String get breedingCost;

  /// No description provided for @naturalServiceOrAiStrawCost.
  ///
  /// In en, this message translates to:
  /// **'Natural Service Fee or AI Straw Cost'**
  String get naturalServiceOrAiStrawCost;

  /// No description provided for @technicianFee.
  ///
  /// In en, this message translates to:
  /// **'Technician Fee'**
  String get technicianFee;

  /// No description provided for @pregnancyDiagnosisFee.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy Diagnosis Fee'**
  String get pregnancyDiagnosisFee;

  /// No description provided for @labour.
  ///
  /// In en, this message translates to:
  /// **'Labour'**
  String get labour;

  /// No description provided for @numberOfWorkers.
  ///
  /// In en, this message translates to:
  /// **'No. of Workers'**
  String get numberOfWorkers;

  /// No description provided for @salariesTotalMonth.
  ///
  /// In en, this message translates to:
  /// **'Salaries Total / Month'**
  String get salariesTotalMonth;

  /// No description provided for @housingFoodAllowanceOptional.
  ///
  /// In en, this message translates to:
  /// **'Housing / Food Allowance (optional)'**
  String get housingFoodAllowanceOptional;

  /// No description provided for @utilitiesOverhead.
  ///
  /// In en, this message translates to:
  /// **'Utilities & Overhead'**
  String get utilitiesOverhead;

  /// No description provided for @electricityWater.
  ///
  /// In en, this message translates to:
  /// **'Electricity & Water'**
  String get electricityWater;

  /// No description provided for @dieselFuel.
  ///
  /// In en, this message translates to:
  /// **'Diesel / Fuel'**
  String get dieselFuel;

  /// No description provided for @rentLease.
  ///
  /// In en, this message translates to:
  /// **'Rent / Lease'**
  String get rentLease;

  /// No description provided for @maintenanceShedEquipment.
  ///
  /// In en, this message translates to:
  /// **'Maintenance (shed, equipment)'**
  String get maintenanceShedEquipment;

  /// No description provided for @miscellaneous.
  ///
  /// In en, this message translates to:
  /// **'Miscellaneous'**
  String get miscellaneous;

  /// No description provided for @capexAssets.
  ///
  /// In en, this message translates to:
  /// **'Capex / Assets'**
  String get capexAssets;

  /// No description provided for @capexAssetsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'generator, chaff cutter, milking machine'**
  String get capexAssetsSubtitle;

  /// No description provided for @assetName.
  ///
  /// In en, this message translates to:
  /// **'Asset Name'**
  String get assetName;

  /// No description provided for @purchaseCost.
  ///
  /// In en, this message translates to:
  /// **'Purchase Cost'**
  String get purchaseCost;

  /// No description provided for @usefulLife.
  ///
  /// In en, this message translates to:
  /// **'Useful Life (months / years)'**
  String get usefulLife;

  /// No description provided for @monthlyDepreciationAuto.
  ///
  /// In en, this message translates to:
  /// **'Monthly Depreciation (auto)'**
  String get monthlyDepreciationAuto;

  /// No description provided for @saveCostData.
  ///
  /// In en, this message translates to:
  /// **'Save Cost Data'**
  String get saveCostData;

  /// No description provided for @revenueInputsTitle.
  ///
  /// In en, this message translates to:
  /// **'Revenue Inputs'**
  String get revenueInputsTitle;

  /// No description provided for @revenueInputsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter all revenue sources for accurate ERP tracking'**
  String get revenueInputsSubtitle;

  /// No description provided for @milkRevenueTitle.
  ///
  /// In en, this message translates to:
  /// **'Milk Revenue'**
  String get milkRevenueTitle;

  /// No description provided for @milkRevenue.
  ///
  /// In en, this message translates to:
  /// **'Milk Revenue'**
  String get milkRevenue;

  /// No description provided for @dailyLitresSold.
  ///
  /// In en, this message translates to:
  /// **'Daily Litres Sold'**
  String get dailyLitresSold;

  /// No description provided for @pricePerLitre.
  ///
  /// In en, this message translates to:
  /// **'Price Per Litre'**
  String get pricePerLitre;

  /// No description provided for @collectionTransportCostOptional.
  ///
  /// In en, this message translates to:
  /// **'Collection / Transport Cost (optional)'**
  String get collectionTransportCostOptional;

  /// No description provided for @animalSalesTitle.
  ///
  /// In en, this message translates to:
  /// **'Animal Sales'**
  String get animalSalesTitle;

  /// No description provided for @animalSalesCount.
  ///
  /// In en, this message translates to:
  /// **'Animal Sales (count)'**
  String get animalSalesCount;

  /// No description provided for @animalSoldDate.
  ///
  /// In en, this message translates to:
  /// **'Animal Sold Date'**
  String get animalSoldDate;

  /// No description provided for @animalCategory.
  ///
  /// In en, this message translates to:
  /// **'Animal Category'**
  String get animalCategory;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get selectCategory;

  /// No description provided for @salePrice.
  ///
  /// In en, this message translates to:
  /// **'Sale Price'**
  String get salePrice;

  /// No description provided for @commissionMarketFeeOptional.
  ///
  /// In en, this message translates to:
  /// **'Commission / Market Fee (optional)'**
  String get commissionMarketFeeOptional;

  /// No description provided for @otherRevenueTitle.
  ///
  /// In en, this message translates to:
  /// **'Other Revenue'**
  String get otherRevenueTitle;

  /// No description provided for @otherRevenue.
  ///
  /// In en, this message translates to:
  /// **'Other Revenue'**
  String get otherRevenue;

  /// No description provided for @manureBiogasIncomeOptional.
  ///
  /// In en, this message translates to:
  /// **'Manure / Biogas Income (optional)'**
  String get manureBiogasIncomeOptional;

  /// No description provided for @subsidiesGrantsOptional.
  ///
  /// In en, this message translates to:
  /// **'Subsidies / Grants (optional)'**
  String get subsidiesGrantsOptional;

  /// No description provided for @saveRevenueData.
  ///
  /// In en, this message translates to:
  /// **'Save Revenue Data'**
  String get saveRevenueData;

  /// No description provided for @cow.
  ///
  /// In en, this message translates to:
  /// **'Cow'**
  String get cow;

  /// No description provided for @buffalo.
  ///
  /// In en, this message translates to:
  /// **'Buffalo'**
  String get buffalo;

  /// No description provided for @bull.
  ///
  /// In en, this message translates to:
  /// **'Bull'**
  String get bull;

  /// No description provided for @heifer.
  ///
  /// In en, this message translates to:
  /// **'Heifer'**
  String get heifer;

  /// No description provided for @calfMale.
  ///
  /// In en, this message translates to:
  /// **'Calf (Male)'**
  String get calfMale;

  /// No description provided for @calfFemale.
  ///
  /// In en, this message translates to:
  /// **'Calf (Female)'**
  String get calfFemale;

  /// No description provided for @goat.
  ///
  /// In en, this message translates to:
  /// **'Goat'**
  String get goat;

  /// No description provided for @sheep.
  ///
  /// In en, this message translates to:
  /// **'Sheep'**
  String get sheep;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @farmDashboard.
  ///
  /// In en, this message translates to:
  /// **'Farm Dashboard'**
  String get farmDashboard;

  /// No description provided for @monthlyOverviewHerd.
  ///
  /// In en, this message translates to:
  /// **'Monthly overview of your herd'**
  String get monthlyOverviewHerd;

  /// No description provided for @expectedCalvesNext6Months.
  ///
  /// In en, this message translates to:
  /// **'Expected Calves (next 6 months)'**
  String get expectedCalvesNext6Months;

  /// No description provided for @monthlyBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Monthly Breakdown'**
  String get monthlyBreakdown;

  /// No description provided for @monthlyProfit.
  ///
  /// In en, this message translates to:
  /// **'Monthly Profit'**
  String get monthlyProfit;
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
      <String>['en', 'sd', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'sd':
      return AppLocalizationsSd();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

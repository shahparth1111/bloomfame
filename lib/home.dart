import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'selectcategory.dart';
import 'restartapp.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'usersignon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'text_styles.dart';
import 'java_methods.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as serviceControl;

class HomePage extends StatefulWidget {
  static double fontSizeAddition=2;
  static const platform = MethodChannel('com.smatter.eagle/preparecustomnotification');
  static String themeMode="original", activeScreen="Home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> with WidgetsBindingObserver, SingleTickerProviderStateMixin{
  final appCheck = FirebaseAppCheck.instance;String message = '';String eventToken = 'not yet';
  FirebaseApp defaultApp = Firebase.app();final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController controller = TextEditingController();
  JavaMethodsCustom sBase = JavaMethodsCustom();
  dynamic path;  TextEditingController iURL= TextEditingController(), tViews= TextEditingController(), tClicks= TextEditingController(),
      tImpressions= TextEditingController(), tLikes= TextEditingController(), tComments= TextEditingController(),
      tShares= TextEditingController(), tSaves= TextEditingController(),
      tTopLocationA= TextEditingController(), tTopLocationB= TextEditingController(), tTopLocationC= TextEditingController(),
      tTopLocationD= TextEditingController(), tTopLocationE= TextEditingController(), tAge1317= TextEditingController(),
      tAge1824= TextEditingController(), tAge2534= TextEditingController(), tAge3544= TextEditingController(),
      tAge4554= TextEditingController(), tAge5564= TextEditingController(),
      tAge65= TextEditingController(), tMale= TextEditingController(), tFemale= TextEditingController(),
      tFollows= TextEditingController();TextEditingController lContentViews = TextEditingController(), lContentReactions= TextEditingController(),
      lContentComments= TextEditingController(), lContentReposts = TextEditingController(),
      lContentImpressionsOrganic = TextEditingController(), lContentImpressionsSponsored = TextEditingController(),
      lVisitorPageViewCount = TextEditingController(), lContentUniqueVisitors = TextEditingController(),
      lContentCustomButtonClick = TextEditingController(), lVisitorJobFunction = TextEditingController(),
      lVisitorCompanySize = TextEditingController(), lVisitorIndustry = TextEditingController(),
      lVisitorLocation = TextEditingController(), lVisitorSeniority = TextEditingController();
  TextEditingController yURL = TextEditingController(), yViews = TextEditingController(), yWatchTime = TextEditingController(),
      ySubscribers = TextEditingController(), yRImpressions = TextEditingController(), yRImpressionsCTR = TextEditingController(),
      yRViews = TextEditingController(), yRUniqueViewers = TextEditingController(), yEViewDuration = TextEditingController(),
      yARetention = TextEditingController(), yAPercentageViewed = TextEditingController(), yDCTA = TextEditingController(),
      yDCTB = TextEditingController(), yDCTC = TextEditingController(), yDCYD = TextEditingController(), yDCYE = TextEditingController(),
      yDCityA = TextEditingController(), yDCityB = TextEditingController(), yDCityC = TextEditingController(),
      yDCityD = TextEditingController(), yDCityE = TextEditingController(),
      yDSourceA = TextEditingController(), yDSourceB = TextEditingController(), yDSourceC = TextEditingController(),
      yDSourceD = TextEditingController(), yDSourceE = TextEditingController(),
      yDAge1317 = TextEditingController(), yDAge1824 = TextEditingController(), yDAge2534 = TextEditingController(),
      yDAge3544 = TextEditingController(), yDAge4554 = TextEditingController(), yDAge5564 = TextEditingController(),
      yDAge65 = TextEditingController(), yDGenderM= TextEditingController(), yDGenderF = TextEditingController(), yDGenderO = TextEditingController(),
      yDDeviceMobile = TextEditingController(), yDDeviceComputer = TextEditingController(), yDDeviceTablet = TextEditingController(),
      yDDeviceTV = TextEditingController();final TextEditingController phoneNumberController = TextEditingController();
  TextEditingController snapchatURL = TextEditingController(), sViews = TextEditingController(), sClicks = TextEditingController(),
      sImpressions = TextEditingController(), sLikes = TextEditingController();
  TextEditingController whatsappURL = TextEditingController(), wViews = TextEditingController(), wClicks = TextEditingController(),
      wImpressions = TextEditingController(), wLikes = TextEditingController();
  TextEditingController aVInstagram = TextEditingController(), aVYoutube = TextEditingController(), aVFacebook = TextEditingController(),
      aVSnapchat = TextEditingController(), aVLinkedin = TextEditingController(), aVX = TextEditingController(),
      aVThreads = TextEditingController(), aVWhatsapp = TextEditingController();
  final TextEditingController newUserController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController challanController = TextEditingController();
  final TextEditingController pNCA = TextEditingController();
  final TextEditingController phoneNumberControllerGroupPassword = TextEditingController();
  final TextEditingController itemUsageListController = TextEditingController();
  final TextEditingController itemStatusListController = TextEditingController();
  final TextEditingController companyAuthCode = TextEditingController();
  final TextEditingController orderID = TextEditingController();
  ScrollController scrollController = ScrollController();
  ScrollController settingsControllerS = ScrollController();
  late FirebaseDatabase database;
  late File iF;String selectedItem="Select Item", selectedSite="Site Location",
      selectedUnit="Unit", phoneNumber="", appVersion="v1.0.1", cBoxText="Smatter",
      numTyp="", myPicture="", selectedFileType="", companyCode="Default",
      userPictureName="", companyA="Auth: ", userRights="None", selectedUpdate="None",
      deliverySelection="DeliveryDebit", selectedCompany="Select Company", showDList="None",
      _dropDownValue="", currentScreen="Analysis", accountName="#",
      userNoID="#", myCategories="#";
  double separatorWidth = 0;
  int checkDeletePhotoDuplicate=0, duplicateCounter=0, clickedIndex=0;
  dynamic dBRef13, dBRef15, dBRef16, dBRef18, dBRef9, dBRef11, dBRef12, dBRef17, dBRef20, dBRef21;
  dynamic subscription;bool isNotificationsOn=true, isSearchTyped=false, isSearchStatus=false, showMainSearch=false,
      isFromPrivate=false, isTyped=false, showAccountSearch=false, keyboardFocus=false,
      isCAPON=false, isCAPOnF=false, isAlphaNumericK=true, showError=false, imageFound=false,
      isSearchTypedStatus=false, isOrder=false, isInstagramConnected=false, isYoutubeConnected=false,
      isFacebookConnected=false, isSnapchatConnected=false, isLinkedinConnected=false, isXConnected=false,
      isThreadsConnected=false, isWhatsappConnected=false;
  String artistFee="0", iCount="12.58L", yCount="76388", fCount="85785", sCount="525K",
      lCount="9.25L", xCount="76388", tCount="33.5K", wCount="1420", artistFeeType="Manual";
  List<String> finalLanguageList = <String>[];
  List<String> groupSelect = <String>[];
  List<String> itemList=<String>[];
  List<String> filteredItemList=<String>[];
  List<String> unitList=<String>[];
  List<String> filteredUnitList=<String>[];
  List<String> siteLocationList=<String>[];
  List<String> filteredSiteLocationList=<String>[];
  List<String> companyList=<String>[];
  List<String> filteredCompanyList=<String>[];
  List<ItemStatus> iS = <ItemStatus>[];
  List<ItemStatus> iSFiltered = <ItemStatus>[];
  List<ItemUsage> iUsage = <ItemUsage>[];
  List<ItemUsage> iUsageFiltered = <ItemUsage>[];
  List<OrderList> oList = <OrderList>[];
  List<OrderList> oListFiltered = <OrderList>[];
  List<UserRights> userRightsL = <UserRights>[];
  final snackBarA = const SnackBar(
    content: Text('Deleting Item..'),
  );
  int newReqCount=0, newAddCount=0, newNotificationCount=0;
  File sF = File("");
  File bannerI = File("");
  List<CampaignControl> wList = <CampaignControl>[];
  CampaignControl clickedC = CampaignControl("", "", "", "", "", "", "", "", "", "", "", "", "", "",
      "", "", "", "", "", "", "", "", "", "", "", "", "",
      "", "", "", "", "", "", "", "", "", "", "", "", "", "",
      "", "", "", "", "", "", "", "", "", "", "", "", "",
      "", "", "", "", "", "", "", "", "", "", "", "", "",
      "", "", "", "", "", "", "", "", "", "");
  List<SubscriberSeries> data = [];
  List<IndustryExplore> iEList= <IndustryExplore>[];
  List<ProfileList> profileList = <ProfileList>[];
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool toShowViewAll=false, showUserRequest=false, showUserNotification=false;
  String myCategory="#";
  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late FirebaseMessaging messaging;
  String initialCountry="in", selectedCountryCode="+91", verificationId="";
  bool isPhoneNumberCorrect=false, isNameCorrect=false;
  List<String> filteredList= <String>[];
  List<String> newFilteredList= <String>[];

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'campaign',
      'invitation',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['payload'],
    );
  }
  @override
  void initState(){
    if (!kDebugMode){
      appCheck.onTokenChange.listen(setEventToken);
    }
    super.initState();
    if (!kDebugMode){
      appCheck.getToken(true);
    }
    database = FirebaseDatabase.instanceFor(app: defaultApp, databaseURL: 'https://bloomfame-ny-default-rtdb.firebaseio.com');
    messaging = FirebaseMessaging.instance;
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");
    });
    initializeVariables();
  }
  void setMessage(String message) {
    setState(() {
      message = message;
    });
  }
  void setEventToken(String? token) {
    eventToken = token ?? 'not yet';
  }
  String getDateTodayTimeStamp(){
      var now = DateTime.now();
      return DateFormat('E, d MMM yyyy HH:mm:ss').format(now);
  }
  String getMonthTimeStamp(){
    var now = DateTime.now();
    return DateFormat('MM-yyyy').format(now);
  }
  String getLastMonthTimeStamp(){
    var now = DateTime.now();
    DateTime futurePast = now.subtract(const Duration(days: 30));
    return DateFormat('MM-yyyy').format(futurePast);
  }
  String dateForNews(){
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
  Future<void> showNotification(String title, String message) async {
    const platform = MethodChannel('com.stratusacumen.bloomfame/notifications');
    try {
      await platform.invokeMethod('showNotification', {
        'title': title,
        'message': message,
      });
    } on PlatformException catch (e) {
      print("Failed to show notification: '${e.message}'.");
    }
  }
  @override
  void setState(VoidCallback fn){
    if(mounted){
      super.setState(fn);
    }
  }
  void initializeVariables()async{
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        FirebaseAuth fAuth = FirebaseAuth.instance;
        await fAuth.signInAnonymously();
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        await showNotification("Bloomfame Invitation", "You have a new business request");
      }
    });
    await FirebaseMessaging.instance.subscribeToTopic("General");
    //await appCheck.setTokenAutoRefreshEnabled(true);
    path = await _localPath;
    /*if(sBase.checkFileExistSync(path, "Manual", "Restart", "Scheduled")){
      sBase.deleteFile(path, "Manual", "Restart", "Scheduled");
      RestartWidget.restartApp(context);
    }*/
    myCategories = sBase.getFirstLineSync(path, "User", "Business", "Categories");
    if(sBase.checkFileExistSync(path, "User", "Details", "Verification")){
      if(sBase.checkFileExistSync(path, "User", "Details", "AccountType")){
        if(sBase.checkFileExistSync(path, "User", "Details", "PhoneNumberM")){
          loadInBackground();
        }
        else{
          _pushPage(context, const SelectCategory());
        }
      }
      else{
        _pushPage(context, const SelectCategory());
      }
    }
    else{
      transferToVerification();
    }
  }
  void transferToVerification(){
    _pushPage(context, const UserSignOn());
  }
  void loadItemOrderList(){
    oList.clear();
    sBase.getAllFilesSubDirectory(path, "LiveEachOrder", "Database").forEach((itemKeys) {
      //File: '/data/user/0/com.smatter.buildtrackr/cache/Data/ItemName/I1'
      String iK = itemKeys.toString();
      iK = iK.substring(iK.lastIndexOf("/")+1, iK.length-1);
      String eachItemUsageDetails = sBase.getFirstLineSync(path, "LiveEachOrder", "Database", iK);
      int eC=0;
      String oID="", iName="", suppName="", iQuantity="", iUnit="", iPrice="", iTime="", iStatus="";
      sBase.delimitString(eachItemUsageDetails, "~").forEach((element) {
        if(eC==0){
          oID=element;
        }
        else if(eC==1){
          iName=element;
        }
        else if(eC==2){
          iQuantity=element;
        }
        else if(eC==3){
          iPrice=element;
        }
        else if(eC==4){
          iUnit=element;
        }
        else if(eC==5){
          suppName=element;
        }
        else if(eC==6){
          iTime=element;
        }
        else if(eC==7){
          iStatus=element;
        }
        eC++;
      });
      setState(() {
        oList.add(getObjectWithItemOrder(oID, iName, suppName, iQuantity, iUnit, iPrice, iTime, iStatus));
      });
    });
  }
  void loadItemStatusList(){
    iS.clear();
    sBase.getAllFilesSubDirectory(path, "LiveStock", "Database").forEach((itemKeys) {
      //File: '/data/user/0/com.smatter.buildtrackr/cache/Data/ItemName/I1'
      String iK = itemKeys.toString();
      iK = iK.substring(iK.lastIndexOf("/")+1, iK.length-1);
      String eachItemUsageDetails = sBase.getFirstLineSync(path, "LiveStock", "Database", iK);
      int eC=0;
      String iName="", iQ="", iP="", iTotal="", iSL="";
      sBase.delimitString(eachItemUsageDetails, "~").forEach((element) {
        if(eC==0){
          iName=element;
        }
        else if(eC==1){
          iQ=element;
        }
        else if(eC==2){
          iP=element;
        }
        else if(eC==3){
          iTotal=element;
        }
        else if(eC==4){
          iSL=element;
        }
        eC++;
      });
      setState(() {
        iS.add(getObjectWithItemStatus(iName, iQ, iP, iTotal, iSL));
      });
    });
  }
  CampaignControl getObjectWithCampaignControl(String campaignStatus, String campaignID, agencyID, agencyName, companyID, companyName, productGenericID,
      brandID, modelID, campaignName, productCategory, productPublicName,
      brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
      productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
      targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferingByBloomfame, artistFeeOfferingRange,
      artistFeeNegotiation, paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating,
      campaignRatingByAgencyArtist, campaignPlatform, analysisViews, analysisLikes, analysisComments, analysisReach,
      analysisDemographics, analysisExpectedOutput, analysisExactOutcome, analysisSuccess, analysisClicks,
      analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
      campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
      isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ) {
    return CampaignControl(campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName,
        productCategory, productPublicName,
        brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
        productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
        targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferingByBloomfame, artistFeeOfferingRange,
        artistFeeNegotiation,
        paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
        analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
        analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
        campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
        isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ);
  }
  ItemStatus getObjectWithItemStatus(String iName, iQ, iP, iTotal, iSL) {
    return ItemStatus(iName, iQ, iP, iTotal, iSL);
  }
  ItemUsage getObjectWithItemUsage(String iName, iQ, iP, iType, iSL, iUser, iDT, iInvoice, iC, iPictureName, iStatus, iKey) {
    return ItemUsage(iName, iQ, iP, iType, iSL, iUser, iDT, iInvoice, iC, iPictureName, iStatus, iKey);
  }
  OrderList getObjectWithItemOrder(String oID, iName, suppName, iQuantity, iUnit, iPrice, iTime, iStatus) {
    return OrderList(oID, iName, suppName, iQuantity, iUnit, iPrice, iTime, iStatus);
  }
  bool checkDateLocalIsOld(String dateToCheck, bool isItem){
    String getLocalDateLatest = isItem?sBase.getFirstLineSync(path, "LiveData", "DateUpdatedItem", "Latest"):
    sBase.getFirstLineSync(path, "LiveData", "DateUpdated", "Latest");
    late Duration duration;
    if(getLocalDateLatest.isNotEmpty && getLocalDateLatest!="#"){
      DateTime localDate = getInitialisedLocalDate(getLocalDateLatest);
      DateTime toCheckDate = getInitialisedLocalDate(dateToCheck);
      duration = toCheckDate.difference(localDate);
    }
    if((getLocalDateLatest.isEmpty || getLocalDateLatest=="#") || duration.inSeconds>0){
      return true;
    }
    else{
      return false;
    }
  }
  DateTime getInitialisedLocalDate(String dateL){
    dateL = "$dateL-";
    int count=0;
    String yy="", mm="", dd="", hh="", min="", sec="";
    sBase.delimitString(dateL, "-").forEach((element) {
      if(count==0){
        yy=element;
      }
      else if(count==1){
        mm=element;
      }
      else if(count==2){
        dd=element;
      }
      else if(count==3){
        hh=element;
      }
      else if(count==4){
        min=element;
      }
      else if(count==5){
        sec=element;
      }
      count++;
    });
    return DateTime(int.parse(yy), int.parse(mm), int.parse(dd), int.parse(hh), int.parse(min), int.parse(sec));
  }
  void pickDynamicInput(BuildContext context, List<String> nList, List<String> newFilteredList, String dynamicTitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.8,
              maxChildSize: 1.0,
              builder: (_, controller) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setStateC) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.remove,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,
                                right: 20,
                              ),
                              child: TextField(
                                style: userRegistrationTitleU,
                                autofocus: isSearchTyped?true:false,
                                textAlign: TextAlign.start,
                                onChanged: (text) {
                                  isSearchTyped=true;
                                  setStateC((){
                                    newFilteredList = nList
                                        .where((u) => (u
                                        .toLowerCase()
                                        .contains(text.toLowerCase())
                                    )).toList();
                                  });
                                  setState(() {
                                  });
                                },
                                autocorrect: false,
                                decoration: InputDecoration(
                                  hintText: 'Search $dynamicTitle',
                                  hintStyle: userSignOnTextField,
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                controller: phoneNumberController,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: ListView.builder(
                                  controller: controller,
                                  itemCount: newFilteredList.isEmpty?nList.length:newFilteredList.length,
                                  itemBuilder: (_, index) {
                                    String fItem="", itemName="", itemNumber="";
                                    if(newFilteredList.isEmpty){
                                      newFilteredList = nList;
                                    }
                                    fItem = newFilteredList[index];
                                    itemNumber = fItem.substring(0, fItem.indexOf("-"));
                                    itemName = (fItem.substring(fItem.indexOf("-")+1)).toLowerCase();
                                    return GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: (){
                                        if(Navigator.canPop(context)){
                                          Navigator.pop(context);
                                        }
                                        setState(() {
                                          if(dynamicTitle.contains("Item")){
                                            selectedItem = "$itemNumber-$itemName";
                                          }
                                          else if(dynamicTitle.contains("Site")){
                                            selectedSite="$itemNumber-$itemName";
                                          }
                                          else if(dynamicTitle.contains("Company")){
                                            selectedCompany="$itemNumber-$itemName";
                                          }
                                          else{
                                            selectedUnit="$itemNumber-$itemName";
                                          }
                                          isSearchTyped=false;
                                          phoneNumberController.clear();
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                                                child: Text(itemNumber, style: userSignOnOccupationTitleGreySL,),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 7,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                    child: Text(itemName, style: userSignOnOccupationTitleGreySL,),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ),
        );
      },
    );
  }
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
  void realTimeOTP(){
    database.ref('Database/OTP/$userNoID').onValue.listen((event) {
      var sValue = event.snapshot.value;
      if(sValue!=null){
        showDynamicMessage(sValue.toString(), false);
      }
    });
  }
  void showDynamicMessage(String messageText, bool isError){
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(1, (index) =>
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setStateC) {
                      return Container(
                        decoration: BoxDecoration(
                          color: isError?darkRed:Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff000000),
                              spreadRadius: 10,
                              blurRadius: 13,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.remove,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(messageText, style: isError?userSignOnOccupationTitleGreySLW:headingTextTitlesBGAA,),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: InkWell(
                                  onTap: ()async{
                                    await Clipboard.setData(ClipboardData(text: messageText));
                                    database.ref('Database/OTP/$userNoID').remove();
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                    child: Container(
                                      height: 50,
                                      width: 200,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Color(0xff000026),
                                              Color(0xff000026),
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.copy_rounded,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Copy OTP", style: headingTextTitlesW),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
            ),
          ),
        );
      },
    );
  }
  void loadInBackground()async{
    //await appCheck.setTokenAutoRefreshEnabled(true);
    if(sBase.checkFileExistSync(path, "User", "Details", "FeesDollarsW")){
      sBase.deleteFile(path, "User", "Details", "FeesDollarsW");
      RestartWidget.restartApp(context);
    }
    data = [
      SubscriberSeries(
        year: "IG",
        subscribers: 2400,
        barColor: Colors.pinkAccent,
      ),
      SubscriberSeries(
        year: "YT",
        subscribers: 8000,
        barColor: Colors.red,
      ),
      SubscriberSeries(
        year: "FB",
        subscribers: 1280,
        barColor: Colors.blue,
      ),
      SubscriberSeries(
        year: "SC",
        subscribers: 2240,
        barColor: Colors.yellow,
      ),
      SubscriberSeries(
        year: "LN",
        subscribers: 1200,
        barColor: darkBlue,
      ),
      SubscriberSeries(
        year: "X",
        subscribers: 600,
        barColor: Colors.black,
      ),
      SubscriberSeries(
        year: "TH",
        subscribers: 2400,
        barColor: Colors.black,
      ),
      SubscriberSeries(
        year: "WA",
        subscribers: 8000,
        barColor: Colors.green,
      ),
    ];
    setState((){
      userNoID=sBase.getFirstLineSync(path, "User", "Details", "NoID");
      accountName = sBase.getFirstLineSync(path, "User", "Details", "Name");
    });
    realTimeOTP();
    String profilePicture = sBase.getFirstLineSync(path, "User", "Profile", "DownloadedImageFilePath");
    setState(() {
      if(profilePicture!="#"){
        sF = File(profilePicture);
      }
    });
    loadCampaignList();
    updateCampaigns(false, "none", false);
    loadNews();
    loadSocialMedia();
    loadValuation();
    getArtistFeeInDollar();
    updateSpecificUserCampaign();
    //loadCampaignsDynamically();
    String aEmail = sBase.getFirstLineSync(path, "User", "Details", "Email");
    if(aEmail=="smatter.app@gmail.com"){
      receiveServerRequestToSendNotifications();
    }
  }
  void receiveServerRequestToSendNotifications(){
    database.ref('Database/RemotePrivateNotifications').onValue.listen((event) {
      var sValue = event.snapshot.value;
      if(sValue!=null){
        String categoryB = sValue.toString();
        sendNotification(categoryB, "Bloomfame Invitation", "You have a new business request");
        database.ref('Database/RemotePrivateNotifications').remove();
      }
    });
  }
  Future<void> sendNotification(String sCat, String title, String body) async {
    final serviceAccountJson =
    {
      "type": "service_account",
      "project_id": "bloomfame-ny",
      "private_key_id": "64b098c63fbdbaf1e9a87430dac1fcfe847e342e",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCij5y4wCcpxn71\nyyIBg2PUS/a+Tk9/fAlR1ge+7iFKxZBrGnKC45W0zqN1Lsmd2HQOzB5rtCpNIN+o\nfvubC7Ks5CyJ4QmvpUI3/OCeyW23l/n3P3vyq3VsW4o7MpoN0qiS+AGKBQhl5TyV\nvz0EZAQDbcAUQfW77YscyU6wETJ+EXzXbxvezAV9PWcfvmr9GjR8IoNIPlmN8DaT\nH4Kd/hJe7HoPJ8n2JR/c6MMS++J6RpJHFP2i6VK+q61QrekT/jkYkYqnLJkuRGFM\nFNZK2cCQrNV1QmTDtdr4XESMEbAAEMDhtWv2/GMIfS7YVop5TROkjBcQwMapoDrD\nEj0JI1UJAgMBAAECggEABabVjYzMr8ShbF08GO5e/aYIdZRWajm/PzOgQFCaIrXc\nsASS358W+NrITw4p302Dt3H8SsVQRS8z53FGwRy2gRFLxR1oT02BEF4/1vVs1Zm4\njJKN9iFk6zgBhc5cEcf1qWpq70f+g0Bli1VDQ1BQ3Wem6m1ipD59fCo5jKCEb2KR\nDaITrbyqnissdROivYhaJy1/q8rO/n7W/bN42WOulfkWUcCU7wsDXAg5AKiUgwl2\nAQgcOxtSspPmXz838BkgiB4x6eGrs+fbkCV3Ne+xTm95YEz2Kj1foQuBXX9gy6LH\n6RnDHIDeXV/LCfSzRLgK6XywmoaUt+joe6/JIe+ygQKBgQDYKsp0kRoMw3cC3dLO\n7zgzPpjyVNvvEcamYkZp3TU3qki9dQq86Z5fyRgj7Wwcq4bHQLXqzXhAXfl2sCDe\nptWWueOcmVayr+DAWtltwV/pbjQiZD0R6VX8liZGE5DGT9NqvMyNDmmrBcvfPy4G\novz2vV8GbcKN5MoVVCaEvgIzoQKBgQDAhBGL2oyS5Q4PSg48QMTiVumXGPgnCb9y\nIaDNJ2rClpC3SH+7zXH5xDPTr5R48aNrPk+mx8jXvWC0rCtiQIvw7zK6wWzIfIdO\nBi7XN6LvVSsHBUxHieybirMcabObqBXWsPC2NM7X5FbRrUyOPTHf8oMss30K7eNN\nwghyYksoaQKBgBOvUeBrlkOzSRMpwBi4EBYajTMEJ0MOC1j7eg4J5t660wTts5yg\naZuvZFNhO4cg15Utf2NycpDp/d2hDF06NBkVtHR+QjbjbUQXAdXM1j8bmgPHvQf0\nh7AIvFOFVJm6izYdG0N9HIJGdNpPlpFkJkUR2aVsOVtSilSG5TsRUoIBAoGAK5A3\nIDyOPtdSPSd23S+S3dzo8uYVkU/lYIA3kPTwdaP4j2D6dpbgybIaQDalFFEpt6Tc\nBVOEIT2bWobzMkKE6DpYcmY+pYd4XrGLe+v9FMdi+y25ux58yh2ytiU9HWYFuxVD\nAxgkDjp/YuciQbWbSZ/pCv56tzRpkTjtDGUtuLECgYEAqufmxyZ4hUtszUZLkShj\n4y+e7Kpshxo/QJRUMVEgMPCeXpiMIeX2K6KFOvKJBQ3J8j2qYJpWUDqW/fuOukks\nnCiAiHCzAavlXChF0IhG1GBMB0+295UDL9OBhnD86ADt/GE/jJCXzA0lfzCc36Yh\nO2U09ZlDxW9Jy9bYNVfJkVQ=\n-----END PRIVATE KEY-----\n",
      "client_email": "bloomfame-ny@appspot.gserviceaccount.com",
      "client_id": "118028791546077515878",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/bloomfame-ny%40appspot.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    auth.AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );
    client.close();
    final String serverKey = credentials.accessToken.data;
    const url = 'https://fcm.googleapis.com/v1/projects/bloomfame-ny/messages:send';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey', // Ensure this token is correct
    };
    final payload = {
      "message": {
        "topic": sCat,
        "notification": {
          "title": title,
          "body": body,
          "image": "https://firebasestorage.googleapis.com/v0/b/bloomfame-ny.appspot.com/o/notificationbanner.png?alt=media&token=bbf0c18d-77d1-48d9-a6f3-d8f312f77543"
        }
      }
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification');
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  void loadValuation(){
    database.ref('Database/Users/$userNoID/ArtistFee').onValue.listen((event) {
      var sValue = event.snapshot.value;
      if(sValue!=null){
        int eC=0;
        sBase.delimitString(sValue.toString(), "~").forEach((element) {
          if(eC==0){
            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Instagram", element, false);
          }
          else if(eC==1){
            artistFee=element;
            artistFeeType="M";
            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Youtube", element, false);
          }
          else if(eC==2){
            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Facebook", element, false);
          }
          else if(eC==3){
            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Linkedin", element, false);
          }
          else if(eC==4){
            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Snapchat", element, false);
          }
          else if(eC==5){
            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Threads", element, false);
          }
          else if(eC==6){
            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "X", element, false);
          }
          else if(eC==7){
            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Whatsapp", element, false);
          }
          eC++;
        });
      }
    });
  }
  void loadNews(){
    database.ref('Database/News').onValue.listen((event) {
      String profilePicture = sBase.getFirstLineSync(path, "User", "Profile", "DownloadedImageFilePath");
      String userName = sBase.getFirstLineSync(path, "User", "Details", "Name");
      String profileTagLine = sBase.getFirstLineSync(path, "User", "Details", "TagLine");
      String campaignIDA=sBase.getFirstLineSync(path, "User", "Profile", "CampaignA"),
          campaignIDB=sBase.getFirstLineSync(path, "User", "Profile", "CampaignB"),
          campaignIDC=sBase.getFirstLineSync(path, "User", "Profile", "CampaignC"),
          campaignIDD=sBase.getFirstLineSync(path, "User", "Profile", "CampaignD");
      var sValue = event.snapshot.value;
      setState((){
        profileList.clear();
        iEList.clear();
        iEList.add(getObjectWithIndustryExplore("", "", "", "", "", "", "", "", ""));
        profileList.add(getObjectWithProfileList(userName, profilePicture, profileTagLine,
            campaignIDA, campaignIDB, campaignIDC, campaignIDD, "", "", "", "", "", "", "", "", "", ""));
        profileList.add(getObjectWithProfileList(userName, profilePicture, profileTagLine,
            campaignIDA, campaignIDB, campaignIDC, campaignIDD, "", "", "", "", "", "", "", "", "", ""));
      });
      if(sValue!=null){
        Map<dynamic, dynamic> mapUserData = sValue as Map;
        mapUserData.forEach((newsDate, fullData){
          if(newsDate == dateForNews()){
            loadNewsData(fullData, true);
          }
          loadNewsData(fullData, false);
        });
      }
      setState((){
        profileList.add(getObjectWithProfileList("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""));
      });
    });
  }
  void loadNewsData(var fullData, bool isForPersonal){
    Map<dynamic, dynamic> eachItemData = fullData as Map;
    eachItemData.forEach((randomID, newsData){
      String newsB = newsData.toString();
      int eC=0;
      String newsType="", artistNameA="", artistAPU="", artistNameB="",
          brandName="", brandILogo="", productName="", productURL="", newsTimeStamp="";
      sBase.delimitString(newsB, "~").forEach((element) {
        if(eC==0){
          newsType=element;
        }
        else if(eC==1){
          artistNameA=element;
        }
        else if(eC==2){
          artistAPU=element;
        }
        else if(eC==3){
          artistNameB=element;
        }
        else if(eC==4){
          brandName=element;
        }
        else if(eC==5){
          brandILogo=element;
        }
        else if(eC==6){
          productName=element;
        }
        else if(eC==7){
          productURL=element;
        }
        else if(eC==8){
          newsTimeStamp=element;
        }
        eC++;
      });
      if(isForPersonal){
        setState((){
          iEList.add(getObjectWithIndustryExplore(newsType, artistNameA, artistAPU, artistNameB, brandName,
              brandILogo, productName, productURL, newsTimeStamp));
        });
      }
      else{
        setState((){
          if(accountName==artistNameA || accountName==artistNameB){
            profileList.add(getObjectWithProfileList("", "", "", "", "", "", "", newsType, artistNameA, artistAPU, artistNameB, brandName,
                brandILogo, productName, productURL, newsTimeStamp, ""));
          }
        });
      }
    });
  }
  IndustryExplore getObjectWithIndustryExplore(String newsType, artistNameA, artistAPU, artistNameB,
      brandName, brandILogo, productName, productURL, newsTimeStamp) {
    return IndustryExplore(newsType, artistNameA, artistAPU, artistNameB,
        brandName, brandILogo, productName, productURL, newsTimeStamp);
  }
  ProfileList getObjectWithProfileList(String userName, profilePicture, profileTagLine,
      campaignIDA, campaignIDB, campaignIDC, campaignIDD, newsType, artistNameA, artistAPU, artistNameB, artistBPU, brandName,
      brandILogo, productName, productURL, newsTimeStamp){
    return ProfileList(userName, profilePicture, profileTagLine,
        campaignIDA, campaignIDB, campaignIDC, campaignIDD, newsType, artistNameA, artistAPU, artistNameB, artistBPU, brandName,
        brandILogo, productName, productURL, newsTimeStamp);
  }
  void loadSocialMedia()async{
    String socialInstaID = sBase.getFirstLineSync(path, "User", "WebURL", "Instagram");
    if(socialInstaID!="#"){
      setState((){
        isInstagramConnected=true;
      });
    }
    String socialFacebookID = sBase.getFirstLineSync(path, "User", "WebURL", "Facebook");
    if(socialFacebookID!="#"){
      setState((){
        isFacebookConnected=true;
      });
    }
    String socialYoutubeID = sBase.getFirstLineSync(path, "User", "WebURL", "Youtube");
    if(socialYoutubeID!="#"){
      setState((){
        isYoutubeConnected=true;
      });
    }
    String socialSnapchatID = sBase.getFirstLineSync(path, "User", "WebURL", "Snapchat");
    if(socialSnapchatID!="#"){
      setState((){
        isSnapchatConnected=true;
      });
    }
    String socialLinkedinID = sBase.getFirstLineSync(path, "User", "WebURL", "Linkedin");
    if(socialLinkedinID!="#"){
      setState((){
        isLinkedinConnected=true;
      });
    }
    String socialXID = sBase.getFirstLineSync(path, "User", "WebURL", "X");
    if(socialXID!="#"){
      setState((){
        isXConnected=true;
      });
    }
    String socialThreadsID = sBase.getFirstLineSync(path, "User", "WebURL", "Threads");
    if(socialThreadsID!="#"){
      setState((){
        isThreadsConnected=true;
      });
    }
    String socialWhatsappID = sBase.getFirstLineSync(path, "User", "WebURL", "Whatsapp");
    if(socialWhatsappID!="#"){
      setState((){
        isWhatsappConnected=true;
      });
    }
  }
  void getSocialMediaHandleToAdd(String socialMediaType){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35.0))),
        backgroundColor: darkBlue,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:18 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 16,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text("Enter $socialMediaType ProfileID", style: userSignOnOccupationTitleGreySLWN),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: () async {
                        String newSocialID="";
                        if(newUserController.text.isNotEmpty && newUserController.text.length>3){
                          newSocialID = newUserController.text.toString();
                          if(socialMediaType=="Instagram"){
                            sBase.writeFilesRealtime(path, "User", "NativeURL", "Instagram", "instagram://user?username=$newSocialID", false);
                            sBase.writeFilesRealtime(path, "User", "WebURL", "Instagram", "https://www.instagram.com/$newSocialID/", false);
                            database.ref('Database/Users/$userNoID/UserDetails/Instagram').set("https://www.instagram.com/$newSocialID/");
                            setState((){
                              isInstagramConnected=true;
                            });
                          }
                          else if(socialMediaType=="Facebook"){
                            sBase.writeFilesRealtime(path, "User", "NativeURL", "Facebook", "fb://profile/$newSocialID", false);
                            sBase.writeFilesRealtime(path, "User", "WebURL", "Facebook", "https://www.facebook.com/$newSocialID/", false);
                            database.ref('Database/Users/$userNoID/UserDetails/Facebook').set("https://www.facebook.com/$newSocialID/");
                            setState((){
                              isFacebookConnected=true;
                            });
                          }
                          else if(socialMediaType=="Youtube"){
                            sBase.writeFilesRealtime(path, "User", "NativeURL", "Youtube", "youtube.com://", false);
                            sBase.writeFilesRealtime(path, "User", "WebURL", "Youtube", "https://www.youtube.com/@$newSocialID/", false);
                            database.ref('Database/Users/$userNoID/UserDetails/Youtube').set("https://www.youtube.com/@$newSocialID/");
                            setState((){
                              isYoutubeConnected=true;
                            });
                          }
                          else if(socialMediaType=="Snapchat"){
                            sBase.writeFilesRealtime(path, "User", "NativeURL", "Snapchat", "snapchat://", false);
                            sBase.writeFilesRealtime(path, "User", "WebURL", "Snapchat", "https://www.snapchat.com", false);
                            database.ref('Database/Users/$userNoID/UserDetails/Snapchat').set("https://www.snapchat.com");
                            setState((){
                              isSnapchatConnected=true;
                            });
                          }
                          else if(socialMediaType=="Linkedin"){
                            sBase.writeFilesRealtime(path, "User", "NativeURL", "Linkedin", "linkedin://in/$newSocialID", false);
                            sBase.writeFilesRealtime(path, "User", "WebURL", "Linkedin", "https://www.linkedin.com/in/$newSocialID", false);
                            database.ref('Database/Users/$userNoID/UserDetails/Linkedin').set("https://www.linkedin.com/in/$newSocialID");
                            setState((){
                              isLinkedinConnected=true;
                            });
                          }
                          else if(socialMediaType=="X"){
                            sBase.writeFilesRealtime(path, "User", "NativeURL", "X", "x://user?screen_name=$newSocialID", false);
                            sBase.writeFilesRealtime(path, "User", "WebURL", "X", "https://x.com/$newSocialID", false);
                            database.ref('Database/Users/$userNoID/UserDetails/X').set("https://x.com/$newSocialID");
                            setState((){
                              isXConnected=true;
                            });
                          }
                          else if(socialMediaType=="Threads"){
                            sBase.writeFilesRealtime(path, "User", "NativeURL", "Threads", "threads://user?username=$newSocialID", false);
                            sBase.writeFilesRealtime(path, "User", "WebURL", "Threads", "https://threads.net/$newSocialID", false);
                            database.ref('Database/Users/$userNoID/UserDetails/Threads').set("https://threads.net/$newSocialID");
                            setState((){
                              isThreadsConnected=true;
                            });
                          }
                          else if(socialMediaType=="Whatsapp"){
                            String bW = "https://bloomfame.com";
                            sBase.writeFilesRealtime(path, "User", "NativeURL", "Whatsapp", "whatsapp://send?text=$bW", false);
                            sBase.writeFilesRealtime(path, "User", "WebURL", "Whatsapp", "whatsapp://send?text=$bW", false);
                            database.ref('Database/Users/$userNoID/UserDetails/Whatsapp').set("whatsapp://send?text=$bW");
                            setState((){
                              isWhatsappConnected=true;
                            });
                          }
                          setState(() {});
                          newUserController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            10, 0, 0, 0),
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: const BoxDecoration(
                            color: darkGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 22.0,
                                      semanticLabel: 'Friends',
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xffffffff),
                          Color(0xffffffff),
                        ],
                      )
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: TextField(
                        style: settingsHeadingTitlesS,
                        decoration: InputDecoration(
                          hintText: 'Please Enter New Input',
                          hintStyle: settingsHeadingTitlesS,
                        ),
                        controller: newUserController,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )
    );
  }
  void openAppFromBF(String appURL, String webURL)async{
    if (await canLaunchUrl(Uri.parse(appURL))) {
    await launchUrl(Uri.parse(appURL));
    }
    else if (await canLaunchUrl(Uri.parse(webURL))) {
    await launchUrl(Uri.parse(webURL));
    } else {
    }
  }
  void launchWebApp(String appURL)async{
    if (await canLaunchUrl(Uri.parse(appURL))) {
    await launchUrl(Uri.parse(appURL));
    }
  }
  /*void loadCampaignsDynamically(){
    /*String profilePicture = sBase.getFirstLineSync(path, "User", "Profile", "DownloadedImageFilePath");
    setState((){
      sF = File(profilePicture);
      wList.add(getObjectWithCampaignControl("", "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", ""));
      wList.add(getObjectWithCampaignControl("", "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", ""));
      wList.add(getObjectWithCampaignControl("", "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", "", "", ""));
      String campaignID = "c00001";
      String cLogo = sBase.getFirstLineSync(path, "Campaign", campaignID, "Logo");
      String bannerURL = sBase.getFirstLineSync(path, "Campaign", campaignID, "Banner");
      if(cLogo=="#"){
        downloadProfilePicture(campaignID, "$campaignID-logo.png", 3, true, false);
      }
      if(bannerURL=="#"){
        downloadProfilePicture(campaignID, "$campaignID-banner.png", 3, false, true);
      }
      String isAgreementAccepted = sBase.getFirstLineSync(path, 'Campaign', campaignID, "isAgreementAccepted");
      String campaignAgreementTimeStamp = sBase.getFirstLineSync(path, 'Campaign', campaignID, "campaignAgreementTimeStamp");
      clickedC = getObjectWithCampaignControl("Invite", "C00001", "A10051651651651", "Bloomfame NY", "C98746598415323", "Company X", "P0152",
          "B248", "M0152", "BRANDX Promotions - Pan India", "Transport", "brandx", "BRANDX", "150CC", cLogo, bannerURL,
          "Overcome roadblocks in your head", "Advertisement", "[INSTAGRAM-REEL]",
          "[INSTAGRAM-REEL]", "[INSTAGRAM-REEL]",
          "₹230,815/-", "5%", "https://www.google.com/website", "Bikers", "Power Cruiser", "40,000 - 1,50,000",
          "Passion for Bikes and Road Trips", "25-40", "TI400", "\$150", "\$150-\$800", "20%", "7-Day Post Completion",
          "Mandatory", "Manual-Advertisement", "4.0+", "-", "Instagram", "0", "0", "0", "0", "Pan-India",
          "40,00,000 Views", "0", "-", "0", "0", "12 July 2024", "-", "-", "11 July 2024", "18 July 2024", isAgreementAccepted, campaignAgreementTimeStamp, "NO", "NO", "N0", "N0", "N0", "NR", "NR", "N0",
          "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-");
      wList.add(clickedC);
      wList.add(getObjectWithCampaignControl("Invite", "C00001", "A10051651651651", "Bloomfame NY", "C98746598415323", "Company X", "P0152",
          "B248", "M0152", "BRANDX Promotions - Pan India", "Transport", "BRANDX", "BRANDX", "150CC", cLogo, bannerURL,
          "Overcome roadblocks in your head", "Advertisement", "[INSTAGRAM-REEL]",
          "[INSTAGRAM-REEL]", "[INSTAGRAM-REEL]",
          "₹230,815/-", "5%", "https://www.google.com/website", "Bikers", "Power Cruiser", "40,000 - 1,50,000",
          "Bikers, Road Trips, Mechanics, Sporty, Groovy, Stylish", "25-40", "TI400", "\$150", "\$150-\$800", "20%", "7-Day Post Completion",
          "Mandatory", "Manual-Advertisement", "4.0+", "-", "Instagram", "0", "0", "0", "0", "Pan-India",
          "40,00,000 Views", "0", "-", "0", "0", "12 July 2024", "-", "-", "11 July 2024", "18 July 2024", isAgreementAccepted, campaignAgreementTimeStamp, "NO", "NO", "N0", "N0", "N0", "NR", "NR", "N0",
          "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-"));
      /*wList.add(getObjectWithCampaignControl(campaignID, agencyID, agencyName, companyID, companyName, productGenericID,
          brandID, modelID, campaignName, productCategory, productPublicName, brandName, modelOfBrand, logoURL, bannerURL,
          campaignDescription, campaignCoreExpectation, sampleVideoURLA,
          sampleVideoURLB, sampleVideoURLC,
          productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
          targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferingByBloomfame,
          artistFeeOfferingRange, artistFeeNegotiation, paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating,
          campaignRatingByAgencyArtist, campaignPlatform, analysisViews, analysisLikes, analysisComments, analysisReach,
          analysisDemographics, analysisExpectedOutput, analysisExactOutcome, analysisSuccess, analysisClicks, analysisPurchasedProduct,
          analysisDeadline, analysisFinishedSubmission, eA, eB, eC, eD, eE, eF, eG, eH, eI, eJ, eK, eL,
          eM, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ));*/
    });*/
  }*/
  void loadCampaignList(){
    wList.clear();
    wList.add(getObjectWithCampaignControl("", "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", ""));
    wList.add(getObjectWithCampaignControl("", "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", ""));
    wList.add(getObjectWithCampaignControl("", "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "", "", ""));
    sBase.getAllFilesSubDirectory(path, "Campaign", "LiveEachItem").forEach((itemKeys) {
      //File: '/data/user/0/com.smatter.buildtrackr/cache/Data/ItemName/I1'
      String iK = itemKeys.toString();
      iK = iK.substring(iK.lastIndexOf("/")+1, iK.length-1);
      String eachItemUsageDetails = sBase.getFirstLineSync(path, "Campaign", "LiveEachItem", iK);
      int eC=0;
      int iC=0;
      String campaignStatus="", campaignID="", agencyID="", agencyName="", companyID="", companyName="", productGenericID="",
      brandID="", modelID="", campaignName="", productCategory="", productPublicName="",
      brandName="", modelOfBrand="", logoURL="", bannerURL="", campaignDescription="", campaignCoreExpectation="", sampleVideoURLA="", sampleVideoURLB="", sampleVideoURLC="",
      productPrice="", discountOffered="", productSalientFeatures="", targetCustomer="", targetCustomerCategory="", targetCustomerExpectedIncome="",
      targetCustomerExpectedBehaviour="", targetCustomerAgeCategory="", campaignDiscountCode="", artistFeeOfferingByBloomfame="", artistFeeOfferingRange="",
      artistFeeNegotiation="", paymentTerms="", proRateFee="", campaignOutcomeAnalysisProcess="", artistPerformanceRating="",
      campaignRatingByAgencyArtist="", campaignPlatform="", analysisViews="", analysisLikes="", analysisComments="", analysisReach="",
      analysisDemographics="", analysisExpectedOutput="", analysisExactOutcome="", analysisSuccess="", analysisClicks="",
      analysisPurchasedProduct="", analysisDeadline="", analysisFinishedSubmission="", rePost="", campaignStartDate="", campaignDeadLine="", isCampaignAccepted="",
      campaignAgreementTimeStamp="", isISubmitted="", isYSubmitted="", isFSubmitted="", isSSubmitted="", isLSubmitted="", isXSubmitted="", isTSubmitted="",
      isWSubmitted="", campaignApprovedByBloomfame="", eO="", eP="", eQ="", eR="", eS="", eT="", eU="", eV="", eW="", eX="", eY="", eZ="";
      String cLogoContent="#";
      sBase.delimitString(eachItemUsageDetails, "~").forEach((element) {
        if(eC==0){
          campaignStatus=element;
        }
        else if(eC==1){
          campaignID=element;
        }
        else if(eC==2){
          agencyID=element;
        }
        else if(eC==3){
          agencyName=element;
        }
        else if(eC==4){
          companyID=element;
        }
        else if(eC==5){
          companyName=element;
        }
        else if(eC==6){
          productGenericID=element;
        }
        else if(eC==7){
          brandID=element;
        }
        else if(eC==8){
          modelID=element;
        }
        else if(eC==9){
          campaignName=element;
        }
        else if(eC==10){
          productCategory=element;
        }
        else if(eC==11){
          productPublicName=element;
        }
        else if(eC==12){
          brandName=element;
        }
        else if(eC==13){
          modelOfBrand=element;
        }
        else if(eC==14){
          String cLogo = sBase.getFirstLineSync(path, "Campaign", campaignID, "Logo");
          int nC=0;
          if(sBase.getFirstLineSync(path, "Campaign", "Logo", element)=="#"){
            sBase.writeFilesRealtime(path, "Campaign", "Logo", element, "1", false);
          }
          else{
            nC = int.parse(sBase.getFirstLineSync(path, "Campaign", "Logo", element));
            nC++;
            sBase.writeFilesRealtime(path, "Campaign", "Logo", element, nC.toString(), false);
          }
          if(nC<7){
            if(cLogo=="#"){
              Future.delayed(const Duration(seconds: 3)).then((value) {
                downloadProfilePicture(campaignID, element, iC, true, false);
              });
            }
          }
          logoURL=cLogo;
          cLogoContent=logoURL;
        }
        else if(eC==15){
          int nC=0;
          String bannerURLC = sBase.getFirstLineSync(path, "Campaign", campaignID, "Banner");
          if(sBase.getFirstLineSync(path, "Campaign", "Banner", element)=="#"){
            sBase.writeFilesRealtime(path, "Campaign", "Banner", element, "1", false);
          }
          else{
            nC = int.parse(sBase.getFirstLineSync(path, "Campaign", "Banner", element));
            nC++;
            sBase.writeFilesRealtime(path, "Campaign", "Banner", element, nC.toString(), false);
          }
          if(nC<7){
            if(bannerURLC=="#"){
              Future.delayed(const Duration(seconds: 3)).then((value) {
                downloadProfilePicture(campaignID, element, iC, false, true);
              });
            }
          }
          bannerURL=bannerURLC;
        }
        else if(eC==16){
          campaignDescription=element;
        }
        else if(eC==17){
          campaignCoreExpectation=element;
        }
        else if(eC==18){
          sampleVideoURLA=element;
        }
        else if(eC==19){
          sampleVideoURLB=element;
        }
        else if(eC==20){
          sampleVideoURLC=element;
        }
        else if(eC==21){
          productPrice=element;
        }
        else if(eC==22){
          discountOffered=element;
        }
        else if(eC==23){
          productSalientFeatures=element;
        }
        else if(eC==24){
          targetCustomer=element;
        }
        else if(eC==25){
          targetCustomerCategory=element;
        }
        else if(eC==26){
          targetCustomerExpectedIncome=element;
        }
        else if(eC==27){
          targetCustomerExpectedBehaviour=element;
        }
        else if(eC==28){
          targetCustomerAgeCategory=element;
        }
        else if(eC==29){
          campaignDiscountCode=element;
        }
        else if(eC==30){
          artistFeeOfferingByBloomfame=element;
        }
        else if(eC==31){
          artistFeeOfferingRange=element;
        }
        else if(eC==32){
          artistFeeNegotiation=element;
        }
        else if(eC==33){
          paymentTerms=element;
        }
        else if(eC==34){
          proRateFee=element;
        }
        else if(eC==35){
          campaignOutcomeAnalysisProcess=element;
        }
        else if(eC==36){
          artistPerformanceRating=element;
        }
        else if(eC==37){
          campaignRatingByAgencyArtist=element;
        }
        else if(eC==38){
          campaignPlatform=element;
        }
        else if(eC==39){
          analysisViews=element;
        }
        else if(eC==40){
          analysisLikes=element;
        }
        else if(eC==41){
          analysisComments=element;
        }
        else if(eC==42){
          analysisReach=element;
        }
        else if(eC==43){
          analysisDemographics=element;
        }
        else if(eC==44){
          analysisExpectedOutput=element;
        }
        else if(eC==45){
          analysisExactOutcome=element;
        }
        else if(eC==46){
          analysisSuccess=element;
        }
        else if(eC==47){
          analysisClicks=element;
        }
        else if(eC==48){
          analysisPurchasedProduct=element;
        }
        else if(eC==49){
          analysisDeadline=element;
        }
        else if(eC==50){
          analysisFinishedSubmission=element;
        }
        else if(eC==51){
          rePost=element;
        }
        else if(eC==52){
          campaignStartDate=element;
        }
        else if(eC==53){
          campaignDeadLine=element;
        }
        else if(eC==54){
          isCampaignAccepted=element;
          if(isCampaignAccepted=="Accepted"){
            database.ref('Database/News/${dateForNews()}').push().set("Collab~$companyName~$cLogoContent~$accountName~#~#~#~#~${getDateTodayTimeStamp()}~");
          }
        }
        else if(eC==55){
          campaignAgreementTimeStamp = element;
        }
        else if(eC==56){
          isISubmitted=element;
        }
        else if(eC==57){
          isYSubmitted=element;
        }
        else if(eC==58){
          isFSubmitted=element;
        }
        else if(eC==59){
          isSSubmitted=element;
        }
        else if(eC==60){
          isLSubmitted=element;
        }
        else if(eC==61){
          isXSubmitted=element;
        }
        else if(eC==62){
          isTSubmitted=element;
        }
        else if(eC==63){
          isWSubmitted=element;
        }
        else if(eC==64){
          campaignApprovedByBloomfame=element;
        }
        else if(eC==65){
          eO=element;
        }
        else if(eC==66){
          eP=element;
        }
        else if(eC==67){
          eQ=element;
        }
        else if(eC==68){
          eR=element;
        }
        else if(eC==69){
          eS=element;
        }
        else if(eC==70){
          eT=element;
        }
        else if(eC==71){
          eU=element;
        }
        else if(eC==72){
          eV=element;
        }
        else if(eC==73){
          eW=element;
        }
        else if(eC==74){
          eX=element;
        }
        else if(eC==75){
          eY=element;
        }
        else if(eC==76){
          eZ=element;
        }
        eC++;
      });
      setState(() {
        wList.add(getObjectWithCampaignControl(campaignStatus,
            campaignID,
            agencyID,
            agencyName,
            companyID, companyName,
            productGenericID, brandID, modelID, campaignName, productCategory, productPublicName, brandName,
            modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA,
            sampleVideoURLB, sampleVideoURLC, productPrice, discountOffered, productSalientFeatures, targetCustomer,
            targetCustomerCategory, targetCustomerExpectedIncome, targetCustomerExpectedBehaviour, targetCustomerAgeCategory,
            campaignDiscountCode, artistFeeOfferingByBloomfame, artistFeeOfferingRange, artistFeeNegotiation,
            paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist,
            campaignPlatform, analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics,
            analysisExpectedOutput, analysisExactOutcome, analysisSuccess, analysisClicks, analysisPurchasedProduct,
            analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
            campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted,
            isTSubmitted, isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ));
        iC++;
      });
    });
  }
  void getArtistFeeInDollar(){
    if(!sBase.checkFileExistSync(path, "User", "Details", "FeesDollars")){
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(35.0))),
          backgroundColor: darkBlue,
          context: context,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal:18 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 16,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Text("Expected Fees Per Post (In USD)", style: userSignOnOccupationTitleGreySLWN),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: GestureDetector(
                        onTap: () async {
                          String eFees="";
                          if(newUserController.text.isNotEmpty){
                            eFees = newUserController.text.toString();
                            sBase.writeFilesRealtime(path, "User", "Details", "FeesDollars", eFees, false);
                            newUserController.clear();
                            setState(() {
                              artistFee = eFees;
                            });
                            //sBase.writeFilesRealtime(path, "User", "Manual", "Restart", "Scheduled", false);
                            sBase.writeFilesRealtime(path, "User", "Details", "FeesDollarsW", "Exists", false);
                            Navigator.pop(context);
                            RestartWidget.restartApp(context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              10, 0, 0, 0),
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: const BoxDecoration(
                              color: darkGreen,
                              shape: BoxShape.circle,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Center(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 22.0,
                                        semanticLabel: 'Friends',
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color(0xffffffff),
                            Color(0xffffffff),
                          ],
                        )
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: TextField(
                          style: settingsHeadingTitlesS,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Please Enter New Input',
                            hintStyle: settingsHeadingTitlesS,
                          ),
                          controller: newUserController,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
      );
    }
    else{
      setState((){
        artistFee = sBase.getFirstLineSync(path, "User", "Details", "FeesDollars");
        currentScreen="Work";
      });
    }
  }
  void updateNewLiveData(){
    database.ref('Database/Users/LastUpdated').onValue.listen((event) {
      var sValue = event.snapshot.value;
      if(sValue!=null){
        String lastUpdatedDate = sValue.toString();
        if(checkDateLocalIsOld(lastUpdatedDate, false)){
          DateTime today = DateTime.now();
          String dateStr = "${today.year}-${today.month}-${today.day}-${today.hour}-${today.minute}-${today.second}";
          sBase.writeFilesRealtime(path, "LiveData", "DateUpdated", "Latest", dateStr, false);
          updateDynamicDataNodes();
        }
      }
    });
  }
  void updateSpecificUserCampaign(){
    database.ref('Database/Users/$userNoID/Campaigns').onValue.listen((event) {
      var sValue = event.snapshot.value;
      if(sValue!=null){
        Map<dynamic, dynamic> mapUserData = sValue as Map;
        mapUserData.forEach((keyOData, valueOData){
          executeLiveCampaign(keyOData, valueOData, false, "none", true);
        });
        loadCampaignList();
      }
    });
  }
  void updateDynamicDataNodes(){
    database.ref('Database/Users/$userNoID').once().then((dValue)async{
      var sValue = dValue.snapshot.value;
      if(sValue!=null){
        Map<dynamic, dynamic> mapUserData = sValue as Map;
        mapUserData.forEach((keyOData, valueOData){
          if(keyOData=="ItemName"){
            Map<dynamic, dynamic> mapUserItemName = valueOData as Map;
            mapUserItemName.forEach((itemKey, itemValue){
              sBase.writeFilesRealtime(path, "Data", "ItemName", itemKey, itemValue, false);
            });
          }
        });
      }
    },onError: (error) {
    });
  }
  void updateCampaigns(bool isOnce, String taskId, bool isOverwrite)async{
    if(isOnce){
      path = await _localPath;
      userNoID=sBase.getFirstLineSync(path, "User", "Details", "NoID");
      accountName = sBase.getFirstLineSync(path, "User", "Details", "Name");
      myCategories = sBase.getFirstLineSync(path, "User", "Business", "Categories");
      database.ref('Database/Campaigns/${getLastMonthTimeStamp()}').once().then((event){
        var sValue = event.snapshot.value;
        if(sValue!=null){
          Map<dynamic, dynamic> mapUserData = sValue as Map;
          mapUserData.forEach((keyOData, valueOData){
            String rV=valueOData.toString();
            String tS = rV.substring(rV.indexOf("+")+1);
            rV=rV.substring(0, rV.indexOf("+"));
            if(rV.contains(myCategories)){
              executeLiveCampaign(keyOData, tS, true, taskId, isOverwrite);
            }
          });
        }
      });
      database.ref('Database/Campaigns/${getMonthTimeStamp()}').once().then((event){
        var sValue = event.snapshot.value;
        if(sValue!=null){
          Map<dynamic, dynamic> mapUserData = sValue as Map;
          mapUserData.forEach((keyOData, valueOData){
            String rV=valueOData.toString();
            String tS = rV.substring(rV.indexOf("+")+1);
            rV=rV.substring(0, rV.indexOf("+"));
            if(rV.contains(myCategories)){
              executeLiveCampaign(keyOData, tS, true, taskId, isOverwrite);
            }
          });
        }
      });
    }
    else{
      database.ref('Database/Campaigns/${getLastMonthTimeStamp()}').onValue.listen((event) {
        var sValue = event.snapshot.value;
        if(sValue!=null){
          Map<dynamic, dynamic> mapUserData = sValue as Map;
          mapUserData.forEach((keyOData, valueOData){
            String rV=valueOData.toString();
            String tS = rV.substring(rV.indexOf("+")+1);
            rV=rV.substring(0, rV.indexOf("+"));
            if(rV.contains(myCategories)){
              executeLiveCampaign(keyOData, tS, false, taskId, isOverwrite);
            }
          });
          loadCampaignList();
        }
      });
      database.ref('Database/Campaigns/${getMonthTimeStamp()}').onValue.listen((event) {
        var sValue = event.snapshot.value;
        if(sValue!=null){
          Map<dynamic, dynamic> mapUserData = sValue as Map;
          mapUserData.forEach((keyOData, valueOData){
            String rV=valueOData.toString();
            String tS = rV.substring(rV.indexOf("+")+1);
            rV=rV.substring(0, rV.indexOf("+"));
            if(rV.contains(myCategories)){
              executeLiveCampaign(keyOData, tS, false, taskId, isOverwrite);
            }
          });
          loadCampaignList();
        }
      });
    }
  }
  void executeLiveCampaign(String keyF, String valueF, bool isBackground, String taskId, bool isOverwrite){
    String sV = valueF.toString();
    int eC=0;
    String campaignID = "";
    sBase.delimitString(sV, "~").forEach((itemKeys) async {
      if(eC==1){
        campaignID=itemKeys;
      }
      if(eC==31){
        String localF = sBase.getFirstLineSync(path, "User", "Details", "FeesDollars");
        if(localF!="#"){
          try{
            String lowCap = itemKeys.substring(0, itemKeys.indexOf("-"));
            String highCap = itemKeys.substring(itemKeys.indexOf("-")+1);
            int artistMinimumFee = int.parse(localF);
            int feeOfferedMax = int.parse(highCap);
            int feeOffered = int.parse(lowCap.toString());
            if(artistMinimumFee>=feeOffered && artistMinimumFee<=feeOfferedMax){
              if(!sBase.checkFileExistSync(path, "Campaign", "LiveEachItem", keyF) || isOverwrite){
                sBase.writeFilesRealtime(path, "Campaign", "LiveEachItem", keyF, valueF, false);
                database.ref('Database/Users/$userNoID/Campaigns/${keyF.toString()}').set(valueF);
                /*if(isBackground){
                  /*showComingSoon("Campaign Request");
                  print("Campaign Request************************************");*/
                  final alarmSettings = AlarmSettings(
                    id: 42,
                    dateTime: DateTime.now(),
                    assetAudioPath: 'assets/graphics/invitation.mp3',
                    loopAudio: false,
                    vibrate: true,
                    volume: 0.1,
                    fadeDuration: 3.0,
                    notificationTitle: 'Bloomfame Invitation',
                    notificationBody: 'You have a new Campaign',
                    enableNotificationOnKill: true,
                  );
                  await Alarm.set(alarmSettings: alarmSettings);
                  BackgroundFetch.finish(taskId);
                }*/
              }
            }
            else{
              if(sBase.checkFileExistSync(path, "Campaign", "LiveEachItem", campaignID) || isOverwrite){
                sBase.deleteFile(path, "Campaign", "LiveEachItem", campaignID);
                loadCampaignList();
              }
            }
          }catch(exception){}
        }
      }
      eC++;
    });
  }
  void newDynamicNodeInput(String dNode){
    String siteOrItemName="", dateStr="";
    if(newUserController.text.isNotEmpty){
      siteOrItemName = newUserController.text.toString();
      String latestSiteItemCompanyID = sBase.getFirstLineSync(path, "LiveData", "${dNode}ID", "Latest");
      if(latestSiteItemCompanyID=="#"){
        if(dNode.contains("Site")){
          latestSiteItemCompanyID="S1";
        }
        else if(dNode.contains("Item")){
          latestSiteItemCompanyID="I1";
        }
        else if(dNode.contains("Company")){
          latestSiteItemCompanyID="C1";
        }
      }
      String nodeInitial = "";
      if(dNode=="Site"){
        nodeInitial="S";
      }
      else if(dNode=="Item"){
        nodeInitial="I";
      }
      else if(dNode=="Company"){
        nodeInitial="C";
      }
      database.ref('$companyCode/Database/DynamicAddOn/${dNode}Name/$latestSiteItemCompanyID').set(siteOrItemName);
      int newIDToBeUpdated = int.parse(latestSiteItemCompanyID.substring(1).toString());
      newIDToBeUpdated++;
      database.ref('$companyCode/Database/DynamicAddOn/Latest${dNode}ID').set("$nodeInitial$newIDToBeUpdated");
      sBase.writeFilesRealtime(path, "LiveData", "${dNode}ID", "Latest", "$nodeInitial$newIDToBeUpdated", false);
      DateTime today = DateTime.now();
      dateStr = "${today.year}-${today.month}-${today.day}-${today.hour}-${today.minute}-${today.second}";
      Future.delayed(const Duration(seconds: 1)).then((value) {
        database.ref("$companyCode/Database/LastUpdated").set(dateStr);
      });
      newUserController.clear();
      Navigator.pop(context);
    }
  }
  void onNewClickDyn(String dType){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35.0))),
        backgroundColor: darkBlue,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:18 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 16,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(dType, style: userSignOnOccupationTitleGreySLWN),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: () async {
                        newDynamicNodeInput(dType);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            10, 0, 0, 0),
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: const BoxDecoration(
                            color: darkGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 22.0,
                                      semanticLabel: 'Friends',
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xffffffff),
                          Color(0xffffffff),
                        ],
                      )
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: TextField(
                        style: settingsHeadingTitlesS,
                        decoration: InputDecoration(
                          hintText: 'Please Enter New Input',
                          hintStyle: settingsHeadingTitlesS,
                        ),
                        controller: newUserController,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )
    );
  }
  String replaceInitialisation(var tV){
    if(tV=='#'){
      return '';
    }
    else{
      return tV;
    }
  }
  String getDatabaseFilteredSt(String originalSt){
    String sTRet="";
    for(int i=0; i<originalSt.length; i++){
      var c = originalSt[i];
      if(c!="." && c!="\$" && c!="#" && c!="," && c!="[" && c!="]" && c!="/" && c!=":"){
        sTRet+=c.toString();
      }
    }
    return sTRet;
  }
  String getDatabaseFilteredTimeStamp(){
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-ddHH-mm-ss');
    return formatter.format(now);
  }
  int getWeekNumber(DateTime date){
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }
  void showCustomDialogLogOut(String headerMessage, String buttonMessage, String subTitle){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(1, (index) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateC) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: darkBlue,
                          spreadRadius: 10,
                          blurRadius: 13,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async{
                        if(headerMessage.contains('Delete')){
                          executeDeleteAccount();
                        }
                        else{
                          executeLogOut();
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.remove,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(headerMessage, style: userSignOnOccupationTitle, textAlign: TextAlign.center,),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Text(subTitle, style: headingTextTitlesG, textAlign: TextAlign.center,),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      height: 50,
                                      width: 220,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              darkBlue,
                                              darkBlue,
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.logout_rounded,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text(buttonMessage, style: headingTextTitlesW),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            ),
          ),
        );
      },
    );
  }
  void executeLogOut(){
    deleteAllFiles();
    transferToVerification();
  }
  void executeDeleteAccount(){
    transferToVerification();
  }
  String getRandomNumber(){
    var rndNumber="";
    var rnd= Random();
    for (var i = 0; i < 6; i++) {
      rndNumber = rndNumber + rnd.nextInt(9).toString();
    }
    return rndNumber;
  }
  void selectImage(String imageCategory, String tYear, String tMonth, String tDay){
    pickImageFromGallery(imageCategory, tYear, tMonth, tDay);
  }
  Future<firebase_storage.UploadTask> uploadProfilePicture(File file, String imageCategory,
      String tYear, String tMonth, String tDay)async {
    firebase_storage.UploadTask uploadTask;
    String contentType="", pictureType="";
    if(file.path.contains("jpg")) {
      contentType = "image/jpeg";
      pictureType = "jpg";
    }
    else if(file.path.contains("jpeg")){
      contentType = "image/jpeg";
      pictureType = "jpeg";
    }
    else if(file.path.contains("png")) {
      contentType = "image/png";
      pictureType = "png";
    }
    else if(file.path.contains("gif")) {
      contentType = "image/gif";
      pictureType = "gif";
    }
    else if(file.path.contains("webp")) {
      contentType = "image/webp";
      pictureType = "webp";
    }
    else if(file.path.contains("bmp")) {
      contentType = "image/bmp";
      pictureType = "bmp";
    }
    selectedFileType=pictureType;
    userPictureName = "$tYear-$tMonth-$tDay-$imageCategory.$pictureType";
    try{
      Directory dirA = Directory('$path/DownloadedUserPicturesLocal');
      dirA.createSync();
      final tDir = dirA.path;
      if(!File('$tDir/$userPictureName').existsSync()) {
        File('$tDir/$userPictureName').createSync();
      }
      await file.copy('$tDir/$userPictureName');
    }catch(exception){}
    firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instanceFor(app: defaultApp, bucket: "gs://buildtrackr-app.appspot.com").ref('UserPictures/$tYear/$tMonth/$tDay/$imageCategory/$userPictureName');
    final metadata = firebase_storage.SettableMetadata(contentType: contentType, customMetadata: {'picked-file-path': file.path});
    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(file, metadata);
    }
    return Future.value(uploadTask);
  }
  void pickImageFromGallery(String imageCategory, String tYear, String tMonth, String tDay)async{
    checkDeletePhotoDuplicate=0;
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 720,
      maxHeight: 720,
    );
    if(pickedFile!=null){
      await uploadProfilePicture(File(pickedFile.path), imageCategory, tYear, tMonth, tDay).then((value)async{
        Future.delayed(const Duration(seconds: 2)).then((value) {
          setState((){

          });
        });
      });
    }
  }
  void showItemDeleteOption(String iKey, iName, iSL, iType, iQ, iP){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(1, (index) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateC) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: darkBlue,
                          spreadRadius: 10,
                          blurRadius: 13,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async{
                        String itemID = iName.substring(0, iName.indexOf("-"));
                        String siteID = iSL.substring(0, iSL.indexOf("-"));
                        updateLiveItemStatusDirectly(iName, iSL, itemID, siteID, iType, iQ, iP, true);
                        database.ref('$companyCode/Database/DateWiseEntries/$itemID/$iKey').remove();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBarA);
                        updateLastTimeServer();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.remove,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Delete Item", style: userSignOnOccupationTitle, textAlign: TextAlign.center,),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Text("Items once deleted cannot be recovered", style: headingTextTitlesG, textAlign: TextAlign.center,),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      height: 50,
                                      width: 220,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              darkBlue,
                                              darkBlue,
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Delete", style: headingTextTitlesW),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            ),
          ),
        );
      },
    );
  }
  void showOrderDeleteOption(String orderI){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(1, (index) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateC) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: darkBlue,
                          spreadRadius: 10,
                          blurRadius: 13,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async{
                        database.ref('$companyCode/Database/OrderIDS/${getDatabaseCorrectedName(orderI)}').remove();
                        updateLastTimeServer();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBarA);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.remove,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Delete Order", style: userSignOnOccupationTitle, textAlign: TextAlign.center,),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Text("Items once deleted cannot be recovered", style: headingTextTitlesG, textAlign: TextAlign.center,),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      height: 50,
                                      width: 220,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              darkBlue,
                                              darkBlue,
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Delete", style: headingTextTitlesW),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            ),
          ),
        );
      },
    );
  }
  Future<void> downloadProfilePicture(String fileStorageFBasePath, String fileFinalName,
      int sIndex, bool isLogoURL, bool isBannerURL)async{
    if(fileFinalName!="."){
      String downloadPathNode='DownloadedPictures';
      String cBucket='gs://bloomfame-ny.appspot.com';
      final ref = FirebaseStorage.instanceFor(app: defaultApp,
          bucket: cBucket).ref('Campaigns/$fileStorageFBasePath/$fileFinalName');
      try {
        Directory dir = Directory('$path/$downloadPathNode');
        dir.createSync(recursive: true);
        final tDir = dir.path;
        if(!File('$tDir/$fileFinalName').existsSync()) {
          File('$tDir/$fileFinalName').createSync();
        }
        final file = File('$tDir/$fileFinalName');
        if(file.existsSync()){
          final downloadTask = ref.writeToFile(file);
          downloadTask.snapshotEvents.listen((taskSnapshot) {
            switch (taskSnapshot.state) {
              case TaskState.running:
                break;
              case TaskState.paused:
                break;
              case TaskState.success:
                if(isLogoURL) {
                  sBase.writeFilesRealtime(path, 'Campaign', fileStorageFBasePath, "Logo", file.path, false);
                  setState(() {
                    wList[sIndex].logoURL = file.path;
                  });
                }
                if(isBannerURL){
                  sBase.writeFilesRealtime(path, 'Campaign', fileStorageFBasePath, "Banner", file.path, false);
                  setState(() {
                    wList[sIndex].bannerURL = file.path;
                  });
                }
                break;
              case TaskState.canceled:
                break;
              case TaskState.error:
                break;
            }
          });
        }
      } on FirebaseException catch (e) {}
    }
  }
  Future<void> _launchUrl(Uri videoURL)async {
    if (!await launchUrl(videoURL)) {
      throw Exception('Could not launch $videoURL');
    }
  }
  void acceptAgreement(BuildContext context, String campaignID, int sIndex){
    String timeAccepted = getDateTodayTimeStamp();
    sBase.writeFilesRealtime(path, 'Campaign', campaignID, "isAgreementAccepted", "Yes", false);
    sBase.writeFilesRealtime(path, 'Campaign', campaignID, "campaignAgreementTimeStamp", timeAccepted, false);
    setState(() {
      wList[sIndex].isCampaignAccepted = "Yes";
      wList[sIndex].campaignAgreementTimeStamp = timeAccepted;
    });
    updateCampaignLocally(campaignID, 54, "Yes");
    updateCampaignLocally(campaignID, 55, timeAccepted);
    updateCampaignLocally(campaignID, 64, "Requested");
    updateCampaignGlobally(campaignID);
    database.ref('Database/PlatformCampaignApproval/Campaigns/$campaignID/$userNoID').set(timeAccepted);
    Navigator.pop(context);
  }
  void updateCampaignLocally(String campaignID, int index, String updateContent){
    String eachItemUsageDetails = sBase.getFirstLineSync(path, "Campaign", "LiveEachItem", campaignID);
    int eC=0;
    String toUpdate="";
    sBase.delimitString(eachItemUsageDetails, "~").forEach((element) {
      if(eC==index){
        toUpdate+="$updateContent~";
      }
      else{
        toUpdate+="$element~";
      }
      eC++;
    });
    sBase.writeFilesRealtime(path, "Campaign", "LiveEachItem", campaignID, toUpdate, false);
  }
  void updateCampaignGlobally(String campaignID){
    String eachItemUsageDetails = sBase.getFirstLineSync(path, "Campaign", "LiveEachItem", campaignID);
    database.ref('Database/Users/$userNoID/Campaigns/$campaignID').set(eachItemUsageDetails);
  }
  void showComingSoon(String headerMessage){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(1, (index) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateC) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: darkBlue,
                          spreadRadius: 10,
                          blurRadius: 13,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async{

                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.remove,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(headerMessage, style: userSignOnOccupationTitle, textAlign: TextAlign.center,),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            ),
          ),
        );
      },
    );
  }
  void showNoNotifications(String headerMessage){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(1, (index) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateC) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: darkBlue,
                          spreadRadius: 10,
                          blurRadius: 13,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async{

                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.remove,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(headerMessage, style: userSignOnOccupationTitle, textAlign: TextAlign.center,),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            ),
          ),
        );
      },
    );
  }
  void signAgreement(BuildContext context, int sIndex, String campaignStatus, String campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
      brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
      productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
      targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferingByBloomfame, artistFeeOfferingRange, artistFeeNegotiation,
      paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
      analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
      analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
      campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
      isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.8,
              maxChildSize: 1.0,
              builder: (_, controller) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setStateC) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 0, 15, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                                  child: Text("Partnership Agreement", style: headingTextTitlesLSGB),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: Text("This General Partnership Agreement (\"Agreement\") is made and entered into as of "
                                      "${getDateTodayTimeStamp()}, by and between the following parties: \n\n"
                                      "$companyName (\"Brand\")\n"
                                      "$agencyName (\"Agency\")\n"
                                      "$accountName (\"Artist\")\n\n"
                                      "Whereas, the Brand, Agency, and Artist wish to enter into a partnership to execute $campaignName (the \"Campaign\") to be launched on "
                                      "$campaignStartDate and completed by $campaignDeadLine.\n\n"

                                      "Now, therefore, in consideration of the mutual covenants and promises herein contained, the parties hereto agree as follows:\n\n"

                                      "1. Purpose\n\n"
                                      "The purpose of this partnership is to collaborate on the planning, creation, and execution of $campaignName, which aims to promote $productPublicName.\n\n"

                                      "2. Responsibilities\n\n"
                                      "$companyName:\n\n"
                                      "Supply product/service information, branding guidelines, and any relevant promotional materials.\n"
                                      "Approve creative concepts and final deliverables in a timely manner.\n\n"
                                      "$agencyName:\n\n"

                                      "Develop the overall campaign strategy, including target audience analysis and media planning.\n"
                                      "Manage project timelines and ensure all activities are completed by the deadline $campaignDeadLine.\n"
                                      "Coordinate communication between all parties involved and oversee the implementation of the campaign.\n\n"
                                      "$accountName:\n\n"

                                      "Create original content (e.g., artwork, videos, music) as agreed upon in the campaign plan.\n"
                                      "Ensure that all content aligns with $companyName’s guidelines and campaign objectives.\n"
                                      "Deliver all creative materials by the agreed-upon deadlines.\n\n"
                                      "3. Compensation\n\n"
                                      "$companyName will compensate $agencyName and $accountName as per the agreed terms in separate contractual agreements.\n"
                                      "All financial arrangements will be handled promptly and transparently to ensure smooth execution of the Campaign.\n\n"
                                      "4. Intellectual Property\n\n"
                                      "All creative content produced by $accountName will be the intellectual property of $companyName, unless otherwise specified in writing.\n"
                                      "$accountName will retain the right to include the work in their portfolio, with proper attribution to $companyName.\n\n"
                                      "5. Confidentiality\n\n"
                                      "All parties agree to keep confidential all information pertaining to the Campaign and each other's business operations.\n"
                                      "Confidential information shall not be disclosed to any third party without prior written consent from the concerned party.\n\n"
                                      "6. Timeline\n\n"
                                      "The Campaign will be launched on $campaignStartDate.\n"
                                      "All deliverables must be completed and submitted by $campaignDeadLine.\n\n"
                                      "7. Termination\n\n"
                                      "This Agreement may be terminated by mutual consent of all parties or by any party with a written "
                                      "notice of 7 days.\n"
                                      "Upon termination, all parties will fulfill their outstanding obligations up to the date of termination.\n\n"
                                      "8. Dispute Resolution\n\n"
                                      "In the event of a dispute arising from this Agreement, all parties agree to first seek resolution through mediation.\n"
                                      "If mediation fails, the dispute shall be settled through arbitration in accordance with the "
                                      "rules of New York, United States of America.\n\n"
                                      "9. Governing Law\n\n"
                                      "This Agreement shall be governed by and construed in accordance with the laws of New York, United States of America.\n\n"
                                      , style: headingTextTitlesDBG),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                              child: Container(
                                                height: 50,
                                                width: 250,
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.topRight,
                                                      colors: [
                                                        darkRed,
                                                        darkRed,
                                                      ],
                                                    )
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                  child: Center(
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(
                                                            Icons.cancel_rounded,
                                                            color: Colors.white,
                                                            size: 22.0,
                                                            semanticLabel: 'Friends',
                                                          ),
                                                          const SizedBox(
                                                            width: 7,
                                                          ),
                                                          Text("Cancel", style: headingTextTitlesW),
                                                        ],
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: InkWell(
                                            onTap: (){
                                              acceptAgreement(context, campaignID, sIndex);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                              child: Container(
                                                height: 50,
                                                width: 250,
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.topRight,
                                                      colors: [
                                                        darkGreen,
                                                        darkGreen,
                                                      ],
                                                    )
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                  child: Center(
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(
                                                            Icons.check_circle_rounded,
                                                            color: Colors.white,
                                                            size: 22.0,
                                                            semanticLabel: 'Friends',
                                                          ),
                                                          const SizedBox(
                                                            width: 7,
                                                          ),
                                                          Text("Accept", style: headingTextTitlesW),
                                                        ],
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        );
      },
    );
  }
  void platformSpecificSubmission(String selectedPlatform, BuildContext context, int sIndex, double screenHeight, double screenWidth, String campaignStatus, String campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
      brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
      productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
      targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferingByBloomfame, artistFeeOfferingRange, artistFeeNegotiation,
      paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
      analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
      analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
      campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
      isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ) {
    if(selectedPlatform=="Instagram" || selectedPlatform=="Facebook" || selectedPlatform=="Threads" || selectedPlatform=="X"){
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.001),
              child: DraggableScrollableSheet(
                initialChildSize: 0.8,
                minChildSize: 0.8,
                maxChildSize: 1.0,
                builder: (_, controller) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setStateC) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 15, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                                    child: Text("$selectedPlatform Campaign Submission", style: headingTextTitlesLSGB),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: phoneBoxGrey,
                                            borderRadius: BorderRadius.all(Radius.circular(8.0)
                                            ),
                                          ),
                                          width: double.infinity,
                                          height: 55,
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 8,
                                                child: SizedBox(
                                                    height: 50,
                                                    child: TextField(
                                                      controller: iURL,
                                                      keyboardType: TextInputType.name,
                                                      onChanged: (text){
                                                      },
                                                      decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          hintText: "$selectedPlatform Post/Reel URL",
                                                          labelStyle: TextStyle(fontSize: 24)),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tViews,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Total Views",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tClicks,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Total Clicks",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tImpressions,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Impressions",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tLikes,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Likes",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tComments,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Comments",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tShares,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Shares",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tSaves,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Saves",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tTopLocationA,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Top Location 1",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tTopLocationB,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Top Location 2",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tTopLocationC,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Top Location 3",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tTopLocationD,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Top Location 4",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tTopLocationE,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Top Location 5",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tAge1317,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Age 13-17 (%)",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tAge1824,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Age 18-24 (%)",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tAge2534,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Age 25-34 (%)",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tAge3544,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Age 35-44 (%)",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tAge4554,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Age 45-54 (%)",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tAge5564,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Age 55-64 (%)",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tAge65,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Age 65+ (%)",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tMale,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Male (%)",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tFemale,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Female (%)",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: tFollows,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Follows",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                          child: InkWell(
                                            onTap: (){
                                              if(selectedPlatform=="Instagram"){
                                                String iDataToSubmit = "${iURL.text}~${tViews.text}~${tClicks.text}~${tImpressions.text}~"
                                                    "${tLikes.text}~${tComments.text}~${tShares.text}~${tSaves.text}~${tTopLocationA.text}~"
                                                    "${tTopLocationB.text}~${tTopLocationC.text}~${tTopLocationD.text}~"
                                                    "${tTopLocationE.text}~${tAge1317.text}~${tAge1824.text}~${tAge2534.text}~"
                                                    "${tAge3544.text}~${tAge4554.text}~${tAge5564.text}~${tAge65.text}~"
                                                    "${tMale.text}~${tFemale.text}~${tFollows.text}~";
                                                sBase.writeFilesRealtime(path, "Users", "CampaignSubmission", "${campaignID}I", iDataToSubmit, false);
                                                database.ref('Database/Users/$userNoID/CampaignSubmission/${campaignID}I/$userNoID').set(iDataToSubmit);
                                                database.ref('Database/Agency/$agencyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}I/$userNoID').set(iDataToSubmit);
                                                database.ref('Database/Company/$companyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}I/$userNoID').set(iDataToSubmit);
                                                updateCampaignLocally(campaignID, 56, "YES");
                                                setState((){
                                                  isISubmitted="YES";
                                                });
                                              }
                                              else if(selectedPlatform=="Facebook"){
                                                  String fDataToSubmit = "${iURL.text}~${tViews.text}~${tClicks.text}~${tImpressions.text}~"
                                                      "${tLikes.text}~${tComments.text}~${tShares.text}~${tSaves.text}~${tTopLocationA.text}~"
                                                      "${tTopLocationB.text}~${tTopLocationC.text}~${tTopLocationD.text}~"
                                                      "${tTopLocationE.text}~${tAge1317.text}~${tAge1824.text}~${tAge2534.text}~"
                                                      "${tAge3544.text}~${tAge4554.text}~${tAge5564.text}~${tAge65.text}~"
                                                      "${tMale.text}~${tFemale.text}~${tFollows.text}~";
                                                  sBase.writeFilesRealtime(path, "Users", "CampaignSubmission", "${campaignID}F", fDataToSubmit, false);
                                                  database.ref('Database/Users/$userNoID/CampaignSubmission/${campaignID}F/$userNoID').set(fDataToSubmit);
                                                  database.ref('Database/Agency/$agencyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}F/$userNoID').set(fDataToSubmit);
                                                  database.ref('Database/Company/$companyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}F/$userNoID').set(fDataToSubmit);
                                                  updateCampaignLocally(campaignID, 58, "YES");
                                                  setState((){
                                                    isFSubmitted="YES";
                                                  });
                                              }
                                              else if(selectedPlatform=="Threads"){
                                                String tDataToSubmit = "${iURL.text}~${tViews.text}~${tClicks.text}~${tImpressions.text}~"
                                                    "${tLikes.text}~${tComments.text}~${tShares.text}~${tSaves.text}~${tTopLocationA.text}~"
                                                    "${tTopLocationB.text}~${tTopLocationC.text}~${tTopLocationD.text}~"
                                                    "${tTopLocationE.text}~${tAge1317.text}~${tAge1824.text}~${tAge2534.text}~"
                                                    "${tAge3544.text}~${tAge4554.text}~${tAge5564.text}~${tAge65.text}~"
                                                    "${tMale.text}~${tFemale.text}~${tFollows.text}~";
                                                sBase.writeFilesRealtime(path, "Users", "CampaignSubmission", "${campaignID}T", tDataToSubmit, false);
                                                database.ref('Database/Users/$userNoID/CampaignSubmission/${campaignID}T/$userNoID').set(tDataToSubmit);
                                                database.ref('Database/Agency/$agencyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}T/$userNoID').set(tDataToSubmit);
                                                database.ref('Database/Company/$companyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}T/$userNoID').set(tDataToSubmit);
                                                updateCampaignLocally(campaignID, 62, "YES");
                                                setState((){
                                                  isTSubmitted="YES";
                                                });
                                              }
                                              else if(selectedPlatform=="X"){
                                                String xDataToSubmit = "${iURL.text}~${tViews.text}~${tClicks.text}~${tImpressions.text}~"
                                                    "${tLikes.text}~${tComments.text}~${tShares.text}~${tSaves.text}~${tTopLocationA.text}~"
                                                    "${tTopLocationB.text}~${tTopLocationC.text}~${tTopLocationD.text}~"
                                                    "${tTopLocationE.text}~${tAge1317.text}~${tAge1824.text}~${tAge2534.text}~"
                                                    "${tAge3544.text}~${tAge4554.text}~${tAge5564.text}~${tAge65.text}~"
                                                    "${tMale.text}~${tFemale.text}~${tFollows.text}~";
                                                sBase.writeFilesRealtime(path, "Users", "CampaignSubmission", "${campaignID}X", xDataToSubmit, false);
                                                database.ref('Database/Users/$userNoID/CampaignSubmission/${campaignID}X/$userNoID').set(xDataToSubmit);
                                                database.ref('Database/Agency/$agencyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}X/$userNoID').set(xDataToSubmit);
                                                database.ref('Database/Company/$companyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}X/$userNoID').set(xDataToSubmit);
                                                updateCampaignLocally(campaignID, 61, "YES");
                                                setState((){
                                                  isXSubmitted="YES";
                                                });
                                              }
                                              iURL.text=""; tViews.text=""; tClicks.text=""; tImpressions.text;
                                              tLikes.text=""; tComments.text=""; tShares.text=""; tSaves.text=""; tTopLocationA.text;
                                              tTopLocationB.text=""; tTopLocationC.text=""; tTopLocationD.text;
                                              tTopLocationE.text=""; tAge1317.text=""; tAge1824.text=""; tAge2534.text;
                                              tAge3544.text=""; tAge4554.text=""; tAge5564.text=""; tAge65.text;
                                              tMale.text=""; tFemale.text=""; tFollows.text;
                                              updateCampaignGlobally(campaignID);
                                              loadCampaignList();
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                              child: Container(
                                                height: 50,
                                                width: 200,
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.topRight,
                                                      colors: [
                                                        Color(0xff000026),
                                                        Color(0xff000026),
                                                      ],
                                                    )
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                  child: Center(
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(
                                                            Icons.check_circle_rounded,
                                                            color: Colors.white,
                                                            size: 22.0,
                                                            semanticLabel: 'Friends',
                                                          ),
                                                          const SizedBox(
                                                            width: 7,
                                                          ),
                                                          Text("Submit", style: headingTextTitlesW),
                                                        ],
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(0, 300, 0, 200),
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                selectedPlatform=="Instagram"?"assets/graphics/iggrey.png":selectedPlatform=="Facebook"?"assets/graphics/facebookgrey.jpg":selectedPlatform=="Threads"?"assets/graphics/threadsgrey.png":selectedPlatform=="X"?"assets/graphics/x.png":"assets/graphics/iggrey.png",
                                                width: screenWidth/3,
                                                height: screenWidth/3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          );
        },
      );
    }
    else if(selectedPlatform=="Youtube"){
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.001),
              child: DraggableScrollableSheet(
                initialChildSize: 0.8,
                minChildSize: 0.8,
                maxChildSize: 1.0,
                builder: (_, controller) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setStateC) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 15, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                                    child: Text("$selectedPlatform Campaign Submission", style: headingTextTitlesLSGB),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: phoneBoxGrey,
                                            borderRadius: BorderRadius.all(Radius.circular(8.0)
                                            ),
                                          ),
                                          width: double.infinity,
                                          height: 55,
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 8,
                                                child: SizedBox(
                                                    height: 50,
                                                    child: TextField(
                                                      controller: yURL,
                                                      keyboardType: TextInputType.name,
                                                      onChanged: (text){
                                                      },
                                                      decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          hintText: "$selectedPlatform Post/Reel URL",
                                                          labelStyle: TextStyle(fontSize: 24)),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                      child: InkWell(
                                        onTap: (){
                                          showComingSoon("Coming Soon");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                          child: Container(
                                            height: 50,
                                            width: 250,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.topRight,
                                                  colors: [
                                                    Color(0xff000026),
                                                    Color(0xff000026),
                                                  ],
                                                )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                              child: Center(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(
                                                        Icons.check_circle_rounded,
                                                        color: Colors.white,
                                                        size: 22.0,
                                                        semanticLabel: 'Friends',
                                                      ),
                                                      const SizedBox(
                                                        width: 7,
                                                      ),
                                                      Text("Auto-Generate Analysis", style: headingTextTitlesW),
                                                    ],
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),


                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yViews,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Total Views",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yWatchTime,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Total WatchTime",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yRImpressions,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Impressions",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yRImpressionsCTR,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Impressions CTR",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yRViews,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Total Reach (Views)",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yRUniqueViewers,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Unique Viewers",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yEViewDuration,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Avg View Duration",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yARetention,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Audience Retention",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Demographics - Country", style: TextStyle(fontSize: 24)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Country, Views, WatchTime (Hours), Avg View Duration(HH:mm)", style: headingTextTitlesLSGB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("India, 9716, 321.2, 1:59", style: headingTextTitlesLSGB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDCTA,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Country A Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDCTB,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Country B Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDCTC,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Country C Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDCYD,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Country D Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDCYE,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Country E Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: const Text(""),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Demographics - City", style: TextStyle(fontSize: 24)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("City, Views, WatchTime [(Hours), Avg View Duration(HH:mm)", style: headingTextTitlesLSGB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Mumbai, 650, 121.2, 1:09", style: headingTextTitlesLSGB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDCityA,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "City A Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDCityB,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "City B Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDCityC,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "City C Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDCityD,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "City D Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDCityE,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "City E Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: const Text(""),
                                        ),
                                      ],
                                    ),
                                  ),


                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Demographics - View Source", style: TextStyle(fontSize: 24)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Source, Views, WatchTime [(Hours), Avg View Duration(HH:mm)", style: headingTextTitlesLSGB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Youtube Search, 544, 13.6, 1:30", style: headingTextTitlesLSGB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDSourceA,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Youtube Search Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDSourceB,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Browse Search Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDSourceC,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "External Source Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDSourceD,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Direct Source Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDSourceE,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Playlists E Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: const Text(""),
                                        ),
                                      ],
                                    ),
                                  ),


                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Demographics - Age", style: TextStyle(fontSize: 24)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Age Range, Views, WatchTime [(Hours), Avg View Duration(HH:mm)", style: headingTextTitlesLSGB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("13-17, 544, 13.6, 1:30", style: headingTextTitlesLSGB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDAge1317,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "13-17 Age Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDAge1824,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "18-24 Age Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDAge2534,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "25-34 Age Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDAge4554,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "35-44 Age Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDAge4554,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "45-54 Age Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDAge5564,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "55-64 Age Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDAge65,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "65+ Age Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: const Text(""),
                                        ),
                                      ],
                                    ),
                                  ),


                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Demographics - Gender", style: TextStyle(fontSize: 24)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Gender, Views, WatchTime [(Hours), Avg View Duration(HH:mm)", style: headingTextTitlesLSGB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Male, 544, 13.6, 1:30", style: headingTextTitlesLSGB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDGenderM,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Male View Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDGenderF,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Female View Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Demographics - Devices", style: TextStyle(fontSize: 24)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("DeviceName, Views, WatchTime [(Hours), Avg View Duration(HH:mm)", style: headingTextTitlesLSGB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text("Computer, 544, 13.6, 1:30", style: headingTextTitlesLSGB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDDeviceMobile,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Mobile View Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDDeviceComputer,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Computer View Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDDeviceTablet,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Tablet View Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: yDDeviceTV,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "TV View Stats",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),


                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                          child: InkWell(
                                            onTap: (){
                                              String yDataToSubmit = "${yURL.text}~${yViews.text}~${yWatchTime.text}~${ySubscribers.text}~${yRImpressions.text}~"
                                                  "${yRImpressionsCTR.text}~${yRViews.text}~${yRUniqueViewers.text}~${yEViewDuration.text}~"
                                                  "${yARetention.text}~${yAPercentageViewed.text}~${yDCTA.text}~${yDCTB.text}~${yDCTC.text}~"
                                                  "${yDCYD.text}~${yDCYE.text}~${yDCityA.text}~${yDCityB.text}~${yDCityC.text}~${yDCityD.text}~"
                                                  "${yDCityE.text}~${yDSourceA.text}~${yDSourceB.text}~${yDSourceC.text}~${yDSourceD.text}~"
                                                  "${yDSourceE.text}~${yDAge1317.text}~${yDAge1824.text}~${yDAge2534.text}~${yDAge3544.text}~"
                                                  "${yDAge4554.text}~${yDAge5564.text}~${yDAge65.text}~${yDGenderM.text}~${yDGenderF.text}~"
                                                  "${yDGenderO.text}~${yDDeviceMobile.text}~${yDDeviceComputer.text}~${yDDeviceTablet.text}~"
                                                  "${yDDeviceTV.text}~";
                                              sBase.writeFilesRealtime(path, "Users", "CampaignSubmission", "${campaignID}Y", yDataToSubmit, false);
                                              database.ref('Database/Users/$userNoID/CampaignSubmission/${campaignID}Y/$userNoID').set(yDataToSubmit);
                                              database.ref('Database/Agency/$agencyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}Y/$userNoID').set(yDataToSubmit);
                                              database.ref('Database/Company/$companyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}Y/$userNoID').set(yDataToSubmit);
                                              updateCampaignLocally(campaignID, 57, "YES");
                                              updateCampaignGlobally(campaignID);
                                              loadCampaignList();
                                              setState((){
                                                isYSubmitted="YES";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                              child: Container(
                                                height: 50,
                                                width: 200,
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.topRight,
                                                      colors: [
                                                        Color(0xff000026),
                                                        Color(0xff000026),
                                                      ],
                                                    )
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                  child: Center(
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(
                                                            Icons.check_circle_rounded,
                                                            color: Colors.white,
                                                            size: 22.0,
                                                            semanticLabel: 'Friends',
                                                          ),
                                                          const SizedBox(
                                                            width: 7,
                                                          ),
                                                          Text("Submit", style: headingTextTitlesW),
                                                        ],
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(0, 300, 0, 200),
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                selectedPlatform=="Youtube"?"assets/graphics/youtubegrey.png":"assets/graphics/iggrey.png",
                                                width: screenWidth/3,
                                                height: screenWidth/3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          );
        },
      );
    }
    else if(selectedPlatform=="Snapchat"){
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.001),
              child: DraggableScrollableSheet(
                initialChildSize: 0.8,
                minChildSize: 0.8,
                maxChildSize: 1.0,
                builder: (_, controller) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setStateC) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 15, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                                    child: Text("$selectedPlatform Campaign Submission", style: headingTextTitlesLSGB),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: phoneBoxGrey,
                                            borderRadius: BorderRadius.all(Radius.circular(8.0)
                                            ),
                                          ),
                                          width: double.infinity,
                                          height: 55,
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 8,
                                                child: SizedBox(
                                                    height: 50,
                                                    child: TextField(
                                                      controller: snapchatURL,
                                                      keyboardType: TextInputType.name,
                                                      onChanged: (text){
                                                      },
                                                      decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          hintText: "$selectedPlatform Post/Reel URL",
                                                          labelStyle: TextStyle(fontSize: 24)),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: sViews,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Total Views",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: sClicks,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Total Clicks",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: sImpressions,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Impressions",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: sLikes,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Likes",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                          child: InkWell(
                                            onTap: (){
                                              String sDataToSubmit = "${snapchatURL.text}~${sViews.text}~${sClicks.text}~${sImpressions.text}~"
                                              "${sLikes.text}~";
                                              sBase.writeFilesRealtime(path, "Users", "CampaignSubmission", "${campaignID}S", sDataToSubmit, false);
                                              database.ref('Database/Users/$userNoID/CampaignSubmission/${campaignID}S/$userNoID').set(sDataToSubmit);
                                              database.ref('Database/Agency/$agencyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}S/$userNoID').set(sDataToSubmit);
                                              database.ref('Database/Company/$companyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}S/$userNoID').set(sDataToSubmit);
                                              updateCampaignLocally(campaignID, 59, "YES");
                                              updateCampaignGlobally(campaignID);
                                              setState((){
                                                isSSubmitted="YES";
                                              });
                                              loadCampaignList();
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                              child: Container(
                                                height: 50,
                                                width: 200,
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.topRight,
                                                      colors: [
                                                        Color(0xff000026),
                                                        Color(0xff000026),
                                                      ],
                                                    )
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                  child: Center(
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(
                                                            Icons.check_circle_rounded,
                                                            color: Colors.white,
                                                            size: 22.0,
                                                            semanticLabel: 'Friends',
                                                          ),
                                                          const SizedBox(
                                                            width: 7,
                                                          ),
                                                          Text("Submit", style: headingTextTitlesW),
                                                        ],
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(0, 300, 0, 200),
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                selectedPlatform=="Snapchat"?"assets/graphics/snapchatgrey.jpg":"assets/graphics/iggrey.png",
                                                width: screenWidth/3,
                                                height: screenWidth/3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          );
        },
      );
    }
    else if(selectedPlatform=="LinkedIn"){
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.001),
              child: DraggableScrollableSheet(
                initialChildSize: 0.8,
                minChildSize: 0.8,
                maxChildSize: 1.0,
                builder: (_, controller) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setStateC) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 15, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                                    child: Text("$selectedPlatform Campaign Submission", style: headingTextTitlesLSGB),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: phoneBoxGrey,
                                            borderRadius: BorderRadius.all(Radius.circular(8.0)
                                            ),
                                          ),
                                          width: double.infinity,
                                          height: 55,
                                          child: Row(
                                            children: <Widget>[
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 8,
                                                child: SizedBox(
                                                    height: 50,
                                                    child: TextField(
                                                      controller: iURL,
                                                      keyboardType: TextInputType.name,
                                                      onChanged: (text){
                                                      },
                                                      decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          hintText: "$selectedPlatform Post/Reel URL",
                                                          labelStyle: TextStyle(fontSize: 24)),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lContentViews,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Total Views",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lContentReactions,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Content Reactions",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lContentComments,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Comment Count",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lContentReposts,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Content Reposts",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lContentImpressionsOrganic,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Impressions Organic",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lContentImpressionsSponsored,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Impressions Sponsored",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lVisitorPageViewCount,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Visitor Page View",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lContentUniqueVisitors,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Unique Visitors",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lContentCustomButtonClick,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Custom Button Click",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lVisitorJobFunction,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Visitor Job Function",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lVisitorCompanySize,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Visitor Company Size",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lVisitorLocation,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Visitor Location",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: lVisitorSeniority,
                                                              keyboardType: TextInputType.name,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Visitor Seniority",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 5,
                                          child: Text(""),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                          child: InkWell(
                                            onTap: (){
                                              String lDataToSubmit = "${lContentViews.text}~${lContentReactions.text}~${lContentComments.text}~"
                                                  "${lContentReposts.text}~${lContentImpressionsOrganic.text}~"
                                                  "${lContentImpressionsSponsored.text}~${lVisitorPageViewCount.text}~"
                                                  "${lContentUniqueVisitors.text}~${lContentCustomButtonClick.text}~"
                                                  "${lVisitorJobFunction.text}~${lVisitorCompanySize.text}~${lVisitorIndustry.text}~"
                                                  "${lVisitorLocation.text}~${lVisitorSeniority.text}";
                                              sBase.writeFilesRealtime(path, "Users", "CampaignSubmission", "${campaignID}L", lDataToSubmit, false);
                                              database.ref('Database/Users/$userNoID/CampaignSubmission/${campaignID}L/$userNoID').set(lDataToSubmit);
                                              database.ref('Database/Agency/$agencyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}L/$userNoID').set(lDataToSubmit);
                                              database.ref('Database/Company/$companyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}L/$userNoID').set(lDataToSubmit);
                                              updateCampaignLocally(campaignID, 60, "YES");
                                              updateCampaignGlobally(campaignID);
                                              loadCampaignList();
                                              setState((){
                                                isLSubmitted="YES";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                              child: Container(
                                                height: 50,
                                                width: 200,
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.topRight,
                                                      colors: [
                                                        Color(0xff000026),
                                                        Color(0xff000026),
                                                      ],
                                                    )
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                  child: Center(
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(
                                                            Icons.check_circle_rounded,
                                                            color: Colors.white,
                                                            size: 22.0,
                                                            semanticLabel: 'Friends',
                                                          ),
                                                          const SizedBox(
                                                            width: 7,
                                                          ),
                                                          Text("Submit", style: headingTextTitlesW),
                                                        ],
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(0, 300, 0, 200),
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                selectedPlatform=="LinkedIn"?"assets/graphics/linkedingrey.png":"assets/graphics/linkedingrey.png",
                                                width: screenWidth/3,
                                                height: screenWidth/3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          );
        },
      );
    }
    else if(selectedPlatform=="Whatsapp"){
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.001),
              child: DraggableScrollableSheet(
                initialChildSize: 0.8,
                minChildSize: 0.8,
                maxChildSize: 1.0,
                builder: (_, controller) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setStateC) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 15, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                                    child: Text("$selectedPlatform Campaign Submission", style: headingTextTitlesLSGB),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: phoneBoxGrey,
                                            borderRadius: BorderRadius.all(Radius.circular(8.0)
                                            ),
                                          ),
                                          width: double.infinity,
                                          height: 55,
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 8,
                                                child: SizedBox(
                                                    height: 50,
                                                    child: TextField(
                                                      controller: snapchatURL,
                                                      keyboardType: TextInputType.name,
                                                      onChanged: (text){
                                                      },
                                                      decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          hintText: "$selectedPlatform Post/Reel URL",
                                                          labelStyle: TextStyle(fontSize: 24)),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: sViews,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Total Views",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: sClicks,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Total Clicks",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: sImpressions,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Impressions",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: phoneBoxGrey,
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 55,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: sLikes,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Likes",
                                                                  labelStyle: TextStyle(fontSize: 24)),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                          child: InkWell(
                                            onTap: (){
                                              String wDataToSubmit = "${whatsappURL.text}~${wViews.text}~${wClicks.text}~"
                                                  "${wImpressions.text}~${wLikes.text}~";
                                              sBase.writeFilesRealtime(path, "Users", "CampaignSubmission", "${campaignID}W", wDataToSubmit, false);
                                              database.ref('Database/Users/$userNoID/CampaignSubmission/${campaignID}W/$userNoID').set(wDataToSubmit);
                                              database.ref('Database/Agency/$agencyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}W/$userNoID').set(wDataToSubmit);
                                              database.ref('Database/Company/$companyID/CampaignSubmission/${getMonthTimeStamp()}/${campaignID}W/$userNoID').set(wDataToSubmit);
                                              updateCampaignLocally(campaignID, 63, "YES");
                                              updateCampaignGlobally(campaignID);
                                              loadCampaignList();
                                              setState((){
                                                isWSubmitted="YES";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                              child: Container(
                                                height: 50,
                                                width: 200,
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.topRight,
                                                      colors: [
                                                        Color(0xff000026),
                                                        Color(0xff000026),
                                                      ],
                                                    )
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                  child: Center(
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(
                                                            Icons.check_circle_rounded,
                                                            color: Colors.white,
                                                            size: 22.0,
                                                            semanticLabel: 'Friends',
                                                          ),
                                                          const SizedBox(
                                                            width: 7,
                                                          ),
                                                          Text("Submit", style: headingTextTitlesW),
                                                        ],
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(0, 300, 0, 200),
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                selectedPlatform=="Whatsapp"?"assets/graphics/whatsappgrey.png":"assets/graphics/iggrey.png",
                                                width: screenWidth/3,
                                                height: screenWidth/3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          );
        },
      );
    }
  }
  void requestAIFee(BuildContext context, double screenHeight, double screenWidth){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.8,
              maxChildSize: 1.0,
              builder: (_, controller) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setStateC) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 15, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                                  child: Text("Artist Fee - AI Generative", style: headingTextTitlesLSGB),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVInstagram,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Instagram Followers",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVYoutube,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Youtube Subscribers",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVFacebook,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Facebook Followers",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVSnapchat,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Snapchat Followers",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVLinkedin,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "LinkedIn Followers",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVX,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "X Followers",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVThreads,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Threads Followers",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVWhatsapp,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Whatsapp Reach",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                        child: InkWell(
                                          onTap: (){
                                            String valuationRequestData = "${aVInstagram.text}~${aVYoutube.text}~${aVFacebook.text}~"
                                                "${aVSnapchat.text}~${aVLinkedin.text}~${aVX.text}~${aVThreads.text}~${aVWhatsapp.text}~";
                                            database.ref('Database/ArtistFee/$userNoID').push().set(valuationRequestData);
                                            sBase.writeFilesRealtime(path, "User", "ArtistFee", "ValuationAI", valuationRequestData, false);
                                            sBase.writeFilesRealtime(path, "User", "ArtistFee", "Instagram", aVInstagram.text.toString(), false);
                                            sBase.writeFilesRealtime(path, "User", "ArtistFee", "Youtube", aVYoutube.text.toString(), false);
                                            sBase.writeFilesRealtime(path, "User", "ArtistFee", "Facebook", aVFacebook.text.toString(), false);
                                            sBase.writeFilesRealtime(path, "User", "ArtistFee", "Snapchat", aVSnapchat.text.toString(), false);
                                            sBase.writeFilesRealtime(path, "User", "ArtistFee", "Linkedin", aVLinkedin.text.toString(), false);
                                            sBase.writeFilesRealtime(path, "User", "ArtistFee", "X", aVX.text.toString(), false);
                                            sBase.writeFilesRealtime(path, "User", "ArtistFee", "Threads", aVThreads.text.toString(), false);
                                            sBase.writeFilesRealtime(path, "User", "ArtistFee", "Whatsapp", aVWhatsapp.text.toString(), false);
                                            Navigator.pop(context);
                                            aVInstagram.text="";
                                            aVFacebook.text="";
                                            aVSnapchat.text="";
                                            aVLinkedin.text="";
                                            aVYoutube.text="";
                                            aVX.text="";
                                            aVThreads.text="";
                                            aVWhatsapp.text="";
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                            child: Container(
                                              height: 50,
                                              width: 250,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [
                                                      Color(0xff000026),
                                                      Color(0xff000026),
                                                    ],
                                                  )
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                child: Center(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(
                                                          Icons.check_circle_rounded,
                                                          color: Colors.white,
                                                          size: 22.0,
                                                          semanticLabel: 'Friends',
                                                        ),
                                                        const SizedBox(
                                                          width: 7,
                                                        ),
                                                        Text("Send Request", style: headingTextTitlesW),
                                                      ],
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(0, 300, 0, 200),
                                          child: Opacity(
                                            opacity: 0.2,
                                            child: Image.asset(
                                              "assets/graphics/bloomfamelogo.png",
                                              width: screenWidth/3,
                                              height: screenWidth/3,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        );
      },
    );
  }
  void setArtistFee(BuildContext context, double screenHeight, double screenWidth){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.8,
              maxChildSize: 1.0,
              builder: (_, controller) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setStateC) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 15, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                                  child: Text("Artist Fee - Manual", style: headingTextTitlesLSGB),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVInstagram,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Instagram Per Post Fees",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVYoutube,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Youtube Per Post Fees",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVFacebook,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Facebook Per Post Fees",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVSnapchat,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Snapchat Per Post Fees",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVLinkedin,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "LinkedIn Per Post Fees",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVX,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "X Per Post Fees",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVThreads,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Threads Per Post Fees",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: phoneBoxGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 55,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: aVWhatsapp,
                                                    keyboardType: TextInputType.name,
                                                    onChanged: (text){
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Whatsapp Per Share Fees",
                                                        labelStyle: TextStyle(fontSize: 24)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                        child: InkWell(
                                          onTap: (){
                                            String artistFeeL = "${aVInstagram.text}~${aVYoutube.text}~${aVFacebook.text}~"
                                                "${aVSnapchat.text}~${aVLinkedin.text}~${aVX.text}~${aVThreads.text}~${aVWhatsapp.text}~";
                                            var snackBar = const SnackBar(content: Text('Manual Fee Set'));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Instagram", aVInstagram.text, false);
                                            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Youtube", aVYoutube.text, false);
                                            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Facebook", aVFacebook.text, false);
                                            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Linkedin", aVLinkedin.text, false);
                                            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Snapchat", aVSnapchat.text, false);
                                            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Threads", aVThreads.text, false);
                                            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "X", aVX.text, false);
                                            sBase.writeFilesRealtime(path, "Users", "ArtistFee", "Whatsapp", aVWhatsapp.text, false);
                                            setState((){
                                              artistFee=aVYoutube.text;
                                              artistFeeType="M";
                                            });
                                            sBase.writeFilesRealtime(path, "User", "Details", "ArtistFeeType", "M", false);
                                            database.ref('Database/Users/$userNoID/ArtistFee').set(artistFeeL);
                                            Navigator.pop(context);
                                            aVInstagram.text="";
                                            aVFacebook.text="";
                                            aVSnapchat.text="";
                                            aVLinkedin.text="";
                                            aVYoutube.text="";
                                            aVX.text="";
                                            aVThreads.text="";
                                            aVWhatsapp.text="";
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                            child: Container(
                                              height: 50,
                                              width: 200,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [
                                                      Color(0xff000026),
                                                      Color(0xff000026),
                                                    ],
                                                  )
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                child: Center(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(
                                                          Icons.check_circle_rounded,
                                                          color: Colors.white,
                                                          size: 22.0,
                                                          semanticLabel: 'Friends',
                                                        ),
                                                        const SizedBox(
                                                          width: 7,
                                                        ),
                                                        Text("Submit", style: headingTextTitlesW),
                                                      ],
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(0, 300, 0, 200),
                                          child: Opacity(
                                            opacity: 0.2,
                                            child: Image.asset(
                                              "assets/graphics/bloomfamelogo.png",
                                              width: screenWidth/3,
                                              height: screenWidth/3,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        );
      },
    );
  }
  void selectPlatformSubmission(BuildContext context, int sIndex, double screenHeight, double screenWidth, String campaignStatus, String campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
      brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
      productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
      targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame,
      artistFeeOfferingRange, artistFeeNegotiation,
      paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
      analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
      analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
      campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
      isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          color: const Color.fromRGBO(0, 0, 0, 0.001),
          child: DraggableScrollableSheet(
            initialChildSize: 0.33,
            minChildSize: 0.33,
            maxChildSize: 1.0,
            builder: (_, controller) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setStateC) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 0, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                                child: Text("Select Submission Platform", style: headingTextTitlesLSGB),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(7, 25, 7, 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 25,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Column(
                                            children: [
                                              isISubmitted=="NR"?Opacity(
                                                opacity: 0.5,
                                                child: Image.asset(
                                                  "assets/graphics/iggrey.png",
                                                  width: screenWidth/6.9,
                                                  height: screenWidth/6.9,
                                                  fit: BoxFit.cover,
                                                ),
                                              ):
                                              Opacity(
                                                opacity: isISubmitted=="YES"?0.1:1.0,
                                                child: GestureDetector(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                    platformSpecificSubmission("Instagram", context, sIndex, screenHeight, screenWidth,
                                                        campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
                                                        brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
                                                        productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
                                                        targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame,
                                                        artistFeeOfferingRange, artistFeeNegotiation,
                                                        paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
                                                        analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
                                                        analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
                                                        campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
                                                        isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ);
                                                  },
                                                  child: Image.asset(
                                                    "assets/graphics/ig.png",
                                                    width: screenWidth/6.9,
                                                    height: screenWidth/6.9,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                    Expanded(
                                        flex: 25,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Column(
                                            children: [
                                              isYSubmitted=="NR"?Opacity(
                                                opacity: 0.5,
                                                child: Image.asset(
                                                  "assets/graphics/youtubegrey.png",
                                                  width: screenWidth/6.9,
                                                  height: screenWidth/6.9,
                                                  fit: BoxFit.cover,
                                                ),):
                                              Opacity(
                                                opacity: isYSubmitted=="YES"?0.1:1.0,
                                                child: GestureDetector(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                    platformSpecificSubmission("Youtube", context, sIndex, screenHeight, screenWidth,
                                                        campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
                                                        brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
                                                        productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
                                                        targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame,
                                                        artistFeeOfferingRange, artistFeeNegotiation,
                                                        paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
                                                        analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
                                                        analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
                                                        campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
                                                        isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ);
                                                  },
                                                  child: Image.asset(
                                                    "assets/graphics/youtube.png",
                                                    width: screenWidth/6.9,
                                                    height: screenWidth/6.9,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                    Expanded(
                                        flex: 25,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Column(
                                            children: [
                                              isFSubmitted=="NR"?Opacity(
                                                opacity: 0.5,
                                                child: Image.asset(
                                                  "assets/graphics/facebookgrey.jpg",
                                                  width: screenWidth/6.9,
                                                  height: screenWidth/6.9,
                                                  fit: BoxFit.cover,
                                                ),):
                                              Opacity(
                                                opacity: isFSubmitted=="YES"?0.1:1.0,
                                                child: GestureDetector(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                    platformSpecificSubmission("Facebook", context, sIndex, screenHeight, screenWidth,
                                                        campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
                                                        brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
                                                        productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
                                                        targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame,
                                                        artistFeeOfferingRange, artistFeeNegotiation,
                                                        paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
                                                        analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
                                                        analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
                                                        campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
                                                        isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ);
                                                  },
                                                  child: Image.asset(
                                                    "assets/graphics/facebook.png",
                                                    width: screenWidth/6.9,
                                                    height: screenWidth/6.9,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                    Expanded(
                                        flex: 25,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Column(
                                            children: [
                                              isSSubmitted=="NR"?Opacity(
                                                opacity: 0.5,
                                                child: Image.asset(
                                                  "assets/graphics/snapchatgrey.jpg",
                                                  width: screenWidth/6.9,
                                                  height: screenWidth/6.9,
                                                  fit: BoxFit.cover,
                                                ),):
                                              Opacity(
                                                opacity: isSSubmitted=="YES"?0.1:1.0,
                                                child: GestureDetector(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                    platformSpecificSubmission("Snapchat", context, sIndex, screenHeight, screenWidth,
                                                        campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
                                                        brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
                                                        productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
                                                        targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame,
                                                        artistFeeOfferingRange, artistFeeNegotiation,
                                                        paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
                                                        analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
                                                        analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
                                                        campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
                                                        isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ);
                                                  },
                                                  child: Image.asset(
                                                    "assets/graphics/snapchat.png",
                                                    width: screenWidth/6.9,
                                                    height: screenWidth/6.9,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(7, 25, 7, 0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 25,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Column(
                                            children: [
                                              isLSubmitted=="NR"?Opacity(
                                                opacity: 0.5,
                                                child: Image.asset(
                                                  "assets/graphics/linkedingrey.png",
                                                  width: screenWidth/6.9,
                                                  height: screenWidth/6.9,
                                                  fit: BoxFit.cover,
                                                ),):
                                              Opacity(
                                                opacity: isLSubmitted=="YES"?0.1:1.0,
                                                child: GestureDetector(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                    platformSpecificSubmission("LinkedIn", context, sIndex, screenHeight, screenWidth,
                                                        campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
                                                        brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
                                                        productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
                                                        targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame,
                                                        artistFeeOfferingRange, artistFeeNegotiation,
                                                        paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
                                                        analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
                                                        analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
                                                        campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
                                                        isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ);
                                                  },
                                                  child: Image.asset(
                                                    "assets/graphics/linkedin.png",
                                                    width: screenWidth/6.9,
                                                    height: screenWidth/6.9,
                                                    fit: BoxFit.contain,
                                                  ),
                                                )
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                    Expanded(
                                        flex: 25,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Column(
                                            children: [
                                              isXSubmitted=="NR"?Opacity(
                                                opacity: 0.5,
                                                child: Image.asset(
                                                  "assets/graphics/xgrey.png",
                                                  width: screenWidth/6.9,
                                                  height: screenWidth/6.9,
                                                  fit: BoxFit.cover,
                                                ),):
                                              Opacity(
                                                opacity: isXSubmitted=="YES"?0.1:1.0,
                                                child: GestureDetector(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                    platformSpecificSubmission("X", context, sIndex, screenHeight, screenWidth,
                                                        campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
                                                        brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
                                                        productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
                                                        targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame,
                                                        artistFeeOfferingRange, artistFeeNegotiation,
                                                        paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
                                                        analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
                                                        analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
                                                        campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
                                                        isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ);
                                                  },
                                                  child: Image.asset(
                                                    "assets/graphics/x.png",
                                                    width: screenWidth/6.9,
                                                    height: screenWidth/6.9,
                                                    fit: BoxFit.contain,
                                                  ),
                                                )
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                    Expanded(
                                        flex: 25,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Column(
                                            children: [
                                              isTSubmitted=="NR"?Opacity(
                                                opacity: 0.3,
                                                child: Image.asset(
                                                  "assets/graphics/threadsgrey.png",
                                                  width: screenWidth/6.9,
                                                  height: screenWidth/6.9,
                                                  fit: BoxFit.cover,
                                                ),):
                                              Opacity(
                                                opacity: isTSubmitted=="YES"?0.1:1.0,
                                                child: GestureDetector(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                    platformSpecificSubmission("Threads", context, sIndex, screenHeight, screenWidth,
                                                        campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
                                                        brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
                                                        productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
                                                        targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame,
                                                        artistFeeOfferingRange, artistFeeNegotiation,
                                                        paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
                                                        analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
                                                        analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
                                                        campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
                                                        isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ);
                                                  },
                                                  child: Image.asset(
                                                    "assets/graphics/threads.jpg",
                                                    width: screenWidth/6.9,
                                                    height: screenWidth/6.9,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                    Expanded(
                                        flex: 25,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Column(
                                            children: [
                                              isWSubmitted=="NR"?Opacity(
                                                opacity: 0.5,
                                                child: Image.asset(
                                                  "assets/graphics/whatsappgrey.png",
                                                  width: screenWidth/6.9,
                                                  height: screenWidth/6.9,
                                                  fit: BoxFit.cover,
                                                ),):
                                              Opacity(
                                                opacity: isWSubmitted=="YES"?0.1:1.0,
                                                child: GestureDetector(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                    platformSpecificSubmission("Whatsapp", context, sIndex, screenHeight, screenWidth,
                                                        campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
                                                        brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
                                                        productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
                                                        targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame,
                                                        artistFeeOfferingRange, artistFeeNegotiation,
                                                        paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
                                                        analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
                                                        analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
                                                        campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
                                                        isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ);
                                                  },
                                                  child: Image.asset(
                                                    "assets/graphics/whatsapp.png",
                                                    width: screenWidth/6.9,
                                                    height: screenWidth/6.9,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
        );
      },
    );
  }
  void sendQuickApprovalRequest(String campaignID){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(1, (index) =>
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setStateC) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff000000),
                              spreadRadius: 10,
                              blurRadius: 13,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.remove,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Approval Time: < 48 hours", style: headingTextTitlesBGAAS,),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: InkWell(
                                  onTap: ()async{
                                    database.ref('Database/PlatformCampaignApprovalExpedite/Campaigns/'
                                        '$campaignID$userNoID').set("VPN");
                                    var snackBar = SnackBar(content: Text("Request to Expedite Approval Sent"));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                    child: Container(
                                      height: 50,
                                      width: 220,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Color(0xff000026),
                                              Color(0xff000026),
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.timer_rounded,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Expedite Approval", style: headingTextTitlesW),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
            ),
          ),
        );
      },
    );
  }
  String getTimeDifference(newsTimeStamp){
    String finalD="-";
    if(newsTimeStamp!="#"){
      DateTime startTime = DateTime(2024, 02, 20, 10, 30, 0);
      int eC=0;
      int yy=0, mm=0, dd=0, hh=0, m=0, s=0;
      sBase.delimitString(newsTimeStamp, "-").forEach((element) {
        if(eC==0){
          yy=int.parse(element);
        }
        else if(eC==1){
          mm=int.parse(element);
        }
        else if(eC==2){
          dd=int.parse(element);
        }
        else if(eC==3){
          hh=int.parse(element);
        }
        else if(eC==4){
          m=int.parse(element);
        }
        else if(eC==5){
          s=int.parse(element);
        }
        eC++;
      });
      startTime = DateTime(yy, mm, dd, hh, m, s);
      var currentTime = DateTime.now();
      var diff;
      diff = currentTime.difference(startTime).inSeconds;
      finalD = diff.toString()+"s";
      if(diff>120){
        diff = currentTime.difference(startTime).inMinutes;
        finalD = diff.toString()+"m";
      }
      if(diff>60){
        diff = currentTime.difference(startTime).inHours;
        finalD = diff.toString()+"h";
      }
      if(diff>24){
        diff = currentTime.difference(startTime).inDays;
        finalD = diff.toString()+"m";
      }
    }
    return finalD;
  }
  Widget showCampaignControlList(double screenHeight, double screenWidth, List<CampaignControl> gI){
    String campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
        brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
        productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
        targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame,
        artistFeeOfferingRange, artistFeeNegotiation,
        paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
        analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
        analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
        campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
        isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true, removeLeft: true,
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, position) {
          campaignStatus = gI[position].campaignStatus;
          campaignID=gI[position].campaignID;
          agencyID=gI[position].agencyID;
          agencyName=gI[position].agencyName;
          companyID=gI[position].companyID;
          companyName=gI[position].companyName;
          productGenericID=gI[position].productGenericID;
          brandID=gI[position].brandID;
          modelID=gI[position].modelID;
          campaignName=gI[position].campaignName;
          productCategory=gI[position].productCategory;
          productPublicName=gI[position].productPublicName;
          brandName=gI[position].brandName;
          modelOfBrand=gI[position].modelOfBrand;
          logoURL=gI[position].logoURL;
          bannerURL=gI[position].bannerURL;
          campaignDescription=gI[position].campaignDescription;
          campaignCoreExpectation=gI[position].campaignCoreExpectation;
          sampleVideoURLA=gI[position].sampleVideoURLA;
          sampleVideoURLB=gI[position].sampleVideoURLB;
          sampleVideoURLC=gI[position].sampleVideoURLC;
          productPrice=gI[position].productPrice;
          discountOffered=gI[position].discountOffered;
          productSalientFeatures=gI[position].productSalientFeatures;
          targetCustomer=gI[position].targetCustomer;
          targetCustomerCategory=gI[position].targetCustomerCategory;
          targetCustomerExpectedIncome=gI[position].targetCustomerExpectedIncome;
          targetCustomerExpectedBehaviour=gI[position].targetCustomerExpectedBehaviour;
          targetCustomerAgeCategory=gI[position].targetCustomerAgeCategory;
          campaignDiscountCode=gI[position].campaignDiscountCode;
          artistFeeOfferByBloomfame = gI[position].artistFeeOfferingByBloomfame;
          artistFeeOfferingRange=gI[position].artistFeeOfferingRange;
          artistFeeNegotiation=gI[position].artistFeeNegotiation;
          paymentTerms=gI[position].paymentTerms;
          proRateFee=gI[position].proRateFee;
          campaignOutcomeAnalysisProcess=gI[position].campaignOutcomeAnalysisProcess;
          artistPerformanceRating=gI[position].artistPerformanceRating;
          campaignRatingByAgencyArtist=gI[position].campaignRatingByAgencyArtist;
          campaignPlatform=gI[position].campaignPlatform;
          analysisViews=gI[position].analysisViews;
          analysisLikes=gI[position].analysisLikes;
          analysisComments=gI[position].analysisComments;
          analysisReach=gI[position].analysisReach;
          analysisDemographics=gI[position].analysisDemographics;
          analysisExpectedOutput=gI[position].analysisExpectedOutput;
          analysisExactOutcome=gI[position].analysisExactOutcome;
          analysisSuccess=gI[position].analysisSuccess;
          analysisClicks=gI[position].analysisClicks;
          analysisPurchasedProduct=gI[position].analysisPurchasedProduct;
          analysisDeadline=gI[position].analysisDeadline;
          analysisFinishedSubmission=gI[position].analysisFinishedSubmission;
          rePost=gI[position].rePost; campaignStartDate=gI[position].campaignStartDate;
          campaignDeadLine=gI[position].campaignDeadLine;
          isCampaignAccepted=gI[position].isCampaignAccepted;
          campaignAgreementTimeStamp=gI[position].campaignAgreementTimeStamp;
          isISubmitted=gI[position].isISubmitted;
          isYSubmitted=gI[position].isYSubmitted; isFSubmitted=gI[position].isFSubmitted;
          isSSubmitted=gI[position].isSSubmitted; isLSubmitted=gI[position].isLSubmitted; isXSubmitted=gI[position].isXSubmitted;
          isTSubmitted=gI[position].isTSubmitted;
          isWSubmitted=gI[position].isWSubmitted; campaignApprovedByBloomfame=gI[position].campaignApprovedByBloomfame; eO=gI[position].eO; eP=gI[position].eP; eQ=gI[position].eQ;
          eR=gI[position].eR;
          eS=gI[position].eS; eT=gI[position].eT; eU=gI[position].eU;
          eV=gI[position].eV; eW=gI[position].eW; eX=gI[position].eX;
          eY=gI[position].eY; eZ=gI[position].eZ;
          File bannerF=File("");
          File logoF=File("");
          if(logoURL!="#"){
            logoF = File(logoURL);
          }
          if(bannerURL!="#"){
            bannerF = File(bannerURL);
          }
          if(position==0){
            return Padding(
              padding: const EdgeInsets.fromLTRB(7, 13, 7, 0),
              child: Row(
                children: [
                  Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GestureDetector(
                          onTap:(){
                            String nativeURL = sBase.getFirstLineSync(path, "User", "NativeURL", "Instagram");
                            String webURL = sBase.getFirstLineSync(path, "User", "WebURL", "Instagram");
                            !isInstagramConnected?getSocialMediaHandleToAdd("Instagram"):openAppFromBF(nativeURL, webURL);
                          },
                          child: Column(
                            children: [
                              !isInstagramConnected?Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  "assets/graphics/iggrey.png",
                                  width: screenWidth/6.9,
                                  height: screenWidth/6.9,
                                  fit: BoxFit.cover,
                                ),):
                              Image.asset(
                                "assets/graphics/ig.png",
                                width: screenWidth/6.5,
                                height: screenWidth/6.5,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              isInstagramConnected?const Text(""):
                              Opacity(
                                opacity: 0.5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline,
                                      color: darkGrey,
                                      size: 18.0,
                                      semanticLabel: 'Correct',
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text("Add", style: headingTextTitlesWSG,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GestureDetector(
                          onTap:(){
                            String nativeURL = sBase.getFirstLineSync(path, "User", "NativeURL", "Youtube");
                            String webURL = sBase.getFirstLineSync(path, "User", "WebURL", "Youtube");
                            !isYoutubeConnected?getSocialMediaHandleToAdd("Youtube"):openAppFromBF(nativeURL, webURL);
                          },
                          child: Column(
                            children: [
                              !isYoutubeConnected?Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  "assets/graphics/youtubegrey.png",
                                  width: screenWidth/6.9,
                                  height: screenWidth/6.9,
                                  fit: BoxFit.cover,
                                ),):
                              Image.asset(
                                "assets/graphics/youtube.png",
                                width: screenWidth/6.5,
                                height: screenWidth/6.5,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              isYoutubeConnected?const Text(""):Opacity(
                                opacity: 0.5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline,
                                      color: darkGrey,
                                      size: 18.0,
                                      semanticLabel: 'Correct',
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text("Add", style: headingTextTitlesWSG,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GestureDetector(
                          onTap:(){
                            String nativeURL = sBase.getFirstLineSync(path, "User", "NativeURL", "Facebook");
                            String webURL = sBase.getFirstLineSync(path, "User", "WebURL", "Facebook");
                            !isFacebookConnected?getSocialMediaHandleToAdd("Facebook"):openAppFromBF(nativeURL, webURL);
                          },
                          child: Column(
                            children: [
                              !isFacebookConnected?Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  "assets/graphics/facebookgrey.jpg",
                                  width: screenWidth/6.9,
                                  height: screenWidth/6.9,
                                  fit: BoxFit.cover,
                                ),):
                              Image.asset(
                                "assets/graphics/facebook.png",
                                width: screenWidth/6.5,
                                height: screenWidth/6.5,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              isFacebookConnected?const Text(""):
                              Opacity(
                                opacity: 0.5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline,
                                      color: darkGrey,
                                      size: 18.0,
                                      semanticLabel: 'Correct',
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text("Add", style: headingTextTitlesWSG,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GestureDetector(
                          onTap:(){
                            String nativeURL = sBase.getFirstLineSync(path, "User", "NativeURL", "Snapchat");
                            String webURL = sBase.getFirstLineSync(path, "User", "WebURL", "Snapchat");
                            !isSnapchatConnected?getSocialMediaHandleToAdd("Snapchat"):openAppFromBF(nativeURL, webURL);
                          },
                          child: Column(
                            children: [
                              !isSnapchatConnected?Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  "assets/graphics/snapchatgrey.jpg",
                                  width: screenWidth/6.9,
                                  height: screenWidth/6.9,
                                  fit: BoxFit.cover,
                                ),):
                              Image.asset(
                                "assets/graphics/snapchat.png",
                                width: screenWidth/6.5,
                                height: screenWidth/6.5,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              isSnapchatConnected?const Text(""):
                              Opacity(
                                opacity: 0.5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline,
                                      color: darkGrey,
                                      size: 18.0,
                                      semanticLabel: 'Correct',
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text("Add", style: headingTextTitlesWSG,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
            );
          }
          else if(position==1){
            return Padding(
              padding: const EdgeInsets.fromLTRB(7, 20, 7, 0),
              child: Row(
                children: [
                  Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GestureDetector(
                          onTap:(){
                            String nativeURL = sBase.getFirstLineSync(path, "User", "NativeURL", "Linkedin");
                            String webURL = sBase.getFirstLineSync(path, "User", "WebURL", "Linkedin");
                            !isLinkedinConnected?getSocialMediaHandleToAdd("Linkedin"):openAppFromBF(nativeURL, webURL);
                          },
                          child: Column(
                            children: [
                              !isLinkedinConnected?Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  "assets/graphics/linkedingrey.png",
                                  width: screenWidth/6.9,
                                  height: screenWidth/6.9,
                                  fit: BoxFit.cover,
                                ),):
                              Image.asset(
                                "assets/graphics/linkedin.png",
                                width: screenWidth/6.5,
                                height: screenWidth/6.5,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              isLinkedinConnected?const Text(""):
                              Opacity(
                                opacity: 0.5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline,
                                      color: darkGrey,
                                      size: 18.0,
                                      semanticLabel: 'Correct',
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text("Add", style: headingTextTitlesWSG,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GestureDetector(
                          onTap:(){
                            String nativeURL = sBase.getFirstLineSync(path, "User", "NativeURL", "X");
                            String webURL = sBase.getFirstLineSync(path, "User", "WebURL", "X");
                            !isXConnected?getSocialMediaHandleToAdd("X"):openAppFromBF(nativeURL, webURL);
                          },
                          child: Column(
                            children: [
                              !isXConnected?Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  "assets/graphics/xgrey.png",
                                  width: screenWidth/6.9,
                                  height: screenWidth/6.9,
                                  fit: BoxFit.cover,
                                ),):
                              Image.asset(
                                "assets/graphics/x.png",
                                width: screenWidth/6.5,
                                height: screenWidth/6.5,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              isXConnected?const Text(""):Opacity(
                                opacity: 0.5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline,
                                      color: darkGrey,
                                      size: 18.0,
                                      semanticLabel: 'Correct',
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text("Add", style: headingTextTitlesWSG,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GestureDetector(
                          onTap:(){
                            String nativeURL = sBase.getFirstLineSync(path, "User", "NativeURL", "Threads");
                            String webURL = sBase.getFirstLineSync(path, "User", "WebURL", "Threads");
                            !isThreadsConnected?getSocialMediaHandleToAdd("Threads"):openAppFromBF(nativeURL, webURL);
                          },
                          child: Column(
                            children: [
                              !isThreadsConnected?Opacity(
                                opacity: 0.3,
                                child: Image.asset(
                                  "assets/graphics/threadsgrey.png",
                                  width: screenWidth/6.9,
                                  height: screenWidth/6.9,
                                  fit: BoxFit.cover,
                                ),):
                              Image.asset(
                                "assets/graphics/threads.jpg",
                                width: screenWidth/6.5,
                                height: screenWidth/6.5,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              isThreadsConnected?const Text(""):
                              Opacity(
                                opacity: 0.5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline,
                                      color: darkGrey,
                                      size: 18.0,
                                      semanticLabel: 'Correct',
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text("Add", style: headingTextTitlesWSG,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GestureDetector(
                          onTap:(){
                            String nativeURL = sBase.getFirstLineSync(path, "User", "NativeURL", "Whatsapp");
                            String webURL = sBase.getFirstLineSync(path, "User", "WebURL", "Whatsapp");
                            !isWhatsappConnected?getSocialMediaHandleToAdd("Whatsapp"):openAppFromBF(nativeURL, webURL);
                          },
                          child: Column(
                            children: [
                              !isWhatsappConnected?Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  "assets/graphics/whatsappgrey.png",
                                  width: screenWidth/6.9,
                                  height: screenWidth/6.9,
                                  fit: BoxFit.cover,
                                ),):
                              Image.asset(
                                "assets/graphics/whatsapp.png",
                                width: screenWidth/6.2,
                                height: screenWidth/6.2,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              isWhatsappConnected?const Text(""):
                              Opacity(
                                opacity: 0.5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline,
                                      color: darkGrey,
                                      size: 18.0,
                                      semanticLabel: 'Correct',
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text("Add", style: headingTextTitlesWSG,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
            );
          }
          else if(position==2){
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 0, 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Text("Your Campaigns", style: headingTextTitlesLS,),
                      ),
                      toShowViewAll?Expanded(
                        flex: 3,
                        child: InkWell(
                          onTap: (){

                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                            child: Container(
                              height: 30,
                              width: 90,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      lP,
                                      lP,
                                    ],
                                  )
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Center(
                                    child: Text("View all", style: headingTextTitlesWSGB, textAlign: TextAlign.center,),
                                  )
                              ),
                            ),
                          ),
                        ),
                      ):const Text(""),
                    ],
                  ),
                  wList.length==3?Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Center(
                      child: Text("Welcome to Bloomfame 🙏"
                          "We will alert you when we match you "
                          "with suitable brands.", style: headingTextTitlesLSE,),
                    ),
                    ):const Text(""),
                ],
              ),
            );
          }
          else if(position>=3){
            return GestureDetector(
              onTap: (){
                setState((){
                  clickedIndex = position;
                  clickedC = gI[position];
                  currentScreen="CampaignDetails";
                });
              },
              onLongPress: (){
                //sBase.deleteFile(path, "Campaign", "LiveEachItem", gI[position].campaignID);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Container(
                    width: double.infinity,
                    height: screenHeight/2.7,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                      image: bannerF.path.isNotEmpty?DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(bannerF),
                      ):DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/graphics/black.jpg"),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 4,
                          child: Text(""),
                        ),
                        Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0), bottomRight: Radius.circular(40.0))
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Container(
                                            transform: Matrix4.translationValues(0, -40, 0),
                                            child: logoF.path.isEmpty?Image.asset(
                                              "assets/graphics/black.jpg",
                                              width: 80.0,
                                              height: 80.0,
                                              fit: BoxFit.cover,
                                            ):Image.file(
                                              logoF,
                                              width: 80.0,
                                              height: 80.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(12, 20, 20, 0),
                                          child: Text("\$$artistFeeOfferingRange", style: headingTextTitlesBGAAT,),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(12, 45, 0, 0),
                                          child: Text(productPublicName, style: headingTextTitlesLSE,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                          child: Text(companyName, style: headingTextTitlesLSGS,),
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              flex: 8,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                                child: Text(campaignDescription, style: headingTextTitlesLSGS,),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: GestureDetector(
                                                  onTap: (){

                                                  },
                                                  child: Container(
                                                    transform: Matrix4.translationValues(0, -5, 0),
                                                    child: const Padding(
                                                      padding: EdgeInsets.fromLTRB(12, 0, 2, 0),
                                                      child: Icon(
                                                        Icons.arrow_circle_right_outlined,
                                                        color: darkBlue,
                                                        size: 50.0,
                                                        semanticLabel: 'Friends',
                                                      ),
                                                    ),
                                                  )
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ),
                      ],
                    )
                ),
              ),
            );
          }
          else{
            return const Text("");
          }
        },
        itemCount: gI.length,
      ),
    );
  }
  void showProfileID(artistAPU){

  }
  Widget showCampaignDetailList(double screenHeight, double screenWidth, CampaignControl gI){
    String campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
        brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
        productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
        targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame,
        artistFeeOfferingRange, artistFeeNegotiation,
        paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
        analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
        analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
        campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
        isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true, removeLeft: true,
      child: ListView.builder(
        controller: scrollController,
        itemBuilder: (context, position) {
          campaignStatus = gI.campaignStatus;
          campaignID=gI.campaignID;
          agencyID=gI.agencyID;
          agencyName=gI.agencyName;
          companyID=gI.companyID;
          companyName=gI.companyName;
          productGenericID=gI.productGenericID;
          brandID=gI.brandID;
          modelID=gI.modelID;
          campaignName=gI.campaignName;
          productCategory=gI.productCategory;
          productPublicName=gI.productPublicName;
          brandName=gI.brandName;
          modelOfBrand=gI.modelOfBrand;
          logoURL=gI.logoURL;
          bannerURL=gI.bannerURL;
          campaignDescription=gI.campaignDescription;
          campaignCoreExpectation=gI.campaignCoreExpectation;
          sampleVideoURLA=gI.sampleVideoURLA;
          sampleVideoURLB=gI.sampleVideoURLB;
          sampleVideoURLC=gI.sampleVideoURLC;
          productPrice=gI.productPrice;
          discountOffered=gI.discountOffered;
          productSalientFeatures=gI.productSalientFeatures;
          targetCustomer=gI.targetCustomer;
          targetCustomerCategory=gI.targetCustomerCategory;
          targetCustomerExpectedIncome=gI.targetCustomerExpectedIncome;
          targetCustomerExpectedBehaviour=gI.targetCustomerExpectedBehaviour;
          targetCustomerAgeCategory=gI.targetCustomerAgeCategory;
          campaignDiscountCode=gI.campaignDiscountCode;
          artistFeeOfferByBloomfame = gI.artistFeeOfferingByBloomfame;
          artistFeeOfferingRange=gI.artistFeeOfferingRange;
          artistFeeNegotiation=gI.artistFeeNegotiation;
          paymentTerms=gI.paymentTerms;
          proRateFee=gI.proRateFee;
          campaignOutcomeAnalysisProcess=gI.campaignOutcomeAnalysisProcess;
          artistPerformanceRating=gI.artistPerformanceRating;
          campaignRatingByAgencyArtist=gI.campaignRatingByAgencyArtist;
          campaignPlatform=gI.campaignPlatform;
          analysisViews=gI.analysisViews;
          analysisLikes=gI.analysisLikes;
          analysisComments=gI.analysisComments;
          analysisReach=gI.analysisReach;
          analysisDemographics=gI.analysisDemographics;
          analysisExpectedOutput=gI.analysisExpectedOutput;
          analysisExactOutcome=gI.analysisExactOutcome;
          analysisSuccess=gI.analysisSuccess;
          analysisClicks=gI.analysisClicks;
          analysisPurchasedProduct=gI.analysisPurchasedProduct;
          analysisDeadline=gI.analysisDeadline;
          analysisFinishedSubmission=gI.analysisFinishedSubmission;
          rePost=gI.rePost; campaignStartDate=gI.campaignStartDate;
          campaignDeadLine=gI.campaignDeadLine;
          isCampaignAccepted=gI.isCampaignAccepted;
          campaignAgreementTimeStamp=gI.campaignAgreementTimeStamp;
          isISubmitted=gI.isISubmitted;
          isYSubmitted=gI.isYSubmitted; isFSubmitted=gI.isFSubmitted;
          isSSubmitted=gI.isSSubmitted; isLSubmitted=gI.isLSubmitted; isXSubmitted=gI.isXSubmitted;
          isTSubmitted=gI.isTSubmitted;
          isWSubmitted=gI.isWSubmitted; campaignApprovedByBloomfame=gI.campaignApprovedByBloomfame;
          eO=gI.eO; eP=gI.eP; eQ=gI.eQ; eR=gI.eR;
          eS=gI.eS; eT=gI.eT; eU=gI.eU; eV=gI.eV; eW=gI.eW; eX=gI.eX;
          eY=gI.eY; eZ=gI.eZ;
          File bannerF=File("");
          File logoF=File("");
          if(logoURL!="#"){
            logoF = File(logoURL);
          }
          if(bannerURL!="#"){
            bannerF = File(bannerURL);
            bannerI=File(bannerURL);
          }
          if(position==0){
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
              child: GestureDetector(
                onTap:(){
                  setState((){
                    currentScreen="PhotoView";
                  });
                },
                child: Container(
                    width: double.infinity,
                    height: screenHeight/2.2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(0.0), bottomRight: Radius.circular(0.0)),
                      image: bannerF.path.isNotEmpty?DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(bannerF),
                      ):DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/graphics/black.jpg"),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState((){
                              currentScreen="Work";
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                            child: Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Image.asset(
                                    "assets/graphics/backbuttonblack.png",
                                    width: 45,
                                    height: 35,
                                    fit: BoxFit.contain,
                                  ),
                                )
                            ),
                          ),
                        )
                      ],
                    )
                ),
              )
            );
          }
          if(position==1){
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0.0), bottomRight: Radius.circular(0.0)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Text(productPublicName, style: headingTextTitlesLSE),
                        ),
                        Text(companyName, style: headingTextTitlesLSGS,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                            child: Text(artistFeeOfferingRange, style: headingTextTitlesBGAAT,),
                          ),
                        ),
                        Text("Campaign ID: $campaignID", style: headingTextTitlesLS,),
                        Text("Campaign Details: $campaignCoreExpectation", style: headingTextTitlesLS,),
                        Text("Agency Name: $agencyName", style: headingTextTitlesLSGS,),
                        Text("Company Name: $companyName", style: headingTextTitlesLSGS,),
                        Text("Campaign Name: $campaignName", style: headingTextTitlesLSGS,),
                        Text("Brand Name: $brandName", style: headingTextTitlesLSGS,),
                        Text("Model of Brand: $modelOfBrand", style: headingTextTitlesLSGS,),
                        Text("Campaign Description: $campaignDescription", style: headingTextTitlesLSGS,),
                        Text("Campaign Core Expectation: $campaignCoreExpectation", style: headingTextTitlesLSGS,),
                        GestureDetector(
                          onTap: (){
                            _launchUrl(Uri.parse(sampleVideoURLA));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: darkGrey),
                                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.video_collection_rounded,
                                    color: darkGrey,
                                    size: 24.0,
                                    semanticLabel: 'Friends',
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Advertisement Sample-A", style: headingTextTitles,),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: darkGrey,
                                    size: 27.0,
                                    semanticLabel: 'Friends',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            _launchUrl(Uri.parse(sampleVideoURLB));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: darkGrey),
                                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.video_collection_rounded,
                                    color: darkGrey,
                                    size: 24.0,
                                    semanticLabel: 'Friends',
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Advertisement Sample-B", style: headingTextTitles,),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: darkGrey,
                                    size: 27.0,
                                    semanticLabel: 'Friends',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            _launchUrl(Uri.parse(sampleVideoURLC));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: darkGrey),
                                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.video_collection_rounded,
                                    color: darkGrey,
                                    size: 24.0,
                                    semanticLabel: 'Friends',
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Advertisement Sample-C", style: headingTextTitles,),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: darkGrey,
                                    size: 27.0,
                                    semanticLabel: 'Friends',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text("Product Price: $productPrice", style: headingTextTitlesLSGS,),
                        Text("Discount Offered: $discountOffered", style: headingTextTitlesLSGS,),
                        RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      style: headingTextTitlesLSGS,
                                      text: "Product Salient Features:"
                                  ),
                                  TextSpan(
                                      style: headingTextTitlesDBWeb,
                                      text: " $productSalientFeatures",
                                      recognizer: TapGestureRecognizer()..onTap =  () async{
                                        var url = productSalientFeatures;
                                        launchUrl(Uri.parse(url));
                                      }
                                  ),
                                ]
                            )),
                        Text("Target Customer: $targetCustomer", style: headingTextTitlesLSGS,),
                        Text("Target Customer Category: $targetCustomerCategory", style: headingTextTitlesLSGS,),
                        Text("Target Customer Expected Income: $targetCustomerExpectedIncome", style: headingTextTitlesLSGS,),
                        Text("Target Customer Expected Behaviour: $targetCustomerExpectedBehaviour", style: headingTextTitlesLSGS,),
                        Text("Target Customer Age Category: $targetCustomerAgeCategory", style: headingTextTitlesLSGS,),
                        Text("Campaign Discount Code: $campaignDiscountCode", style: headingTextTitlesLSGS,),
                        Text("Payment Terms $paymentTerms", style: headingTextTitlesLSGS,),
                        Text("Pro Rata Fee Mandatory: $proRateFee", style: headingTextTitlesLSGS,),
                        Text("Campaign Outcome Analysis $campaignOutcomeAnalysisProcess", style: headingTextTitlesLSGS,),
                        Text("Campaign Platform: $campaignPlatform", style: headingTextTitlesLSGS,),
                        Text("Campaign Launch: $campaignStartDate", style: headingTextTitles,),
                        Text("Campaign Deadline: $campaignDeadLine", style: headingTextTitles,),
                        isCampaignAccepted=="Yes"?Text("Agreement Accepted on: $campaignAgreementTimeStamp", style: headingTextTitles,):
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Center(
                            child: GestureDetector(
                              onTap: (){
                                signAgreement(context, clickedIndex, campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
                                    brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
                                    productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
                                    targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame, artistFeeOfferingRange, artistFeeNegotiation,
                                    paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
                                    analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
                                    analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
                                    campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
                                    isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Container(
                                      height: 50,
                                      width: 270,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              darkBlue,
                                              darkBlue,
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.book_rounded,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Partnership Agreement", style: headingTextTitlesW),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                const Icon(
                                                  Icons.arrow_circle_right_outlined,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        (isISubmitted=="YES" || isISubmitted=="NR") &&
                            (isYSubmitted=="YES" || isYSubmitted=="NR") &&
                            (isFSubmitted=="YES" || isFSubmitted=="NR") &&
                            (isSSubmitted=="YES" || isSSubmitted=="NR") &&
                            (isLSubmitted=="YES" || isLSubmitted=="NR") &&
                            (isXSubmitted=="YES" || isXSubmitted=="NR") &&
                            (isTSubmitted=="YES" || isTSubmitted=="NR") &&
                            (isWSubmitted=="YES" || isWSubmitted=="NR")?
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Center(
                            child: GestureDetector(
                              onTap: (){
                                 launchWebApp("https://bloomfame-ny.web.app/");
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Container(
                                      height: 50,
                                      width: 270,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              darkRed,
                                              darkRed,
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.payments_rounded,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Generate Invoice", style: headingTextTitlesW),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                const Icon(
                                                  Icons.arrow_circle_right_outlined,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ):
                        isCampaignAccepted=="Yes"?
                        campaignApprovedByBloomfame!="Yes"?
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Center(
                            child: GestureDetector(
                              onTap: (){
                                sendQuickApprovalRequest(campaignID);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Container(
                                      height: 50,
                                      width: 330,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Colors.black,
                                              Colors.black
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.approval_rounded,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Waiting for Platform Approval", style: headingTextTitlesW),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                const Icon(
                                                  Icons.arrow_circle_right_outlined,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ):campaignApprovedByBloomfame=="Rejected"?
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Center(
                            child: GestureDetector(
                              onTap: (){
                                raiseRequest(campaignID);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Container(
                                      height: 50,
                                      width: 330,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              darkRed,
                                              darkRed,
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.approval_rounded,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Platform Rejection", style: headingTextTitlesW),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                const Icon(
                                                  Icons.arrow_circle_right_outlined,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ):Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Center(
                            child: GestureDetector(
                              onTap: (){
                                Future.delayed(const Duration(milliseconds: 5), () {
                                  selectPlatformSubmission(context, position, screenHeight, screenWidth, campaignStatus, campaignID, agencyID, agencyName, companyID, companyName, productGenericID, brandID, modelID, campaignName, productCategory, productPublicName,
                                      brandName, modelOfBrand, logoURL, bannerURL, campaignDescription, campaignCoreExpectation, sampleVideoURLA, sampleVideoURLB, sampleVideoURLC,
                                      productPrice, discountOffered, productSalientFeatures, targetCustomer, targetCustomerCategory, targetCustomerExpectedIncome,
                                      targetCustomerExpectedBehaviour, targetCustomerAgeCategory, campaignDiscountCode, artistFeeOfferByBloomfame,
                                      artistFeeOfferingRange, artistFeeNegotiation,
                                      paymentTerms, proRateFee, campaignOutcomeAnalysisProcess, artistPerformanceRating, campaignRatingByAgencyArtist, campaignPlatform,
                                      analysisViews, analysisLikes, analysisComments, analysisReach, analysisDemographics, analysisExpectedOutput, analysisExactOutcome,
                                      analysisSuccess, analysisClicks, analysisPurchasedProduct, analysisDeadline, analysisFinishedSubmission, rePost, campaignStartDate, campaignDeadLine, isCampaignAccepted,
                                      campaignAgreementTimeStamp, isISubmitted, isYSubmitted, isFSubmitted, isSSubmitted, isLSubmitted, isXSubmitted, isTSubmitted,
                                      isWSubmitted, campaignApprovedByBloomfame, eO, eP, eQ, eR, eS, eT, eU, eV, eW, eX, eY, eZ);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Container(
                                      height: 50,
                                      width: 270,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              darkBlue,
                                              darkBlue,
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.subject_outlined,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Campaign Submission", style: headingTextTitlesW),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                const Icon(
                                                  Icons.arrow_circle_right_outlined,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ):const Text(""),
                      ],
                    ),
                  )
              ),
            );
          }
          else{
            return const Text("");
          }
        },
        itemCount: 2,
      ),
    );
  }
  void editArtistFee(BuildContext context, double screenHeight, double screenWidth){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35.0))),
        backgroundColor: darkBlue,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:18 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 16,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text("New Tagline", style: userSignOnOccupationTitleGreySLWN),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: () async {
                        String newTagLineID="";
                        if(newUserController.text.isNotEmpty && newUserController.text.length>3){
                          newTagLineID = newUserController.text.toString();
                          sBase.writeFilesRealtime(path, "User", "Details", "TagLine", newTagLineID, false);
                          loadNews();
                          setState(() {});
                          newUserController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            10, 0, 0, 0),
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: const BoxDecoration(
                            color: darkGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 22.0,
                                      semanticLabel: 'Friends',
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xffffffff),
                          Color(0xffffffff),
                        ],
                      )
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: TextField(
                        style: settingsHeadingTitlesS,
                        decoration: InputDecoration(
                          hintText: 'Please Enter New Input',
                          hintStyle: settingsHeadingTitlesS,
                        ),
                        controller: newUserController,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )
    );
  }
  void raiseRequest(String campaignID){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(1, (index) =>
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setStateC) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff000000),
                              spreadRadius: 10,
                              blurRadius: 13,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.remove,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Raise Request?", style: headingTextTitlesBGAAS,),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: InkWell(
                                  onTap: ()async{
                                    database.ref('Database/PlatformCampaignRejection/Campaigns/$campaignID$userNoID').set("VPN");
                                    var snackBar = SnackBar(content: Text('Rejection Appeal Raised'));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                    child: Container(
                                      height: 50,
                                      width: 220,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Color(0xff000026),
                                              Color(0xff000026),
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.help_outline_rounded,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Submit Request", style: headingTextTitlesW),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
            ),
          ),
        );
      },
    );
  }
  Widget showProfileList(double screenHeight, double screenWidth, List<ProfileList> profileList){
    String userName, profilePicture, profileTagLine, campaignIDA, campaignIDB, campaignIDC, campaignIDD;
    String newsType, artistNameA, artistAPU, artistNameB, artistBPU, brandName,
        brandILogo, productName, productURL, newsTimeStamp;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true, removeLeft: true,
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, position) {
          userName = profileList[position].userName;
          profilePicture=profileList[position].profilePicture;
          profileTagLine=profileList[position].profileTagLine;
          campaignIDA=profileList[position].campaignIDA;
          campaignIDB=profileList[position].campaignIDB;
          campaignIDC=profileList[position].campaignIDC;
          campaignIDD=profileList[position].campaignIDD;
          File profilePictureA=File("");
          File campaignA=File("");
          File campaignB=File("");
          File campaignC=File("");
          File campaignD=File("");
          newsType = profileList[position].newsType;
          artistNameA = profileList[position].artistNameA;
          artistAPU = profileList[position].artistAPU;
          artistNameB = profileList[position].artistNameB;
          artistBPU = profileList[position].artistAPU;
          brandName = profileList[position].brandName;
          brandILogo = profileList[position].brandILogo;
          productName = profileList[position].productName;
          productURL = profileList[position].productURL;
          newsTimeStamp = profileList[position].newsTimeStamp;
          File logoA=File("");
          File logoB=File("");
          if(profilePicture!="#"){
            profilePictureA = File(profilePicture);
          }
          if(campaignIDA!="#"){
            campaignA = File(campaignIDA);
          }
          if(campaignIDB!="#"){
            campaignB = File(campaignIDB);
          }
          if(campaignIDC!="#"){
            campaignC = File(campaignIDC);
          }
          if(campaignIDD!="#"){
            campaignD = File(campaignIDD);
          }
          if(profileTagLine=="#"){
            profileTagLine = "Add Tagline";
          }
          if(position==0){
            return Column(
              children: [
                InkWell(
                  onTap:(){
                    _onImageButtonPressed();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Center(
                      child: profilePictureA.path.isNotEmpty?
                      Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: FileImage(profilePictureA),
                          ),
                        ),
                        child:const Text(""),
                      ):
                      Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          "assets/graphics/human-icon.png",
                          width: 150.0,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Text(userName, style: headingTextTitlesBGAAT),
                ),
                InkWell(
                  onTap: (){
                    editArtistFee(context, screenHeight, screenWidth);
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(profileTagLine, style: headingTextTitlesLSGS),
                        SizedBox(
                          width: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    darkRed,
                                    darkRed
                                  ],
                                )
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 15.0,
                                      semanticLabel: 'Friends',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          else if(position==1){
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 0, 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Text("My Activity", style: headingTextTitlesLS,),
                  ),
                  const Expanded(
                    flex: 3,
                    child: Text(""),
                  ),
                ],
              ),
            );
          }
          else if(position>=2 && position!=profileList.length-1){
            return newsType=="Follow"?
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: InkWell(
                          onTap:(){

                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Center(
                              child: logoA.path.isNotEmpty?
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(logoA),
                                  ),
                                ),
                                child:const Text(""),
                              ):
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  "assets/graphics/human-icon.png",
                                  width: 50.0,
                                  height: 50.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 28,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  showProfileID(artistAPU);
                                },
                                child: Text(artistNameA, textAlign: TextAlign.start),
                              ),
                              const Text(" started following ", textAlign: TextAlign.start),
                              GestureDetector(
                                onTap:(){
                                  showProfileID(artistAPU);
                                },
                                child: Text(artistNameB, textAlign: TextAlign.start),
                              )
                            ],
                          )
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text(getTimeDifference(newsTimeStamp)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ):newsType=="Collab"?
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 8,
                          child: InkWell(
                            onTap:(){

                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Center(
                                child: logoA.path.isNotEmpty?
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(logoA),
                                    ),
                                  ),
                                  child:const Text(""),
                                ):
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    "assets/graphics/human-icon.png",
                                    width: 50.0,
                                    height: 50.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 28,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    showProfileID(artistAPU);
                                  },
                                  child: Text(brandName, textAlign: TextAlign.start),
                                ),
                                const Text(" signed a deal with ", textAlign: TextAlign.start),
                                GestureDetector(
                                  onTap:(){
                                    showProfileID(artistAPU);
                                  },
                                  child: Text(artistNameB, textAlign: TextAlign.start),
                                )
                              ],
                            )
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text(getTimeDifference(newsTimeStamp)),
                          ),
                        ),
                      ],
                    )
                  ],
                )):newsType=="Launch"?
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: InkWell(
                          onTap:(){

                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Center(
                              child: logoA.path.isNotEmpty?
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(logoA),
                                  ),
                                ),
                                child:const Text(""),
                              ):
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  "assets/graphics/human-icon.png",
                                  width: 50.0,
                                  height: 50.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 28,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  showProfileID(artistAPU);
                                },
                                child: Text(brandName, textAlign: TextAlign.start),
                              ),
                              const Text(" launched globally today.", textAlign: TextAlign.start),
                              GestureDetector(
                                onTap:(){
                                  showProfileID(artistAPU);
                                },
                                child: Text(artistNameB, textAlign: TextAlign.start),
                              )
                            ],
                          )
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text(getTimeDifference(newsTimeStamp)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ):const Text("");
          }
          else if(position==profileList.length-1){
            return Column(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            deleteAllFiles();
                            transferToVerification();
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Container(
                              height: 50,
                              width: 180,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color(0xff000026),
                                      Color(0xff000026),
                                    ],
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.logout_rounded,
                                          color: Colors.white,
                                          size: 22.0,
                                          semanticLabel: 'Friends',
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text("Log Out", style: headingTextTitlesW),
                                      ],
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            database.ref('Database/Users/$userNoID').remove();
                            deleteAllFiles();
                            transferToVerification();
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                            child: Container(
                              height: 50,
                              width: 220,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      darkRed,
                                      darkRed,
                                    ],
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.remove_circle_rounded,
                                          color: Colors.white,
                                          size: 22.0,
                                          semanticLabel: 'Friends',
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text("Delete Account", style: headingTextTitlesW),
                                      ],
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            );
          }
          else{
            return const Text("");
          }
        },
        itemCount: profileList.length,
      ),
    );
  }
  void _onImageButtonPressed()async{
    final List<XFile> pickedFileList = <XFile>[];
    final XFile? media = await _picker.pickMedia(
      maxWidth: 720,
      maxHeight: 720,
      imageQuality: 100,
    );
    if (media != null) {
      pickedFileList.add(media);
      setState(() {
        String pFP = pickedFileList.first.path.toString();
        sF = File(pFP);
        sBase.writeFilesRealtime(path, "User", "Profile", "DownloadedImageFilePath", pFP, false);
        String imageName = pFP.substring(pFP.lastIndexOf("/")+1);
        final metadata = SettableMetadata(contentType: "image/jpeg");
        final storageRef = FirebaseStorage.instance.ref();
        final uploadTask = storageRef
            .child("$userNoID/$imageName")
            .putFile(sF, metadata);
        uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
          switch (taskSnapshot.state) {
            case TaskState.running:
              sBase.writeFilesRealtime(path, "User", "Details", "Profile", imageName, false);
              database.ref('Database/Users/$userNoID/UserDetails/Profile').set(imageName);
              break;
            case TaskState.paused:
              break;
            case TaskState.canceled:
              break;
            case TaskState.error:
              break;
            case TaskState.success:
              break;
          }
        });
      });
    }
  }
  Widget showIndustryExploreList(double screenHeight, double screenWidth, List<IndustryExplore> iEList){
    String newsType, artistNameA, artistAPU, artistNameB, artistBPU, brandName,
        brandILogo, productName, productURL, newsTimeStamp;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true, removeLeft: true,
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, position) {
          newsType = iEList[position].newsType;
          artistNameA=iEList[position].artistNameA;
          artistAPU=iEList[position].artistAPU;
          artistNameB=iEList[position].artistNameB;
          artistBPU=iEList[position].artistAPU;
          brandName=iEList[position].brandName;
          brandILogo=iEList[position].brandILogo;
          productName=iEList[position].productName;
          productURL=iEList[position].productURL;
          newsTimeStamp=iEList[position].newsTimeStamp;
          File logoA=File("");
          File logoB=File("");
          if(newsType=="Follow"){
            if(artistAPU.contains("/")){
              logoA = File(artistAPU);
            }
          }
          if(newsType=="Collab"){
            if(artistAPU!="#"){
              logoA = File(artistAPU);
            }
            if(brandILogo!="#"){
              logoB = File(brandILogo);
            }
          }
          if(newsType=="Launch"){
            if(brandILogo!="#"){
              logoA = File(brandILogo);
            }
          }
          if(position==0){
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 0, 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Text("Industry Explore", style: headingTextTitlesLS,),
                  ),
                  const Expanded(
                    flex: 3,
                    child: Text(""),
                  ),
                ],
              ),
            );
          }
          else if(position>=1){
            return newsType=="Follow"?
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: InkWell(
                          onTap:(){

                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Center(
                              child: logoA.path.isNotEmpty?
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(logoA),
                                  ),
                                ),
                                child:const Text(""),
                              ):
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  "assets/graphics/human-icon.png",
                                  width: 50.0,
                                  height: 50.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 28,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                showProfileID(artistAPU);
                              },
                              child: Text(artistNameA, textAlign: TextAlign.start),
                            ),
                            const Text(" started following ", textAlign: TextAlign.start),
                            GestureDetector(
                              onTap:(){
                                showProfileID(artistAPU);
                              },
                              child: Text(artistNameB, textAlign: TextAlign.start),
                            )
                          ],
                        )
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text(getTimeDifference(newsTimeStamp)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ):newsType=="Collab"?
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 8,
                          child: InkWell(
                            onTap:(){

                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Center(
                                child: logoA.path.isNotEmpty?
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(logoA),
                                    ),
                                  ),
                                  child:const Text(""),
                                ):
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    "assets/graphics/human-icon.png",
                                    width: 50.0,
                                    height: 50.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 28,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    showProfileID(artistAPU);
                                  },
                                  child: Text(brandName, textAlign: TextAlign.start),
                                ),
                                const Text(" signed a deal with ", textAlign: TextAlign.start),
                                GestureDetector(
                                  onTap:(){
                                    showProfileID(artistAPU);
                                  },
                                  child: Text(artistNameB, textAlign: TextAlign.start),
                                )
                              ],
                            )
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text(getTimeDifference(newsTimeStamp)),
                          ),
                        ),
                      ],
                    )
                  ],
                )):newsType=="Launch"?
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: InkWell(
                          onTap:(){

                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Center(
                              child: logoA.path.isNotEmpty?
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(logoA),
                                  ),
                                ),
                                child:const Text(""),
                              ):
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  "assets/graphics/human-icon.png",
                                  width: 50.0,
                                  height: 50.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 28,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  showProfileID(artistAPU);
                                },
                                child: Text(brandName, textAlign: TextAlign.start),
                              ),
                              const Text(" launched globally today.", textAlign: TextAlign.start),
                              GestureDetector(
                                onTap:(){
                                  showProfileID(artistAPU);
                                },
                                child: Text(artistNameB, textAlign: TextAlign.start),
                              )
                            ],
                          )
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text(getTimeDifference(newsTimeStamp)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ):const Text("");
          }
          else{
            return const Text("");
          }
        },
        itemCount: iEList.length,
      ),
    );
  }
  void deleteAllFiles(){
    sBase.deleteFullDirectory(path, "User");
  }
  void setupRegistration(String realCompanyName, String companyDatabaseID){
    sBase.writeFilesRealtime(path, "User", "Company", "Code", companyDatabaseID, false);
    sBase.writeFilesRealtime(path, "User", "Company", "Verification", "Successful", false);
    database.ref('$companyDatabaseID/Database/DynamicAddOn/Units/UnitA').set("Kg");
    database.ref('$companyDatabaseID/Database/DynamicAddOn/Units/UnitB').set("Nos");
    database.ref('$companyDatabaseID/Database/DynamicAddOn/Units/UnitC').set("Ton");
    database.ref('$companyDatabaseID/Database/DynamicAddOn/Units/UnitC').set("Quintal");
    DateTime today = DateTime.now();
    String dateStr = "${today.year}-${today.month}-${today.day}-${today.hour}-${today.minute}-${today.second}";
    database.ref('$companyDatabaseID/Database/LastUpdated').set(dateStr);
    deleteAllFiles();
    RestartWidget.restartApp(context);
  }
  String generateSixR(){
    var rndNumber="";
    var rnd= Random();
    for (var i = 0; i < 6; i++) {
      rndNumber = rndNumber + rnd.nextInt(9).toString();
    }
    return rndNumber;
  }
  String getPlainCorrectedName(String newName){
    String rN="";
    int lC=0;
    for(int i=0; i<newName.length; i++){
      final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
      if(validCharacters.hasMatch(newName[i]) && lC<3){
        rN+=newName[i];
      }
      lC++;
    }
    String uniqueT = DateTime.now().millisecondsSinceEpoch.toString();
    String toR = rN+uniqueT;
    return toR;
  }
  String getDatabaseCorrectedName(String newName){
    String rN="";
    for(int i=0; i<newName.length; i++){
      final validCharacters = RegExp(r'^[a-zA-Z0-9]');
      if(validCharacters.hasMatch(newName[i])){
        rN+=newName[i];
      }
    }
    return rN;
  }
  void getNewCompanyName(){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35.0))),
        backgroundColor: darkBlue,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:18 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 16,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text("New Company", style: userSignOnOccupationTitleGreySLWN),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: () async {
                        String newCompanyName="";
                        if(newUserController.text.isNotEmpty && newUserController.text.length>3){
                          newCompanyName = newUserController.text.toString();
                          String aC = generateSixR();
                          String correctedName = getPlainCorrectedName(newCompanyName);
                          sBase.writeFilesRealtime(path, "User", "Company", "AuthCode", aC, false);
                          companyA=aC;
                          database.ref('AuthCode/$aC').set(correctedName);
                          database.ref('UI/$correctedName').set(newCompanyName);
                          String lPN = sBase.getFirstLineSync(path, "User", "Details", "PhoneNumber");
                          database.ref('$correctedName/Database/UserRights/$lPN').set("Admin");
                          database.ref('$correctedName/Database/DynamicAddOn/AuthCode').set(aC);
                          setupRegistration(newCompanyName, correctedName);
                          setState(() {});
                          newUserController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            10, 0, 0, 0),
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: const BoxDecoration(
                            color: darkGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 22.0,
                                      semanticLabel: 'Friends',
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xffffffff),
                          Color(0xffffffff),
                        ],
                      )
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: TextField(
                        style: settingsHeadingTitlesS,
                        decoration: InputDecoration(
                          hintText: 'Please Enter New Input',
                          hintStyle: settingsHeadingTitlesS,
                        ),
                        controller: newUserController,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )
    );
  }
  Widget createDisplayDynamicSelect(BuildContext context, IconData iD, String newDataInputCategoryType,
      List<String> oList, List<String> fList, String dynamicInputTitle, String selectedIT,
      String selectedITEmptyValue, TextStyle selectedITTextStyle, TextStyle selectedITTextStyleEmpty,
      double left, double top, double right, double bottom){
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Container(
          height: 55,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40.0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    setState(() {

                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          iD,
                          color: darkRed,
                          size: 23,
                          semanticLabel: 'Home',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 28,
                child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 25, top: 3),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        pickDynamicInput(context, oList, fList, dynamicInputTitle);
                      },
                      child: Text(selectedIT, style: selectedIT.contains(selectedITEmptyValue)?selectedITTextStyle:selectedITTextStyleEmpty,),
                    )
                ),
              ),
              Expanded(
                flex: 8,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    onNewClickDyn(newDataInputCategoryType);
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle_rounded,
                          color: darkRed,
                          size: 25,
                          semanticLabel: 'Home',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
  Widget createOnlyDisplayDynamicSelect(BuildContext context, List<String> oList, List<String> fList,
      String dynamicInputTitle, String selectedIT,
      String selectedITEmptyValue, TextStyle selectedITTextStyle, TextStyle selectedITTextStyleEmpty,
      double left, double top, double right, double bottom){
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Container(
          height: 55,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40.0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 25, top: 3),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        pickDynamicInput(context, oList, fList, dynamicInputTitle);
                      },
                      child: Text(selectedIT, style: selectedIT.contains(selectedITEmptyValue)?selectedITTextStyle:selectedITTextStyleEmpty,),
                    )
                ),
              ),
            ],
          )
      ),
    );
  }
  Widget createDynamicTextField(TextInputType inpT, String hText, TextEditingController localControllerT){
    return Container(
      height: 55,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 25, top: 3),
        child: TextField(
          style: userRegistrationTitleUDB,
          textAlign: TextAlign.start,
          cursorColor: darkBlue,
          keyboardType: inpT,
          onChanged: (text) {
          },
          autocorrect: false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
            hintText: hText,
            filled: true,
            fillColor: Colors.white,
            hintStyle: userSignOnTextField,
            border: InputBorder.none,
          ),
          controller: localControllerT,
        ),
      ),
    );
  }
  void displaySelection(){
    //selectedUpdate
    //scaffoldKey.currentState!.openEndDrawer();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(1, (index) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateC) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: darkBlue,
                          spreadRadius: 10,
                          blurRadius: 13,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.remove,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Select Option", style: userSignOnOccupationTitle, textAlign: TextAlign.center,),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Text("Selective Access", style: headingTextTitlesG, textAlign: TextAlign.center,),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    setState(() {
                                      selectedUpdate="Order";
                                    });
                                    Navigator.pop(context);
                                    scaffoldKey.currentState!.openEndDrawer();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      height: 50,
                                      width: 250,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              darkBlue,
                                              darkBlue,
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.offline_bolt_rounded,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Update Order", style: headingTextTitlesW),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    Navigator.pop(context);
                                    displayDeliverySelection();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      height: 50,
                                      width: 250,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              darkBlue,
                                              darkBlue,
                                            ],
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.fire_truck_outlined,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                  semanticLabel: 'Friends',
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Update Delivery", style: headingTextTitlesW),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            ),
          ),
        );
      },
    );
  }
  void displayDeliverySelection(){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(1, (index) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateC) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: darkBlue,
                          spreadRadius: 10,
                          blurRadius: 13,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.remove,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Credit/Debit", style: userSignOnOccupationTitle, textAlign: TextAlign.center,),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: (){
                                      Navigator.pop(context);
                                      setState(() {
                                        selectedUpdate="Delivery";
                                        deliverySelection="DeliveryCredit";
                                      });
                                      scaffoldKey.currentState!.openEndDrawer();
                                    },
                                    child: Container(
                                        width: 170,
                                        height: 48,
                                        decoration: const BoxDecoration(
                                          color: darkGreen,
                                          borderRadius: BorderRadius.all(Radius.circular(40.0),
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 18,
                                              child: GestureDetector(
                                                child: const Padding(
                                                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.add_circle_rounded,
                                                        color: Colors.white,
                                                        size: 23,
                                                        semanticLabel: 'Home',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 36,
                                              child: Padding(
                                                  padding: const EdgeInsets.only(left: 0, right: 25, top: 3),
                                                  child: GestureDetector(
                                                    child: Text("Credit", style: userSignOnTextFieldW,),
                                                  )
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: (){
                                      Navigator.pop(context);
                                      setState(() {
                                        selectedUpdate="Delivery";
                                        deliverySelection="DeliveryDebit";
                                      });
                                      scaffoldKey.currentState!.openEndDrawer();
                                    },
                                    child: Container(
                                      width: 170,
                                      height: 48,
                                      decoration: const BoxDecoration(
                                        color: darkRed,
                                        borderRadius: BorderRadius.all(Radius.circular(40.0),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 18,
                                            child: GestureDetector(
                                              child: const Padding(
                                                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.white,
                                                      size: 23,
                                                      semanticLabel: 'Home',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 36,
                                            child: Padding(
                                                padding: const EdgeInsets.only(left: 0, right: 25, top: 3),
                                                child: GestureDetector(
                                                  child: Text("Debit", style: userSignOnTextFieldW,),
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            ),
          ),
        );
      },
    );
  }
  bool checkOrderInput(){
    if(orderID.text=="" || selectedItem=="Select Item" ||
        quantityController.text=="" ||  priceController.text==""
        || selectedUnit=="Unit" || selectedCompany=="Select Company"){
      return false;
    }
    else{
      return true;
    }
  }
  bool checkCreditInput(){
    if(challanController.text=="" || selectedItem=="Select Item" || selectedSite=="Site Location" || selectedSite=="Select Company" ||
        quantityController.text=="" ||  selectedUnit=="Unit" || userPictureName==""){
      return false;
    }
    else{
      return true;
    }
  }
  bool checkDebitInput(){
    if(selectedUnit=="Unit" || selectedItem=="Select Item" ||
        quantityController.text=="" ||  selectedSite=="Site Location"){
      return false;
    }
    else{
      return true;
    }
  }
  void updateLiveItemStatusDirectly(String itemL, siteL, itemID, siteID, processStatus,
      iQ, String iP,bool isDelete){
    String itemSiteID = "$itemID-$siteID";
    String lD = sBase.getFirstLineSync(path, "LiveStock", "Database", itemSiteID);
    if(lD.isEmpty || lD=="#"){
      lD="$itemL~0~0~0~$siteL~";
    }
    int count=0, pQ=0, newPQ=0;
    sBase.delimitString(lD, "~").forEach((element) {
      if(count==1){
        pQ=int.parse(element);
      }
      count++;
    });
    if(processStatus=="Debit"){
      if(isDelete){
        newPQ = pQ + int.parse(iQ);
      }
      else{
        newPQ = pQ - int.parse(iQ);
      }
    }
    else{
      if(isDelete){
        newPQ = pQ - int.parse(iQ);
      }
      else{
        newPQ = pQ + int.parse(iQ);
      }
    }
    if(iP.isEmpty){
      iP="0";
    }
    double nP = double.parse(iP);
    String newI = "$itemL~$newPQ~$nP~${newPQ*nP}~$siteL~";
    database.ref('$companyCode/Database/StockLive/$itemSiteID').set(newI);
  }
  void updateOrderQuantityStatusIfReq(String sItem, String sCompany, String sQuantity){
    database.ref('$companyCode/Database/OrderQuantitySQ/${getDatabaseCorrectedName("$sItem¬$sCompany")}/Pending').once().
    then((dValue)async{
      var sValue = dValue.snapshot.value;
      if(sValue!=null){
        bool isDone=false; double leftO=double.parse(sQuantity); String eNode="";
        Map<dynamic, dynamic> mapUserData = sValue as Map;
        mapUserData.forEach((keyOData, valueOData){
          if(!isDone){
            try{
              double cQ = double.parse(valueOData);
              double qToD = double.parse(sQuantity);
              leftO = cQ-qToD;
              eNode=keyOData.toString();
              if(cQ-qToD>0){
                double lO=cQ-qToD;
                database.ref('$companyCode/Database/OrderQuantitySQ/${getDatabaseCorrectedName("$sItem¬$sCompany")}/Pending/$keyOData').set(lO.toString());
                isDone=true;
              }
              else if(cQ-qToD==0){
                database.ref('$companyCode/Database/OrderQuantitySQ/${getDatabaseCorrectedName("$sItem¬$sCompany")}/Pending/$keyOData').remove();
                database.ref('$companyCode/Database/OrderQuantitySQ/${getDatabaseCorrectedName("$sItem¬$sCompany")}/Completed/$keyOData').set("0");
                updateLiveOrderListComplete(keyOData);
                isDone=true;
              }
              else if(cQ-qToD<0){
                database.ref('$companyCode/Database/OrderQuantitySQ/${getDatabaseCorrectedName("$sItem¬$sCompany")}/Pending/$keyOData').remove();
                database.ref('$companyCode/Database/OrderQuantitySQ/${getDatabaseCorrectedName("$sItem¬$sCompany")}/Completed/$keyOData').set("0");
                updateLiveOrderListComplete(keyOData);
              }
            }catch(exception){}
          }
        });
        if(leftO<0){
          database.ref('$companyCode/Database/OrderQuantitySQ/${getDatabaseCorrectedName("$sItem¬$sCompany")}/Error/$eNode').set(leftO.toString());
        }
      }
    }, onError: (error) {
    });
  }
  void updateLiveOrderListComplete(String orderI){
    database.ref('$companyCode/Database/OrderIDS/$orderI').once().then((dValue)async{
      var sValue = dValue.snapshot.value;
      if(sValue!=null){
        String cV = sValue.toString();
        cV = cV.replaceAll("~Pending", "~Completed");
        database.ref('$companyCode/Database/OrderIDS/$orderI').set(cV);
      }
    },
        onError: (error) {
        });
  }
  void updateLastTimeServer(){
    DateTime today = DateTime.now();
    String dateStr = "${today.year}-${today.month}-${today.day}-${today.hour}-${today.minute}-${today.second}";
    Future.delayed(const Duration(seconds: 1)).then((value) {
      database.ref("$companyCode/Database/LastUpdatedItem").set(dateStr);
    });
  }
  void loadFS(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Please Wait", style: headingTextTitlesGSR),
        );
      },
    );
  }
  void processItemSubmission(String processStatus){
    loadFS();
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.pop(context);
      String tS = DateTime.now().toString();
      String uniqueT = DateTime.now().millisecondsSinceEpoch.toString();
      String uP = userPictureName;
      if(uP.isEmpty){
        uP = "#";
      }
      String itemUpdate = "$selectedItem~${quantityController.text}~${priceController.text}~$processStatus~$selectedSite~$phoneNumber~$tS~${orderID.text}~${challanController.text}~$uP~Unauthorised~";
      String itemID = selectedItem.substring(0, selectedItem.indexOf("-"));
      String siteID = selectedSite.substring(0, selectedSite.indexOf("-"));
      updateLiveItemStatusDirectly(selectedItem, selectedSite, itemID, siteID, processStatus,
          quantityController.text.toString(), priceController.text.toString(), false);
      if(processStatus=="Credit"){
        updateOrderQuantityStatusIfReq(selectedItem, selectedCompany, quantityController.text.toString());
      }
      database.ref('$companyCode/Database/DateWiseEntries/$itemID/$uniqueT').set(itemUpdate);
      updateLastTimeServer();
      setState(() {
        selectedSite="Site Location";
        selectedItem="Select Item";
        selectedUnit="Unit";
        userPictureName="";
        quantityController.text="";
        challanController.text="";
        priceController.text="";
        orderID.text="";
      });
      Navigator.pop(context);
    });
  }
  void processOrderInput(){
    String orderIDL = orderID.text.toString();
    String quantityL = quantityController.text.toString();
    String priceL = priceController.text.toString();
    String tS = DateTime.now().toString();
    String orderContent="$orderIDL~$selectedItem~$quantityL~$priceL~$selectedUnit~$selectedCompany~$tS~Pending~";
    database.ref('$companyCode/Database/OrderQuantitySQ/${getDatabaseCorrectedName("$selectedItem¬$selectedCompany")}/Pending/${getDatabaseCorrectedName(orderIDL)}').set(quantityL);
    database.ref('$companyCode/Database/OrderIDS/${getDatabaseCorrectedName(orderIDL)}').set(orderContent);
    updateLastTimeServer();
    Navigator.pop(context);
  }
  void clearAllInputs(){
    setState(() {
      phoneNumberController.clear();
      newUserController.clear();
      quantityController.clear();
      priceController.clear();
      challanController.clear();
      phoneNumberControllerGroupPassword.clear();
      itemUsageListController.clear();
      itemStatusListController.clear();
      companyAuthCode.clear();
      orderID.clear();
      selectedItem="Select Item";
      selectedSite="Site Location";
      selectedUnit="Unit";
      selectedUpdate="None";
      deliverySelection="DeliveryDebit";
      selectedCompany="Select Company";
    });
  }
  void onMenuClick(){
    clearAllInputs();
    if(userRights=="Admin" || (userRights=="Order" && userRights=="Delivery")){
      displaySelection();
    }
    else{
      if(userRights.contains("Order")){
        setState(() {
          selectedUpdate="Order";
        });
      }
      else if(userRights.contains("Delivery")){
        setState(() {
          selectedUpdate="Delivery";
        });
      }
      scaffoldKey.currentState!.openEndDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: darkBlue,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xff000015),
    ));
    if(MediaQuery.of(context).orientation == Orientation.landscape){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    separatorWidth = screenWidth/6;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return PopScope(
      onPopInvoked: (bV)async {
        if (HomePage.activeScreen!="Home") {
          if(HomePage.activeScreen=="CBox"){
            if(keyboardFocus){
              setState((){
                keyboardFocus=false;
              });
            }
            else{
              setState((){
                HomePage.activeScreen="Home";
              });
            }
          }
          else{
            setState((){
              HomePage.activeScreen="Home";
            });
          }
        }
        else{
          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(1, (index) => StatefulBuilder(
                      builder: (BuildContext context, StateSetter setStateC) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: darkRed,
                                spreadRadius: 10,
                                blurRadius: 13,
                                offset: Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.remove,
                                      color: Colors.grey[600],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Exit BuildTrackr?", style: userSignOnOccupationTitle, textAlign: TextAlign.center,),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        child: Text("Pressing the back button twice prompts the exit option.", style: headingTextTitlesG, textAlign: TextAlign.center,),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                          SystemNavigator.pop();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Container(
                                            height: 50,
                                            width: 200,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.topRight,
                                                  colors: [
                                                    darkBlue,
                                                    darkBlue
                                                  ],
                                                )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                              child: Center(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(
                                                        Icons.exit_to_app_rounded,
                                                        color: Colors.white,
                                                        size: 22.0,
                                                        semanticLabel: 'Friends',
                                                      ),
                                                      const SizedBox(
                                                        width: 7,
                                                      ),
                                                      Text("Exit", style: headingTextTitlesW),
                                                    ],
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  ),
                ),
              );
            },
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: phoneBoxGrey,
          resizeToAvoidBottomInset: HomePage.activeScreen=="CBox"?true:false,
          drawerEdgeDragWidth: 0,
          body: currentScreen=="PhotoView"?Stack(
            children: [
              PhotoView(
                imageProvider: FileImage(bannerI),
              ),
              GestureDetector(
                onTap: (){
                  setState((){
                    currentScreen="CampaignDetails";
                  });
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                  child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Image.asset(
                          "assets/graphics/backbuttonblack.png",
                          width: 45,
                          height: 35,
                          fit: BoxFit.contain,
                        ),
                      )
                  ),
                ),
              )
            ],
          ):currentScreen!="CampaignDetails"?Column(
            children: [
              Expanded(
                  flex: 26,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: (){
                              setState((){
                                currentScreen="Work";
                              });
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(25, 7, 0, 5),
                                  child: Image.asset(
                                    "assets/graphics/bloomfamelogo.png",
                                    height: 65,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap:(){
                                    launchWebApp("https://bloomfame-ny.web.app/");
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                                      child: SizedBox(
                                        width: 44,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  child: const Icon(
                                                    Icons.add_circle_outline,
                                                    color: darkBlue,
                                                    size: 35.0,
                                                    semanticLabel: 'Home',
                                                  ),
                                                ),
                                                newReqCount!=0?Container(
                                                  transform: Matrix4.translationValues(0, -5, 0),
                                                  child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: Container(
                                                      width: 25.0,
                                                      height: 25.0,
                                                      decoration: const BoxDecoration(
                                                        color: darkRed,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Center(
                                                        child: Text("2", style: headingTextTitlesW,),
                                                      ),
                                                    ),
                                                  ),
                                                ):const Text(""),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ),
                              ),
                              showUserRequest?Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap:(){
                                    showNoNotifications("No Notifications");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                                    child: SizedBox(
                                      width: 44,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                child: const Icon(
                                                  Icons.account_circle_outlined,
                                                  color: darkBlue,
                                                  size: 35.0,
                                                  semanticLabel: 'Home',
                                                ),
                                              ),
                                              newReqCount!=0?Container(
                                                transform: Matrix4.translationValues(0, -5, 0),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    width: 25.0,
                                                    height: 25.0,
                                                    decoration: const BoxDecoration(
                                                      color: darkRed,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: Text("2", style: headingTextTitlesW,),
                                                    ),
                                                  ),
                                                ),
                                              ):const Text(""),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ):const Text(""),
                              showUserNotification?Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap:(){
                                    showNoNotifications("No Notifications");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                                    child: SizedBox(
                                      width: 44,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                child: const Icon(
                                                  Icons.notifications_none_rounded,
                                                  color: darkBlue,
                                                  size: 35.0,
                                                  semanticLabel: 'Home',
                                                ),
                                              ),
                                              newReqCount!=0?Container(
                                                transform: Matrix4.translationValues(0, -5, 0),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    width: 25.0,
                                                    height: 25.0,
                                                    decoration: const BoxDecoration(
                                                      color: darkRed,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: Text("2", style: headingTextTitlesW,),
                                                    ),
                                                  ),
                                                ),
                                              ):const Text(""),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ):const Text(""),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              const SizedBox(
                height: 8.0,
              ),
              currentScreen=="Work"?
              Expanded(
                flex: 134,
                child: Container(
                  color: Colors.white,
                  child: showCampaignControlList(screenHeight, screenWidth, wList),
                ),
              ):currentScreen=="Analysis"?
              Expanded(
                flex: 134,
                child: Column(
                  children: [
                    Expanded(
                        flex: 40,
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 7,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                        child: Text("Artist Fee - PER POST", style: headingTextTitlesLS),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("\$$artistFee", style: headingTextTitlesBGAA),
                                            Text("Fee Category: $artistFeeType"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            setArtistFee(context, screenHeight, screenWidth);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Container(
                                              height: 50,
                                              width: 130,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [
                                                      Color(0xff000026),
                                                      Color(0xff000026),
                                                    ],
                                                  )
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                child: Center(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(
                                                          Icons.edit_note_rounded,
                                                          color: Colors.white,
                                                          size: 22.0,
                                                          semanticLabel: 'Friends',
                                                        ),
                                                        const SizedBox(
                                                          width: 7,
                                                        ),
                                                        Text("Edit", style: headingTextTitlesW),
                                                      ],
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: 5
                                        ),
                                        InkWell(
                                          onTap: (){
                                            requestAIFee(context, screenHeight, screenWidth);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Container(
                                              height: 50,
                                              width: 130,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [
                                                      Color(0xff000026),
                                                      Color(0xff000026),
                                                    ],
                                                  )
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                child: Center(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(
                                                          Icons.all_inclusive_rounded,
                                                          color: Colors.white,
                                                          size: 22.0,
                                                          semanticLabel: 'Friends',
                                                        ),
                                                        const SizedBox(
                                                          width: 7,
                                                        ),
                                                        Text("AI FEE", style: headingTextTitlesW),
                                                      ],
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        color: Colors.white,
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Brand Reach Value - \$1 Million Followers"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 85,
                      child: Container(
                        color: Colors.white,
                        child: data!=null?Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(minimum: 0, maximum: 8000, interval: 10),
                                series: <CartesianSeries<SubscriberSeries, String>>[
                                  ColumnSeries<SubscriberSeries, String>(
                                      dataSource: data,
                                      xValueMapper: (SubscriberSeries data, _) => data.year,
                                      yValueMapper: (SubscriberSeries data, _) => data.subscribers,
                                      pointColorMapper: (SubscriberSeries data, _) => data.barColor,)
                                ])
                        ):const Text(""),
                      ),
                    ),
                  ],
                ),
              ):currentScreen=="Explore"?
              Expanded(
                flex: 134,
                child: Container(
                  color: Colors.white,
                  child: iEList.isNotEmpty?showIndustryExploreList(screenHeight, screenWidth, iEList):const Text(""),
                ),
              ):currentScreen=="Profile"?
              Expanded(
                flex: 134,
                child: Container(
                  color: Colors.white,
                  child: showProfileList(screenHeight, screenWidth, profileList),
                ),
              ):const Text(""),
              const SizedBox(
                height: 6,
              ),
              Expanded(
                flex: 18,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    setState((){
                                      currentScreen="Work";
                                    });
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.work,
                                      color: currentScreen=="Work"?darkBlue:lG,
                                      size: 30.0,
                                      semanticLabel: 'Home',
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    setState((){
                                      currentScreen="Analysis";
                                    });
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.card_giftcard_rounded,
                                      color: currentScreen=="Analysis"?darkBlue:lG,
                                      size: 30.0,
                                      semanticLabel: 'Home',
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    setState((){
                                      currentScreen="Explore";
                                    });
                                  },
                                  child: Center(
                                    child:Icon(
                                      Icons.explore,
                                      color: currentScreen=="Explore"?darkBlue:lG,
                                      size: 30.0,
                                      semanticLabel: 'Home',
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    setState((){
                                      currentScreen="Profile";
                                    });
                                  },
                                  child: Center(
                                    child:  sF.path.isNotEmpty?
                                    Container(
                                      width: 30.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(sF),
                                        ),
                                      ),
                                      child:const Text(""),
                                    ):Container(
                                      width: 30.0,
                                      height: 30.0,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        "assets/graphics/human-icon.png",
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ),
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ):Column(
            children: [
              Expanded(
                flex: 160,
                child: showCampaignDetailList(screenHeight, screenWidth, clickedC),
              ),
              const SizedBox(
                height: 6,
              ),
              Expanded(
                flex: 18,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    setState((){
                                      currentScreen="Work";
                                    });
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.work,
                                      color: currentScreen=="Work"?darkBlue:lG,
                                      size: 30.0,
                                      semanticLabel: 'Home',
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    setState((){
                                      currentScreen="Analysis";
                                    });
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.card_giftcard_rounded,
                                      color: currentScreen=="Analysis"?darkBlue:lG,
                                      size: 30.0,
                                      semanticLabel: 'Home',
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    setState((){
                                      currentScreen="Explore";
                                    });
                                  },
                                  child: Center(
                                    child:Icon(
                                      Icons.explore,
                                      color: currentScreen=="Explore"?darkBlue:lG,
                                      size: 30.0,
                                      semanticLabel: 'Home',
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    setState((){
                                      currentScreen="Profile";
                                    });
                                  },
                                  child: Center(
                                    child: sF.path.isNotEmpty?Container(
                                      width: 30.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(sF),
                                        ),
                                      ),
                                      child:const Text(""),
                                    ):Container(
                                      width: 30.0,
                                      height: 30.0,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        "assets/graphics/human-icon.png",
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget appSignature(int type){
    return Column(
      children: [
        type==0?Image.asset(
          "assets/graphics/app_icon_d.png",
          fit: BoxFit.cover,
          width: 70,
          height: 70,
        ):Image.asset(
          "assets/graphics/app_icon_db.png",
          fit: BoxFit.cover,
          width: 70,
          height: 70,
        ),
        const SizedBox(
          height: 3.0,
        ),
        Center(
          child: Text("Version $appVersion", style: userSignOnTextField,),
        ),
        const SizedBox(
          height: 3.0,
        ),
        Center(
          child: Text("©2018-2023 Smatter LLP", style: userSignOnTextField,),
        ),
      ],
    );
  }
}
class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}
class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: Colors.white,
      strokeWidth: 5,);
  }
}
class SubscriberSeries {
  final String year;
  final int subscribers;
  final Color? barColor;

  SubscriberSeries(
      {
        required this.year,
        required this.subscribers,
        required this.barColor
      }
      );
}
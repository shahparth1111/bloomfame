import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';
import 'text_styles.dart';
import 'java_methods.dart';
import 'verifyotp.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class UserSignOn extends StatefulWidget {
  static String phoneNumber="";
  static bool isTestAccount = false;
  const UserSignOn({Key? key}) : super(key: key);

  @override
  State<UserSignOn> createState() => _UserSignOnState();
}
class _UserSignOnState extends State<UserSignOn> {
  bool isSearchTyped=false, isPhoneNumberCorrect=false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  JavaMethodsCustom sBase = JavaMethodsCustom();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController phoneNumberControllerPhone = TextEditingController();
  List<String> filteredList=<String>[];
  List<String> newFilteredList=<String>[];
  dynamic path;
  String emailOTP = "";
  final TextEditingController manualOTPController = TextEditingController();
  final otpController = TextEditingController();

  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }
  @override
  void initState() {
    super.initState();
    startInitialization();
  }
  @override
  void setState(VoidCallback fn){
    if(mounted){
      super.setState(fn);
    }
  }
  void startInitialization()async{
    path = await _localPath;
    generateOTP();
  }
  void generateOTP(){
    var rndnumber="";
    var rnd= new Random();
    for (var i = 0; i < 6; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    emailOTP = rndnumber;
  }
  void hideKeyboard(){
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }catch(exception){}
  }
  void openPrivacyPolicy()async {
    const url = 'https://smatter.co.uk/privacy-policy.html';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 120,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text('Unknown Error', style: userSignOnPhoneVerificationTitle, textAlign: TextAlign.center,),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        },
      );
    }
  }
  void openTerms()async {
    const url = 'https://smatter.co.uk/terms.html';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 120,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text('Unknown Error', style: userSignOnPhoneVerificationTitle, textAlign: TextAlign.center,),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        },
      );
    }
  }
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
  void showDynamicMessage(String messageText, bool isError){
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
                              padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(messageText, style: isError?userSignOnOccupationTitleGreySLW:userSignOnOccupationTitleGreySL,),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffFFFFFF),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Expanded(
                flex: 1,
                child: Text(""),
              ),
              const Expanded(
                flex: 2,
                child: Icon(
                  Icons.remove,
                  color: nightModeGrey,
                  size: 20.0,
                  semanticLabel: 'Home',
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: darkBlue,
                      borderRadius: BorderRadius.all(Radius.circular(40.0)
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.security,
                            color: Colors.white,
                            size: 20.0,
                            semanticLabel: 'Home',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("Identity Verification", style: userSignOnPhoneVerificationTitle),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 60,
                child: Container(
                  decoration: const BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.only(
                        topLeft:  Radius.circular(40.0),
                        topRight: Radius.circular(40.0)
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/graphics/otpbannericon.png",
                          width: 130.0,
                          height: 130.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Add your email address. We'll send you a", style: userSignOnText,),
                      Text("verification code so we know you're real.", style: userSignOnText,),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
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
                              GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(
                                      Icons.password,
                                      color: darkGreen,
                                      size: 30.0,
                                      semanticLabel: 'Correct',
                                    ),
                                  )
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 8,
                                child: SizedBox(
                                    height: 50,
                                    child: TextField(
                                      controller: phoneNumberControllerPhone,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (text){
                                        if(text.contains(".com") || text.contains(".co.in") || text.contains(".org")
                                        || text.contains(".business") || text.contains(".io") || text.contains(".net")
                                        || text.contains(".in") || text.contains(".gov")){
                                          setState(() {
                                            hideKeyboard();
                                            isPhoneNumberCorrect=true;
                                          });
                                        }
                                        else{
                                          setState(() {
                                            isPhoneNumberCorrect=false;
                                          });
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email Address",
                                          labelStyle: TextStyle(fontSize: 24)),
                                    )),
                              ),
                              Expanded(
                                flex: 2,
                                child: isPhoneNumberCorrect?const Center(
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    color: darkGreen,
                                    size: 22.0,
                                    semanticLabel: 'Correct',
                                  ),
                                ):const Icon(
                                  Icons.highlight_remove_outlined,
                                  color: darkRed,
                                  size: 22.0,
                                  semanticLabel: 'Cross',
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Read our ", style: userSignOnTextTerms,),
                          GestureDetector(
                            onTap: (){
                              openPrivacyPolicy();
                            },
                            child: Text("Privacy Policy ", style: userSignOnTextBlue,),
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: Text(
                                "Tap \"Agree and Continue\" to",
                                overflow: TextOverflow.ellipsis,
                                style: userSignOnTextTerms,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("accept the ", style: userSignOnTextTerms,),
                          GestureDetector(
                            onTap: (){
                              openTerms();
                            },
                            child: Text("Terms of Service", style: userSignOnTextBlue,),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: (){
                            String finalPhoneNumber= phoneNumberControllerPhone.text;
                            UserSignOn.phoneNumber = finalPhoneNumber.trim();
                            if(isPhoneNumberCorrect) {
                              if(finalPhoneNumber=="business@bloomfame.com"){
                                UserSignOn.isTestAccount=true;
                                sBase.writeFilesRealtime(path, "User", "Details", "NoID", "p1720611507997", false);
                                sBase.writeFilesRealtime(path, "User", "Details", "AccountType", "Artist", false);
                                sBase.writeFilesRealtime(path, "User", "Details", "Verification", "Successful", false);
                                sBase.writeFilesRealtime(path, "User", "Details", "UserIdentification", "Successful", false);
                                sBase.writeFilesRealtime(path, "User", "Details", "Name", "Bloomfame", false);
                                sBase.writeFilesRealtime(path, "User", "Business", "Categories", "General", false);
                                _pushPage(context, const HomePage());
                              }
                              else{
                                showDynamicMessage("Sending OTP..", false);
                                executeVerification(context, finalPhoneNumber);
                              }
                            }
                            else{
                              showDynamicMessage("Incorrect Email..", true);
                            }
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
                                        Text("Agree and Continue", style: headingTextTitlesW),
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
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: const Color(0xffFFFFFF),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: Text("Step 1/2", style: userSignOnTextTerms,),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: Text("Step 2/2", style: userSignOnTextTerms,),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                  height: 7,
                                  decoration: const BoxDecoration(
                                    color: darkBlue,
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: phoneBoxGrey,
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    controller.dispose();
    phoneNumberController.dispose();
    phoneNumberControllerPhone.dispose();
    super.dispose();
  }
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/graphics/eotp.txt');
  }
  void executeVerification(BuildContext context, String finalPhoneNumber)async{
    sendEmail(context, finalPhoneNumber);
  }

  void sendEmail(BuildContext context, String finalPhoneNumber) async {
    String username = 'bloomfame.official@gmail.com'; //Your Email
    String password = 'ielxavwbieipbznv';
    final smtpServer = gmail(username, password);
    String hM = await loadAsset();
    generateOTP();
    VerifyOTP.verificationId=emailOTP;
    hM = hM.replaceAll("emailOTP", emailOTP);
    final message = Message()
      ..from = Address(username, 'Bloomfame Official')
      ..recipients.add(finalPhoneNumber)
      ..subject = 'Email verification code: $emailOTP'
      ..html = hM;
    try {
      await send(message, smtpServer);
      if(Navigator.canPop(context)){
        Navigator.pop(context);
      }
      _pushPage(context, const VerifyOTP());
    } on MailerException catch (e) {}
  }
}
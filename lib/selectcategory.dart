import 'dart:io';

import 'package:bloomfame/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'text_styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibration/vibration.dart';
import 'java_methods.dart';
import 'usersignon.dart';

class SelectCategory extends StatefulWidget {
  static String verificationId="";
  static bool alreadyVerified=false;
  static bool artistSelected=false, agencySelected=false, brandSelected=false;
  static FirebaseAuth auth = FirebaseAuth.instance;
  const SelectCategory({super.key});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}
class _SelectCategoryState extends State<SelectCategory>
    with WidgetsBindingObserver, TickerProviderStateMixin{
  FirebaseApp defaultApp = Firebase.app();
  final Color nightModeGrey = const Color(0xff2E2F31);
  final Color colorB = const Color(0xff000000);
  int charEnteredCount=0, tM=59;
  dynamic path;
  JavaMethodsCustom sBase = JavaMethodsCustom();
  String currentScreen="AccountType", videoPath="#", userNoID="#", selectedCategory="General";
  bool isPhoneNumberCorrect=false, imageSelected=false;
  TextEditingController phoneNumberControllerPhone=TextEditingController();
  TextEditingController instagramController=TextEditingController();
  TextEditingController youtubeController=TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController phoneNumberControllerR = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late File sF;
  bool isSearchTyped=false, isProfileAdded=false;
  int index = 0;
  late FirebaseDatabase database;
  List<String> filteredList= <String>[];
  List<String> newFilteredList= <String>[];
  String initialCountry="in", selectedCountryCode="+91", verificationId="";
  bool isNameCorrect=false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    database = FirebaseDatabase.instanceFor(app: defaultApp, databaseURL: 'https://bloomfame-ny-default-rtdb.firebaseio.com');
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
    userNoID=sBase.getFirstLineSync(path, "User", "Details", "NoID");
    if(userNoID=="#"){
      userNoID = DateTime.now().millisecondsSinceEpoch.toString();
      sBase.writeFilesRealtime(path, "User", "Details", "NoID", userNoID, false);
    }
    String fPathSaved = sBase.getFirstLineSync(path, "User", "Profile", "DownloadedImageFilePath");
    if(fPathSaved!="#"){
      setState((){
        imageSelected=true;
        sF = File(fPathSaved);
      });
    }
  }
  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }
  void slightVibrate(){
    try{
      Vibration.vibrate(duration: 5);
    }catch(exception){}
  }
  void hideKeyboard(){
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }catch(exception){}
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
              setState((){
                imageSelected=true;
              });
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
  void _selectCountryCode(BuildContext context) {
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
                builder: (BuildContext context, StateSetter setStateC){
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
                            textAlign: TextAlign.start,
                            onChanged: (text) {
                              setStateC(() {
                                setState((){
                                  newFilteredList = sBase.countryListA.where((u) =>
                                  (u.toLowerCase().contains(text.toLowerCase())
                                  )).toList();
                                });
                              });
                            },
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Search Country',
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
                              itemCount: newFilteredList.isEmpty?sBase.countryListA.length:newFilteredList.length,
                              itemBuilder: (_, index) {
                                String countryLine="", countryName="", imageName="", countryCode="";
                                if(newFilteredList.isNotEmpty){
                                  countryLine = newFilteredList[index];
                                  countryName = countryLine.substring(0, countryLine.indexOf("~"));
                                  imageName = (countryLine.substring(countryLine.indexOf("~")+1, countryLine.lastIndexOf("~"))).toLowerCase();
                                  countryCode = "+${countryLine.substring(countryLine.lastIndexOf("~")+1)}";
                                }
                                else{
                                  countryLine = sBase.countryListA.elementAt(index);
                                  countryName = countryLine.substring(0, countryLine.indexOf("~"));
                                  imageName = (countryLine.substring(countryLine.indexOf("~")+1, countryLine.lastIndexOf("~"))).toLowerCase();
                                  countryCode = "+${countryLine.substring(countryLine.lastIndexOf("~")+1)}";
                                }
                                return GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    FocusScope.of(context).unfocus();
                                    if(Navigator.canPop(context)){
                                      Navigator.pop(context);
                                    }
                                    countryLine = newFilteredList.isEmpty?sBase.countryListA.elementAt(index):newFilteredList[index];
                                    int cLIO = countryLine.lastIndexOf("~");
                                    int cFI = countryLine.indexOf("~");
                                    countryName = countryLine.substring(0, cFI);
                                    setState(() {
                                      initialCountry = (countryLine.substring(cFI+1, cLIO)).toLowerCase();
                                      selectedCountryCode = "+${countryLine.substring(cLIO+1)}";
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                              "assets/flags/$imageName.png",
                                            ),
                                            radius: 27,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                child: Text("$countryName", style: userSignOnCountryList,),
                                              ),
                                              Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  child: Text("$countryCode"),
                                                ),
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
  @override
  void dispose() {
    super.dispose();
  }
  void onCategoryClicked()async{
    setState(() {
      selectedCategory="General";
      currentScreen="UserName";
    });
    await FirebaseMessaging.instance.subscribeToTopic(selectedCategory);
    sBase.writeFilesRealtime(path, "User", "Business", "Categories", selectedCategory, false);
    Navigator.pop(context);
  }
  void selectCategoryList(){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35.0))),
        backgroundColor: darkBlue,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:18 ),
          child: SingleChildScrollView(
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
                        padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                        child: Text("Select Category", style: userSignOnOccupationTitleGreySLWN),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: GestureDetector(
                        onTap: () async {

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
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                          flex: 25,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text("General", style: userSignOnOccupationTitleGreySLWN,)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Construction", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Healthcare", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Food Industry", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Media Industry", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Finance and Insurance", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Transportation", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Agriculture", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Chemical Substance", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Education", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Educational Services", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Financial Services", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Hospitality Industry", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Metal fabrication", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Pharmaceutical", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Information and Communications Technology", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Entertainment", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Fashion", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Mining", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Industrial Electronics", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Food and Beverages", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Recreation and sports entertainment", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    onCategoryClicked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: darkGrey,
                            size: 30.0,
                            semanticLabel: 'Friends',
                          ),
                        ),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Transport", style: userSignOnOccupationTitleGreySLWN,)

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        )
    );
  }
  Widget logicalAccount(BuildContext context, double screenHeight, double screenWidth){
    if(currentScreen=="AccountType"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      _pushPage(context, const UserSignOn());
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Image.asset(
                        "assets/graphics/backbuttonblack.png",
                        width: 45,
                        height: 35,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              )
          ),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.center,
              child: Text("Account Type", style: phoneTitle,),
            ),
          ),
          Expanded(
            flex: 55,
            child: Center(
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                            child: InkWell(
                              onTap: (){
                                if(SelectCategory.artistSelected){
                                  setState(() {
                                    SelectCategory.brandSelected=false;
                                    SelectCategory.artistSelected=false;
                                    SelectCategory.agencySelected=false;
                                  });
                                }
                                else{
                                  setState(() {
                                    SelectCategory.brandSelected=false;
                                    SelectCategory.artistSelected=true;
                                    SelectCategory.agencySelected=false;
                                  });
                                }
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                                  height: screenHeight/6,
                                  width: screenHeight/6,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: SelectCategory.artistSelected?darkBlue.withOpacity(0.4):lG.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.account_circle_rounded,
                                        color: SelectCategory.artistSelected?darkBlue:lG,
                                        size: screenHeight/10,
                                        semanticLabel: 'Home',
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text("Artist", style: SelectCategory.artistSelected?headingTextTitlesGSB:headingTextTitlesGS)
                                    ],
                                  )
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                              child: InkWell(
                                onTap: (){
                                  if(SelectCategory.agencySelected){
                                    setState(() {
                                      SelectCategory.brandSelected=false;
                                      SelectCategory.artistSelected=false;
                                      SelectCategory.agencySelected=false;
                                    });
                                  }
                                  else{
                                    setState(() {
                                      SelectCategory.agencySelected=true;
                                      SelectCategory.brandSelected=false;
                                      SelectCategory.artistSelected=false;
                                    });
                                  }
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                                    height: screenHeight/6,
                                    width: screenHeight/6,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: SelectCategory.agencySelected?darkBlue.withOpacity(0.4):lG.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.business,
                                          color: SelectCategory.agencySelected?darkBlue:lG,
                                          size: screenHeight/10,
                                          semanticLabel: 'Home',
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text("Agency", style: SelectCategory.agencySelected?headingTextTitlesGSB:headingTextTitlesGS)
                                      ],
                                    )
                                ),
                              )
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                              child: InkWell(
                                onTap: (){
                                  if(SelectCategory.brandSelected){
                                    setState(() {
                                      SelectCategory.brandSelected=false;
                                      SelectCategory.artistSelected=false;
                                      SelectCategory.agencySelected=false;
                                    });
                                  }
                                  else{
                                    setState(() {
                                      SelectCategory.brandSelected=true;
                                      SelectCategory.artistSelected=false;
                                      SelectCategory.agencySelected=false;
                                    });
                                  }
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                                    height: screenHeight/6,
                                    width: screenHeight/6,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: SelectCategory.brandSelected?darkBlue.withOpacity(0.4):lG.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.branding_watermark_rounded,
                                          color: SelectCategory.brandSelected?darkBlue:lG,
                                          size: screenHeight/10,
                                          semanticLabel: 'Home',
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text("Brand", style: SelectCategory.brandSelected?headingTextTitlesGSB:headingTextTitlesGS,)
                                      ],
                                    )
                                ),
                              )
                          ),
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: (){
                    if(SelectCategory.artistSelected || SelectCategory.agencySelected || SelectCategory.brandSelected){
                      setState((){
                        currentScreen="SelectCategory";
                      });
                      if(SelectCategory.artistSelected){
                        sBase.writeFilesRealtime(path, "User", "Details", "AccountType", "Artist", false);
                        database.ref('Database/Users/$userNoID/AccountType').set("Artist");
                      }
                      else if(SelectCategory.agencySelected){
                        sBase.writeFilesRealtime(path, "User", "Details", "AccountType", "Agency", false);
                        database.ref('Database/Users/$userNoID/AccountType').set("Agency");
                      }
                      else {
                        sBase.writeFilesRealtime(path, "User", "Details", "AccountType", "Brand", false);
                        database.ref('Database/Users/$userNoID/AccountType').set("Brand");
                      }
                    }
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
                                Text("Continue", style: headingTextTitlesW),
                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }
    else if(currentScreen=="SelectCategory"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      _pushPage(context, const UserSignOn());
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Image.asset(
                        "assets/graphics/backbuttonblack.png",
                        width: 45,
                        height: 35,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              )
          ),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.center,
              child: Text("Select Category", style: phoneTitle,),
            ),
          ),
          Expanded(
            flex: 10,
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: (){
                    selectCategoryList();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
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
                                  Icons.category_rounded,
                                  color: Colors.white,
                                  size: 22.0,
                                  semanticLabel: 'Friends',
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text("Business Category", style: headingTextTitlesW),
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
          const Expanded(
            flex: 55,
            child: Text(""),
          ),
        ],
      );
    }
    else if(currentScreen=="UserName"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      setState((){
                        currentScreen="AccountType";
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Image.asset(
                        "assets/graphics/backbuttonblack.png",
                        width: 45,
                        height: 35,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              )
          ),
          Expanded(
            flex: 8,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: SelectCategory.artistSelected?Text("Your Name", style: phoneTitle,):SelectCategory.agencySelected?Text("Agency Name", style: phoneTitle,):SelectCategory.brandSelected?Text("Brand Name", style: phoneTitle,):Text("Your Name", style: phoneTitle,),
              ),
            ),
          ),
          Expanded(
            flex: 60,
            child: Center(
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                        children: [
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
                                      child: const Padding(
                                        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                        child: Icon(
                                          Icons.abc_rounded,
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
                                          keyboardType: TextInputType.name,
                                          onChanged: (text){
                                            if(text.length>4){
                                              setState(() {
                                                isPhoneNumberCorrect=true;
                                              });
                                            }
                                            else{
                                              setState(() {
                                                isPhoneNumberCorrect=false;
                                              });
                                            }
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: SelectCategory.artistSelected?"Your Name":SelectCategory.agencySelected?"Agency Name":SelectCategory.brandSelected?"Brand Name":"Your Name",
                                              labelStyle: const TextStyle(fontSize: 24)),
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
                        ],
                      ),
                  )
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  String enteredName = phoneNumberControllerPhone.text.toString();
                  sBase.writeFilesRealtime(path, "User", "Details", "Name", enteredName, false);
                  if(SelectCategory.artistSelected){
                    sBase.writeFilesRealtime(path, "User", "Type", "Artist", enteredName, false);
                  }
                  else if(SelectCategory.agencySelected){
                    sBase.writeFilesRealtime(path, "User", "Type", "Agency", enteredName, false);
                  }
                  else{
                    sBase.writeFilesRealtime(path, "User", "Type", "Brand", enteredName, false);
                  }
                  database.ref('Database/Users/$userNoID/UserDetails/Name').set(enteredName);
                  setState((){
                    currentScreen="ProfilePicture";
                  });
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
                              Text("Continue", style: headingTextTitlesW),
                            ],
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
    else if(currentScreen=="ProfilePicture"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      setState((){
                        currentScreen="UserName";
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Image.asset(
                        "assets/graphics/backbuttonblack.png",
                        width: 45,
                        height: 35,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              )
          ),
          Expanded(
            flex: 8,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text("Profile Picture", style: phoneTitle,),
              ),
            ),
          ),
          Expanded(
            flex: 60,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Center(
                      child: imageSelected?Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: FileImage(sF),
                          ),
                        ),
                        child:const Text(""),
                      ):Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: const BoxDecoration(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          _onImageButtonPressed();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Container(
                            height: 55,
                            width: 55,
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
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload_rounded,
                                      color: Colors.white,
                                      size: 27.0,
                                      semanticLabel: 'Friends',
                                    ),
                                  ],
                                ),
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
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  setState((){
                    currentScreen="AddSocialMedia";
                  });
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
                              Text("Continue", style: headingTextTitlesW),
                            ],
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    }
    else if(currentScreen=="AddSocialMedia"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      _pushPage(context, const UserSignOn());
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Image.asset(
                        "assets/graphics/backbuttonblack.png",
                        width: 45,
                        height: 35,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              )
          ),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.center,
              child: Text("Add Social Media", style: phoneTitle,),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: Text("https://www.instagram.com/", style: headingTextTitlesGAB,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                controller: instagramController,
                                keyboardType: TextInputType.name,
                                onChanged: (text){
                                  if(instagramController.text.isEmpty && youtubeController.text.isEmpty){
                                    setState((){
                                      isProfileAdded=false;
                                    });
                                  }
                                  else{
                                    setState((){
                                      isProfileAdded=true;
                                    });
                                  }
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Instagram Profile URL",
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
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                  child: Text("https://www.youtube.com/@", style: headingTextTitlesGAB,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                controller: youtubeController,
                                keyboardType: TextInputType.name,
                                onChanged: (text){
                                  if(instagramController.text.isEmpty && youtubeController.text.isEmpty){
                                    setState((){
                                      isProfileAdded=false;
                                    });
                                  }
                                  else{
                                    setState((){
                                      isProfileAdded=true;
                                    });
                                  }
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Youtube Username",
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
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                   String youtube = youtubeController.text.toString();
                   String instagram = instagramController.text.toString();
                   if(instagram.isNotEmpty){
                     instagram = "https://instagram.com/$instagram";
                   }
                   if(youtube.isNotEmpty){
                     youtube = "https://youtube.com/@$youtube";
                   }
                   sBase.writeFilesRealtime(path, "User", "WebURL", "Instagram", instagram, false);
                   sBase.writeFilesRealtime(path, "User", "WebURL", "Youtube", youtube, false);
                   setState((){
                     currentScreen="PhoneNumber";
                   });
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
                              Text("Continue", style: headingTextTitlesW),
                            ],
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          !isProfileAdded?Text("Please add any one of above", style: headingTextTitlesGSB,):const Text(""),
          const Expanded(
            flex: 40,
            child: Text(""),
          ),
        ],
      );
    }
    else if(currentScreen=="PhoneNumber"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      _pushPage(context, const UserSignOn());
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Image.asset(
                        "assets/graphics/backbuttonblack.png",
                        width: 45,
                        height: 35,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              )
          ),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.center,
              child: Text("Phone Number", style: phoneTitle,),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Add your phone number. We'll call you to", style: userSignOnText,),
                Text("verify your account once you sign with a brand.", style: userSignOnText,),
              ],
            ),
          ),
          Expanded(
            flex: 13,
            child: Column(
              children: [
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
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 50,
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/flags/$initialCountry.png",
                                      width: 25.0,
                                      height: 20.0,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text("$selectedCountryCode"),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                      size: 20.0,
                                      semanticLabel: 'Drop-down arrow',
                                    ),
                                  ],
                                ),
                              )),
                          onTap: (){
                            _selectCountryCode(context);
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 8,
                            child: Container(
                                height: 50,
                                child: TextField(
                                  controller: phoneNumberControllerR,
                                  keyboardType: TextInputType.number,
                                  onChanged: (text){
                                    if(text.length==10){
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
                                      hintText: "Mobile Number",
                                      labelStyle: TextStyle(fontSize: 24)),
                                ))
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
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: InkWell(
                            onTap: (){
                              String finalPhoneN = selectedCountryCode+phoneNumberControllerR.text;
                              sBase.writeFilesRealtime(path, "User", "Details", "PhoneNumberM", finalPhoneN, false);
                              String emailU = sBase.getFirstLineSync(path, "User", "Details", "Email");
                              String uID = sBase.getFirstLineSync(path, "User", "Details", "UserID");
                              database.ref('Database/Users/$finalPhoneN/Email').set(emailU);
                              database.ref('Database/Users/$finalPhoneN/UserID').set(uID);
                              database.ref("Database/Users/$uID/UserDetails/Phone").set(finalPhoneN);
                              _pushPage(context, const HomePage());
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Container(
                                height: 50,
                                width: 200,
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
                                            Icons.phone_forwarded_rounded,
                                            color: Colors.white,
                                            size: 22.0,
                                            semanticLabel: 'Friends',
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Text("Continue", style: headingTextTitlesW),
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
                )
              ],
            ),
          ),
          const Expanded(
            flex: 33,
            child: Text(""),
          ),
        ],
      );
    }
    else{
      return const Text("");
    }
  }
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return PopScope(
      onPopInvoked: (bV) async {
        if (currentScreen=="UserName") {
          setState((){
            currentScreen="AccountType";
          });
        }
        else if (currentScreen=="ProfilePicture") {
          setState((){
            currentScreen="UserName";
          });
        }
        else if (currentScreen=="VerifyUser") {
          setState((){
            currentScreen="ProfilePicture";
          });
        }
        else if (currentScreen=="Camera") {
          setState((){
            currentScreen="VerifyUser";
          });
        }
        else if (currentScreen=="PlayVideo") {
          setState((){
            currentScreen="Camera";
          });
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
                                      Text("Exit Bloomfame?", style: userSignOnOccupationTitle, textAlign: TextAlign.center,),
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
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xffFAD0CF),
          body: logicalAccount(context, screenHeight, screenWidth),
        ),
      ),
    );
  }
}
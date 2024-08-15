import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:nitoons/UI Actor/role/page-five/skin-tone-page.dart';
import 'package:nitoons/UI Actor/role/page-four/gender_page.dart';
import 'package:nitoons/UI Actor/role/page-one/role-page.dart';
import 'package:nitoons/UI Actor/role/page-three/age_page.dart';
import 'package:nitoons/UI Actor/role/page-two/name_page.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/data/api_layer.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/utilities/api_urls.dart';
import 'package:path/path.dart';
import 'package:pmvvm/pmvvm.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import '../../UI Producer/producer_create_profile/producer_company_location.dart';
import '../../UI Producer/producer_create_profile/producer_companyinfo.dart';
import '../../UI Producer/producer_create_profile/producer_filmmaker_profile.dart';
import '../../UI Producer/producer_create_profile/producer_name_page.dart';
import '../../UI Producer/producer_create_profile/producer_upload_picture.dart';
import '../../utilities/api_status_response.dart';
import '../../utilities/app_util.dart';

class SignUpRoleViewmodel extends ViewModel {
  final apiLayer = locator<ApiLayer>();
  final storedValue = locator<SecureStorageHelper>();
  bool isButtonActive = false;

  Uint8List? thumbnail;
  final PageController pageController = PageController(initialPage: 0);
  late TextEditingController producerfirstnameController;
  late TextEditingController producerlastnameController;
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;
  late TextEditingController dateController;
  late TextEditingController groupNameController;
  late TextEditingController groupDescriptionController;
  late TextEditingController filmmakerprofileController;
  late TextEditingController companynameController;
  late TextEditingController companyemailController;
  late TextEditingController companyphonenumberController;
  late TextEditingController companyaddressController;
  late TextEditingController companycityController;
  late TextEditingController companystateController;
  late TextEditingController companycountryController;
  int activePage = 0;
  final List<Widget> _actorPages = [
    RolePage(),
    NamePage(),
    AgePage(),
    GenderPage(),
    SkinTonePage(),
  ];
  final List<Widget> _producerPages = [
    RolePage(),
    ProducerNamePage(),
    ProducerUploadProfilePicture(),
    ProducerFilmmakerProfile(),
    ProducerCompanyinfo(),
    ProducerCompanyLocation(),
  ];

  List<Widget> _pages = [];
  List<Widget> get pages => _pages;

  final focusNode = FocusNode();
  final producerFormKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final Keyform = GlobalKey<FormState>();
  final producerFilmMakerFormKey = GlobalKey<FormState>();
  final companyInformationFormKey = GlobalKey<FormState>();
  final companyLocationFormKey = GlobalKey<FormState>();
  late List<bool> isButtonActiveList;

// Page navigation
  int _selectedPageIndex = -1;
  int get selectedPageIndex => _selectedPageIndex;
  setPageIndex(int val) {
    _selectedPageIndex = val;
    notifyListeners();
  }

// actor or producer selection
  String? _selectedIndex;
  String? get selectedIndex => _selectedIndex;
  void selectIndex(String value) {
    _selectedIndex = value;
    _pages = (value == 'Actor') ? _actorPages : _producerPages;
    notifyListeners();
    updateColorState();
  }

  ValueNotifier<String?> selectedProfessionNotifier =
      ValueNotifier<String?>(null);

// Playable age selection
  String? _selectedPlayableAge;
  String? get selectedPlayableAge => _selectedPlayableAge;
  void selectPlayableAge(String value) {
    _selectedPlayableAge = value;
    notifyListeners();
  }

// background actor
  String? _selectedIndexBackgroundActorIndex;
  String? get selectedIndexBackgroundActorIndex =>
      _selectedIndexBackgroundActorIndex;
  void selectIndexBackgroundActorIndex(String value) {
    _selectedIndexBackgroundActorIndex = value;
    notifyListeners();
    updateColorStateBackgroundActor();
  }
void updateColorStateBackgroundActor() {
    final newIsButtonActive =
        _selectedIndexBackgroundActorIndex != null || _selectedIndexBackgroundActorIndex != null;
    if (isButtonActive != newIsButtonActive) {
      isButtonActive = newIsButtonActive;
      notifyListeners();
    }
  }

  // Gender of actor
  String? _selectedGenderActorIndex;
  String? get selectedGenderActorIndex => _selectedGenderActorIndex;
  void selectGenderActorIndex(String value) {
    _selectedGenderActorIndex = value;
    notifyListeners();
    updateColorState();
  }

  // skin color grade selection

  // String? _selectedHexColor;
  // String? get selectedHexColor => _selectedHexColor;
  // void setSelectedColor(String hexColor) {
  //   _selectedHexColor = hexColor;
  //   notifyListeners();
  // }

  // Use ValueNotifier for the selected color
  ValueNotifier<String?> selectedColorNotifier = ValueNotifier<String?>(null);

  // Constructor
  SignUpRoleViewmodel() {
    _pages = (_selectedIndex == 'Producer') ? _producerPages : _actorPages;

    selectedColorNotifier.addListener(() {
      notifyListeners();
    });
  }

  // Method to select color
  // String? _selectedColorIndex;
  // String? get selectedColorIndex => _selectedColorIndex;
  void selectColor(String hexColor) {
    selectedColorNotifier.value = hexColor;
  }

//Date picker
  DateTime? selectedDate;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              // override MaterialApp ThemeData
              colorScheme: ColorScheme.light(
                primary: black, //header and selected day background color
                onPrimary: white, // titles and
                onSurface: black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // ok , cancel    buttons
                ),
              ),
            ),
            child: child!,
          );
        });
    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;

      // Ensure day and month are always two digits
      String day = pickedDate.day.toString().padLeft(2, '0');
      String month = pickedDate.month.toString().padLeft(2, '0');
      String year = pickedDate.year.toString();

      dateController.text = "$year-$month-$day";
    }
  }

  void init() {
    super.init();
    firstnameController = TextEditingController();
    lastnameController = TextEditingController();
    producerfirstnameController = TextEditingController();
    producerlastnameController = TextEditingController();
    dateController = TextEditingController();
    filmmakerprofileController = TextEditingController();
    companynameController = TextEditingController();
    companyemailController = TextEditingController();
    companyphonenumberController = TextEditingController();
    companyaddressController = TextEditingController();
    companycityController = TextEditingController();
    companystateController = TextEditingController();
    companycountryController = TextEditingController();

    firstnameController.addListener(() {
      final newIsButtonActive = firstnameController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    lastnameController.addListener(() {
      final newIsButtonActive = lastnameController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });

    producerfirstnameController.addListener(() {
      final newIsButtonActive = producerfirstnameController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    producerlastnameController.addListener(() {
      final newIsButtonActive = producerlastnameController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });

    dateController.addListener(() {
      final newIsButtonActive = dateController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    filmmakerprofileController.addListener(() {
      final newIsButtonActive = filmmakerprofileController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    companynameController.addListener(() {
      final newIsButtonActive = companynameController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    companyemailController.addListener(() {
      final newIsButtonActive = companyemailController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    companyphonenumberController.addListener(() {
      final newIsButtonActive = companyphonenumberController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    companyaddressController.addListener(() {
      final newIsButtonActive = companyaddressController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    companycityController.addListener(() {
      final newIsButtonActive = companycityController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    companystateController.addListener(() {
      final newIsButtonActive = companystateController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    companycountryController.addListener(() {
      final newIsButtonActive = companycountryController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
    selectedProfessionNotifier.addListener(() {
      final newIsButtonActive = _selectedIndex;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive as bool;
      }
      notifyListeners();
    });

    pageController.addListener(() {
      final newActivePage = pageController.page?.toInt() ?? 0;
      if (activePage != newActivePage) {
        activePage = newActivePage;
        updateButtonState();
      }
    });
  }

  void updateButtonState() {
    isButtonActive = activePage == pages.length - 1;
    notifyListeners();
  }

  @override
  void dispose() {
    filmmakerprofileController.dispose();
    producerfirstnameController.dispose();
    producerlastnameController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    dateController.dispose();
    pageController.dispose();
    groupDescriptionController.dispose();
    groupNameController.dispose();
    companynameController.dispose();
    companyemailController.dispose();
    companyphonenumberController.dispose();
    companyaddressController.dispose();
    companycityController.dispose();
    companystateController.dispose();
    companycountryController.dispose();
    super.dispose();
    notifyListeners();
  }

  // profile picture upload for producer
  File? image;

  Future uploadPicture() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    this.image = imageTemporary;
    updateColorState();
    notifyListeners();
  }

  void removeImage() {
    image = null;
    notifyListeners();
  }

  Future deleteImage() async {
    image = null;
  }

// clear company text field
  void textClear() {
    companyemailController.clear();
    companynameController.clear();
    companyphonenumberController.clear();
  }

  void updateColorState() {
    final newIsButtonActive =
        _selectedIndex != null || _selectedGenderActorIndex != null;
    if (isButtonActive != newIsButtonActive) {
      isButtonActive = newIsButtonActive;
      notifyListeners();
    }
  }


// Actor Loading State
  bool _isActorLoading = false;
  bool get actorLoading => _isActorLoading;
  setActorLoadingState() {
    _isActorLoading = !_isActorLoading;
    notifyListeners();
  }

// Producer loading state
  bool _loading = false;
  bool get loading => _loading;
  setLoadingState() {
    _loading = !_loading;
    notifyListeners();
  }

  // Return true if validation passes, false otherwise
  Future<bool> validatePageZero() async {
    if (_selectedIndex == null) {
      Fluttertoast.showToast(msg: 'Please select an option');
      return false;
    }
    // Navigate to the next page
    navigateToNextPage();
    return true;
  }

  Future<bool> validatePageOne() async {
    // Check if first name and last name are not empty
    if (_selectedIndex == 'Actor') {
      if (firstnameController.text.isEmpty || lastnameController.text.isEmpty) {
        Fluttertoast.showToast(
            msg: 'Please enter both first name and last name');
        return false;
      } else if (firstnameController.text.isNotEmpty &&
          lastnameController.text.isNotEmpty) {
        // Store first name and last name using SharedPreferences
        SharedPreferencesHelper.storeFirstName(
            firstnameController.text.trim().toString());
        SharedPreferencesHelper.storeLastName(
            lastnameController.text.trim().toString());
        return true;
      }
    } else if (_selectedIndex == 'Producer') {
      if (producerfirstnameController.text.isEmpty ||
          producerlastnameController.text.isEmpty) {
        Fluttertoast.showToast(
            msg: 'Please enter both first name and last name');
        return false;
      } else if (producerfirstnameController.text.isNotEmpty &&
          producerlastnameController.text.isNotEmpty) {
        // Store first name and last name using SharedPreferences
        SharedPreferencesHelper.storeFirstName(
            producerfirstnameController.text.trim().toString());
        SharedPreferencesHelper.storeLastName(
            producerlastnameController.text.trim().toString());
        return true;
      }
    }

    // Store first name and last name using SharedPreferences
    await SharedPreferencesHelper.storeFirstName(
        firstnameController.text.trim().toString());
    await SharedPreferencesHelper.storeLastName(
        lastnameController.text.trim().toString());
    await SharedPreferencesHelper.storeFirstName(
        producerfirstnameController.text.trim().toString());
    await SharedPreferencesHelper.storeLastName(
        producerlastnameController.text.trim().toString());
    // Navigate to the next page
    print("$firstnameController" + "vbbbbbbbbbbbbbbb");
    print("$lastnameController" + "vbbbbbbbbbbbbbbb");
    print("$producerfirstnameController" + "vbbbbbbbbbbbbbbb");
    print("$producerlastnameController" + "vbbbbbbbbbbbbbbb");
    navigateToNextPage();
    return true;
  }

  Future<bool> validatePageTwo() async {
    if (_selectedIndex == 'Actor') {
      if (dateController.text.isEmpty) {
        Fluttertoast.showToast(msg: 'Please enter your actual age');
        return false;
      } else if (dateController.text.isNotEmpty) {
        await SharedPreferencesHelper.storeDateOfBirth(
            dateController.text.trim().toString());
        navigateToNextPage();
        return true;
      }
    } else if (_selectedIndex == 'Producer') {
      navigateToNextPage();
      return true;
    }
    return true;
  }

  Future<bool> validatePageThree() async {
    if (_selectedIndex == 'Producer') {
      if (filmmakerprofileController.text.isEmpty) {
        Fluttertoast.showToast(msg: 'Field cannot be empty');
        return false;
      } else if (filmmakerprofileController.text.isNotEmpty) {
        SharedPreferencesHelper.storeFilmMakerProfile(
            filmmakerprofileController.text.trim().toString());
        navigateToNextPage();
        return true;
      }
    } else if (_selectedIndex == 'Actor') {
      navigateToNextPage();
    }
    return true;
  }

  Future<bool> validatePageFour() async {
    if (companynameController.text.isEmpty ||
        companyemailController.text.isEmpty ||
        companyphonenumberController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'All  are necessary');
      return false;
    } else if (companynameController.text.isNotEmpty &&
        companyemailController.text.isNotEmpty &&
        companyphonenumberController.text.isNotEmpty) {
      SharedPreferencesHelper.storeCompanyName(
          companynameController.text.trim().toString());
      SharedPreferencesHelper.storeCompanyEmail(
          companyemailController.text.trim().toString());
      SharedPreferencesHelper.storeCompanyPhoneNumber(
          companyphonenumberController.text.trim().toString());
      navigateToNextPage();
      return true;
    }

    return true;
  }

  void navigateToNextPage() {
    pageController.animateToPage(
      activePage + 1,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeIn,
    );
  }

  void navigateToActorHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home_page');
  }

  Future<void> createActorAccount(BuildContext context) async {
    setActorLoadingState();

    try {
      final accesstoken = await SecureStorageHelper.getAccessToken();
      final firstnameActor = await SharedPreferencesHelper.getFirstName();
      final lastnameActor = await SharedPreferencesHelper.getLastName();
      final date = await SharedPreferencesHelper.getDateOfBirth();

      final response = await http.post(
        Uri.parse(
            'https://${ApiUrls.baseUrl}${ApiUrls.createUserActorProfile}'),
        body: jsonEncode(<String, String>{
          'profession': _selectedIndex.toString(),
          'first_name': firstnameActor.toString(),
          'last_name': lastnameActor.toString(),
          'actual_age': date.toString(),
          'playable_age': selectedPlayableAge.toString(),
          'gender': selectedGenderActorIndex.toString(),
          'skin_type': selectedColorNotifier.value.toString(),
        }),
        headers: <String, String>{
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final message = data['message'];
        final userId = data['data']['user_id'];
        final profession = data['data']['profession'];

        Fluttertoast.showToast(msg: message);
        await SecureStorageHelper.storeUserId(userId);
        await SharedPreferencesHelper.storeUserProfession(profession);

        navigateToActorHomePage(context);
      } else {
        final data = json.decode(response.body);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
        setActorLoadingState(); // Set loading state back to false after the process is complete
        notifyListeners();
      }
      setActorLoadingState(); // Set loading state back to false after the process is complete
      notifyListeners();
    } catch (error) {
      Fluttertoast.showToast(msg: 'An error occurred: $error');
    } finally {
      setActorLoadingState(); // Set loading state back to false after the process is complete
      notifyListeners();
    }
  }

  navigateToProducerHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/producer_home_page');
  }

  Future<void> createProducer(BuildContext context) async {
    setLoadingState();
    try {
      final accesstoken = await SecureStorageHelper.getAccessToken();
      final firstname = await SharedPreferencesHelper.getFirstName();
      final lastname = await SharedPreferencesHelper.getLastName();
      final filmMakerProfile =
          await SharedPreferencesHelper.getFilmMakerProfile();
      final companyName = await SharedPreferencesHelper.getCompanyName();
      final companyEmail = await SharedPreferencesHelper.getcompanyEmail();
      final companyPhoneNumber =
          await SharedPreferencesHelper.getCompanyPhoneNumber();
      final companyAddress = companyaddressController.text.trim();
      final companyCity = companycityController.text.trim();
      final companyState = companystateController.text.trim();
      final companyCountry = companycountryController.text.trim();

      final url = Uri.https(ApiUrls.baseUrl, ApiUrls.createProducerProfile);
      final request = new http.MultipartRequest('POST', url);
      request.fields.addAll({
        'profession': _selectedIndex.toString(),
        'first_name': firstname.toString(),
        'last_name': lastname.toString(),
        'film_maker_profile': filmMakerProfile.toString(),
        'company_name': companyName.toString(),
        'company_email': companyEmail.toString(),
        'company_phone_number': companyPhoneNumber.toString(),
        'address': companyAddress,
        'city': companyCity,
        'state': companyState,
        'country': companyCountry,
      });
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accesstoken",
      };
      request.headers.addAll(headers);
      String? mimeType = lookupMimeType(image!.path);
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_picture',
          image!.path,
          filename: basename(image!.path),
          contentType: MediaType.parse(mimeType!),
        ),
      );

      http.StreamedResponse response = await request.send();
      // final response = await ApiLayer.makeApiCall(ApiUrls.uploadMedia,
      //     method: HttpMethod.post,
      //     requireAccess: true,
      //     userAccessToken: await SecureStorageHelper.getAccessToken(),
      //     body: {"file": file});
      print("hi");
      if (response.statusCode == 200) {
        print('File uploaded successfully');
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);
        final message = data['message'];
        AppUtils.debug(message);
        navigateToProducerHomePage(context);
        Fluttertoast.showToast(msg: message);
      } else if (response is Failure) {
        print(response.statusCode);
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        final message = data['message'];
        print('File upload failed with status: ${response.statusCode}');
        print('Response body: $responseBody');
        print(response.statusCode);
        Fluttertoast.showToast(msg: message);
        notifyListeners();
      }
    } catch (e) {
      print(e);
      AppUtils.debug(e.toString());
      Fluttertoast.showToast(msg: 'An error occurred. Please try again later.');
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }

  void nextPage(BuildContext context) async {
    if (activePage == 0) {
      bool pageOneValidated = await validatePageZero();
      if (pageOneValidated) navigateToNextPage();
    } else if (activePage == 1) {
      bool pageTwoValidated = await validatePageOne();
      if (pageTwoValidated) navigateToNextPage();
    } else if (activePage == 2) {
      bool pageThreeValidated = await validatePageTwo();
      if (pageThreeValidated) navigateToNextPage();
    } else if (activePage == 3) {
      bool pageFourValidated = await validatePageThree();
      if (pageFourValidated) navigateToNextPage();
    } else if (activePage == 4) {
      if (_selectedIndex == 'Actor') {
        createActorAccount(context);
        // submitForm(context as BuildContext);
      } else if (_selectedIndex == 'Producer') {
        bool pageFiveValidated = await validatePageFour();
        if (pageFiveValidated) navigateToNextPage();
      }
    } else if (activePage == 5) {
      if (companyaddressController.text.trim().isNotEmpty &&
          companycityController.text.trim().isNotEmpty &&
          companystateController.text.trim().isNotEmpty &&
          companycountryController.text.trim().isNotEmpty) {
        createProducer(context);
      } else {
        Fluttertoast.showToast(msg: 'All address fields are necessary');
      }
    }
  }

// Handle the form submission
  Future<void> submitForm(BuildContext context) async {
    setLoadingState();
    // Implement your form submission logic here
    final accesstoken = await SecureStorageHelper.getAccessToken();
    if (selectedIndex == 'Actor') {
      //  postnotification(context);
      // setLoadingState();
      // notifyListeners();
      // Collect data from actor form
      // final formData = {
      //   'profession': _selectedIndex.toString(),
      //   'first_name': firstnameController.text.trim(),
      //   'last_name': lastnameController.text.trim(),
      //   'actual_age': dateController.text.trim(),
      //   'playable_age': selectedPlayableAge,
      //   'gender': selectedGenderActorIndex,
      //   'skin_type': selectedColorNotifier.value,
      // };
      // // Perform the form submission
      // final response = await ApiLayer.makeApiCall(
      //     ApiUrls.createUserActorProfile,
      //     method: HttpMethod.post,
      //     requireAccess: true,
      //     body: formData,
      //     userAccessToken: accesstoken);
      // print(_selectedIndex);
      // print("$firstnameController" + "vbbbbbbbbbbbbbbb");
      // print("$lastnameController" + "vbbbbbbbbbbbbbbb");
      // print("$dateController" + "vbbbbbbbbbbbbbbb");
      // print(selectedPlayableAge);
      // print(selectedGenderActorIndex);
      // print(selectedColorNotifier.value.toString());
      // print(accesstoken);
      // if (response is Success) {
      //   final data = json.decode(response.body);
      //   final message = data['message'];
      //   final userId = data['data']['user_id'];

      //   Fluttertoast.showToast(msg: message);
      //   print(Fluttertoast.showToast(msg: message));
      //   SecureStorageHelper.storeUserId(userId);
      //   navigateToPage();
      // } else {
      //   final data = json.decode(response.errorResponse);
      //   final message = data['message'];
      //   Fluttertoast.showToast(msg: message);
      //   print(data);
      //   print(response);
      //   print('toast${Fluttertoast.showToast(msg: message)}');
      // }
    } else {
      // createProducer(context);
      // Collect data from producer form
      // final formDataProducer = {
      //   'profession': _selectedIndex.toString(),
      //   'first_name': producerfirstnameController.text,
      //   'last_name': producerlastnameController.text,
      //   'filmmaker_profile': filmmakerprofileController.text,
      //   'company_name': companynameController.text,
      //   'company_email': companyemailController.text,
      //   'company_phone_number': companyphonenumberController.text,
      // };
      // Perform the form submission
      // final response = await ApiLayer.makeApiCall(
      //     method: HttpMethod.post,
      //     ApiUrls.createUserProducerProfile,
      //     requireAccess: true,
      //     userAccessToken: accesstoken,
      //     body: formDataProducer);
      // if (response is Success) {
      //   final data = json.decode(response.body);
      //   final message = data['message'];
      //   final userId = data['data']['user_id'];

      //   Fluttertoast.showToast(msg: message);
      //   print(Fluttertoast.showToast(msg: message));
      //   SecureStorageHelper.storeUserId(userId);
      //   Navigator.pushReplacementNamed(context, '/producer_home_page');
      // } else {
      //   final data = json.decode(response.errorResponse);
      //   final message = data['message'];
      //   Fluttertoast.showToast(msg: message);
      //   print('toast${Fluttertoast.showToast(msg: message)}');
      // }
    }
    setLoadingState();
    notifyListeners();
  }

  Future<void> submitData(context) async {
    setLoadingState();
    try {
      final homePagePath = await SharedPreferencesHelper.getUserHomePage();
      final accessToken = await SecureStorageHelper.getAccessToken();
      final response = await ApiLayer.makeApiCall(
        ApiUrls.updateUserProfile,
        method: HttpMethod.post,
        requireAccess: true,
        body: {
          "updateData": {
            'background_actor': _selectedIndexBackgroundActorIndex.toString()
          },
        },
        userAccessToken: accessToken,
      );

      if (response is Success) {
        final data = json.decode(response.body);
        final message = data['message'];
        final userId = data['data']['user_id'];
        Fluttertoast.showToast(msg: message);
        SecureStorageHelper.storeUserId(userId);
        if (homePagePath != null) {
          Navigator.pushReplacementNamed(context, homePagePath);
        }
      } else if (response is Failure) {
        final data = json.decode(response.errorResponse);
        final message = data['message'];
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occurred: $e');
    } finally {
      setLoadingState();
      notifyListeners();
    }
  }
}

//  Map<String, String> projectProducerMap = {};
//   List<TextEditingController> projectControllers = [];
//   List<TextEditingController> producerControllers = [];

//   void addMore() {
//     if (projectControllers.isEmpty) {
//       // Add the initial project controller
//       var initialProjectController = TextEditingController();
//       var initialProducerController = TextEditingController();
//       projectControllers.add(initialProjectController);
//       producerControllers.add(initialProducerController);
//       projectProducerMap[initialProjectController.text] =
//           initialProducerController.text;
//     } else {
//       // Allow adding more project controllers
//       var projectController = TextEditingController();
//       var producerController = TextEditingController();
//       projectControllers.add(projectController);
//       producerControllers.add(producerController);
//       // Optionally, you can add default values to the map for the new controllers
//       projectProducerMap[projectController.text] = producerController.text;
//     }
//     notifyListeners();
//   }

//   void submitForm() {
//     // Collect data from text fields and send it to the backend
//     List<String> projects = projectControllers.map((c) => c.text).toList();
//     List<String> producers = producerControllers.map((c) => c.text).toList();

//     // Send projects and producers data to the backend along with projectProducerMap
//     // Example:
//     // backendService.sendData(projects, producers, projectProducerMap);
//   }

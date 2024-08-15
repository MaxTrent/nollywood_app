import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/app_util.dart';

class SecureStorageHelper {
  static final storage = FlutterSecureStorage();
  static const confirmationIdKey = 'confirmation_id';
  static const userIdKey = 'user_id';
  static const accessTokenKey = 'access_token';
  static const refreshTokenKey = 'refresh_token';
  static const conversationsIdKey = 'conversation_id';
  static const producerProjectIdKey = 'project_id';
  static const _keyIsAuthenticated = 'isAuthenticated';
  static const profileCompleteKey = 'profile_complete_key';

  static Future<void> storeConfirmationId(String confirmationId) async {
    await storage.write(key: confirmationIdKey, value: confirmationId);
    AppUtils.debug('Confirmation Id stored');
  }

  static Future<String?> getConfirmationId() async {
    return await storage.read(key: confirmationIdKey);
  }

  static Future<void> storeConversationIds(List<String> conversationIds) async {
    await storage.write(
        key: conversationsIdKey, value: json.encode(conversationIds));
    AppUtils.debug('Conversation Id stored');
  }

  static Future<List<String>> getConversationIds() async {
    final idsJson = await storage.read(key: conversationsIdKey);
    if (idsJson != null) {
      final idsList = json.decode(idsJson);
      return List<String>.from(idsList);
    } else {
      return [];
    }
  }

  static Future<void> storeUserId(String userId) async {
    await storage.write(key: userIdKey, value: userId);
    AppUtils.debug('User Id stored');
  }

  static Future<String?> getUserId() async {
    return await storage.read(key: userIdKey);
  }

  static Future<void> clearUserId() async {
    await storage.delete(key: userIdKey);
  }

  static Future<void> storeAccessToken(String accessToken) async {
    await storage.write(key: accessTokenKey, value: accessToken);
    AppUtils.debug('Access Token stored');
  }

  static Future<String?> getAccessToken() async {
    return await storage.read(key: accessTokenKey);
  }

  static Future<void> clearAccessToken() async {
    await storage.delete(key: accessTokenKey);
  }

  static Future<void> storeRefreshToken(String refreshToken) async {
    await storage.write(key: refreshTokenKey, value: refreshToken);
    AppUtils.debug('Refresh Token stored');
  }

  static Future<String?> getRefreshToken() async {
    return await storage.read(key: refreshTokenKey);
  }

  static Future<void> storeAuthenticationStatus(bool isAuthenticated) async {
    await storage.write(
        key: _keyIsAuthenticated, value: isAuthenticated.toString());
  }

  static Future<bool> isAuthenticated() async {
    final isAuthenticated = await storage.read(key: _keyIsAuthenticated);
    return isAuthenticated == 'true';
  }

  static Future<void> clearAuthenticationStatus() async {
    await storage.delete(key: _keyIsAuthenticated);
  }

  static Future<void> saveProfileCompletion(bool isComplete) async {
    await storage.write(key: profileCompleteKey, value: isComplete.toString());
  }

  static Future<bool> getProfileCompletion() async {
    final isComplete = await storage.read(key: profileCompleteKey);
    return isComplete == 'true';
  }
}

class SharedPreferencesHelper {
  static const professionKey = 'profession';
  static const emailKey = 'user_email';
  static const phoneKey = 'user_phone_number';
  static const firstNameKey = 'first_name';
  static const lastNameKey = 'last_name';
  static const dateOfBirthKey = 'actual_age';
  static const filmmakerprofileKey = 'film_maker_profile';
  static const companyNameKey = 'company_name';
  static const companyEmailKey = 'company_email';
  static const companyPhoneNumberKey = 'company_phone_number';

  static const producerProjectNameKey = 'project_name';
  static const producerProjectDescriptionKey = 'description';
  static const producerProjectImageKey = 'thumbnail';
  static const producerProjectIdKey = '_id';
  static const producerProjectRoleIdKey = 'roleId';
  static const producerProjectSingleMonologueIdKey = 'mologueId';
  static const producerMonologueTitleKey = 'monologue_title';
  static const producerMonologueScriptKey = 'monologue_script';
  static const producerMultipleRoleIdForMonologueKey = 'differentRoleId';
  static const producerEditProjectIdKey = 'projectkey';
  static const profileCompleteKey = 'profileComplete';
  static const userHomePageKey = 'userHomePage';
  static const mediaUploadKey= 'mediaUploadKey';

  static Future<void> storeMediaUpload(String mediaUpload) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(mediaUploadKey, mediaUpload);
  }

  static Future<String?> getMediaUpload() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(mediaUploadKey);
  }

  static Future<void> storeUserProfession(String profession) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(professionKey, profession);
  }

  static Future<String?> getUserProfession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(professionKey);
  }
static Future<void> clearUserProfession() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(professionKey);
}

  static Future<void> storeUserEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(emailKey, email);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  static Future<void> storeUserPhoneNumber(String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(phoneKey, phoneNumber);
  }

  static Future<String?> getUserPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(phoneKey);
  }

  // First Name
  static Future<void> storeFirstName(String firstName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(firstNameKey, firstName);
  }

  static Future<String?> getFirstName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(firstNameKey);
  }

  // Last Name
  static Future<void> storeLastName(String lastName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(lastNameKey, lastName);
  }

  static Future<String?> getLastName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastNameKey);
  }

  // Date of Birth
  static Future<void> storeDateOfBirth(String dateOfBirth) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(dateOfBirthKey, dateOfBirth);
  }

  static Future<String?> getDateOfBirth() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(dateOfBirthKey);
  }

// company details
  static Future<void> storeFilmMakerProfile(String filmmakerprofile) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(filmmakerprofileKey, filmmakerprofile);
  }

  static Future<String?> getFilmMakerProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(filmmakerprofileKey);
  }

  static Future<void> storeCompanyName(String companyName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(companyNameKey, companyName);
  }

  static Future<String?> getCompanyName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(companyNameKey);
  }

  static Future<void> storeCompanyEmail(String companyEmail) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(companyEmailKey, companyEmail);
  }

  static Future<String?> getcompanyEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(companyEmailKey);
  }

  static Future<void> storeCompanyPhoneNumber(String companyPhoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(companyPhoneNumberKey, companyPhoneNumber);
  }

  static Future<String?> getCompanyPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(companyPhoneNumberKey);
  }

  static Future<void> storeProjectName(String producerProjectName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(producerProjectNameKey, producerProjectName);
  }

  static Future<String?> getProjectName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(producerProjectNameKey);
  }

  static Future<void> storeProjectDescription(
      String producerProjectDescription) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(producerProjectDescriptionKey, producerProjectDescription);
  }

  static Future<String?> getProjectDescription() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(producerProjectDescriptionKey);
  }

  static Future<void> storeProducerId(String producerProjectDescription) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(producerProjectDescriptionKey, producerProjectDescription);
  }

  static Future<String?> getProducerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(producerProjectDescriptionKey);
  }

  static Future<void> storeProducerProjectImage(
      String producerProjectImage) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(producerProjectImageKey, producerProjectImage);
  }

  static Future<String?> getProducerProjectImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(producerProjectImageKey);
  }

  static Future<void> storeProducerProjectId(String producerProjectId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(producerProjectIdKey, producerProjectId);
  }

  static Future<String?> getProducerProjectId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(producerProjectIdKey);
  }

  static Future<void> storeProducerProjectRoleId(
      String producerProjectRoleId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(producerProjectRoleIdKey, producerProjectRoleId);
  }

  static Future<String?> getProducerProjectRoleId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(producerProjectRoleIdKey);
  }

  static Future<void> storeProducerProjectSingleMonologueId(
      String producerProjectSingleMonologueId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        producerProjectSingleMonologueIdKey, producerProjectSingleMonologueId);
  }

  static Future<String?> getProducerProjectSingleMonologueId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(producerProjectSingleMonologueIdKey);
  }

  static Future<void> storeProducerMonologueTitle(
      String producerMonologueTitle) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(producerMonologueTitleKey, producerMonologueTitle);
  }

  static Future<String?> getProducerMonologueTitle() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(producerMonologueTitleKey);
  }

  static Future<void> storeProducerMonologueScript(
      String producerMonologueScript) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(producerMonologueScriptKey, producerMonologueScript);
  }

  static Future<String?> getProducerMonologueScript() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(producerMonologueScriptKey);
  }

  static Future<void> storeProducerMultipleRoleIdForMonologue(
      String producerMultipleRoleIdForMonologue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(producerMultipleRoleIdForMonologueKey,
        producerMultipleRoleIdForMonologue);
  }

  static Future<String?> getProducerMultipleRoleIdForMonologue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(producerMultipleRoleIdForMonologueKey);
  }

  static Future<void> storeProducerEditProjectId(
      String producerEditProjectId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(producerEditProjectIdKey, producerEditProjectId);
  }

  static Future<String?> getProducerEditProjectId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(producerEditProjectIdKey);
  }

  static Future<void> saveProfileCompletion(bool isComplete) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(profileCompleteKey, isComplete);
  }

  static Future<bool> getProfileCompletion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(profileCompleteKey) ?? false;
  }

  static Future<void> storeUserHomePage(String homePagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userHomePageKey, homePagePath);
  }

  static Future<String?> getUserHomePage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userHomePageKey);
  }
}

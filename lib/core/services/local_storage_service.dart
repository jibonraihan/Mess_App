import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
static const _messNameKey =
    'flutter.mess_name';

static const _messDescriptionKey =
    'flutter.mess_description';

static const _messAvatarKey =
    'flutter.mess_avatar';

  // SAVE MESS NAME
  static Future<void> saveMessName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_messNameKey, name);
  }

  // GET MESS NAME
  static Future<String?> getMessName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_messNameKey);
  }

  // SAVE DESCRIPTION
  static Future<void> saveDescription(
    String description,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _messDescriptionKey,
      description,
    );
  }

  // GET DESCRIPTION
  static Future<String?> getDescription() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(
      _messDescriptionKey,
    );
  }

  // SAVE AVATAR
  static Future<void> saveAvatar(
    Uint8List avatarBytes,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final base64Image = base64Encode(
      avatarBytes,
    );

    await prefs.setString(
      _messAvatarKey,
      base64Image,
    );
  }

  // GET AVATAR
  static Future<Uint8List?> getAvatar() async {
    final prefs = await SharedPreferences.getInstance();

    final base64Image = prefs.getString(
      _messAvatarKey,
    );

    if (base64Image == null) {
      return null;
    }

    return base64Decode(base64Image);
  }

  // REMOVE AVATAR
  static Future<void> removeAvatar() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_messAvatarKey);
  }
}
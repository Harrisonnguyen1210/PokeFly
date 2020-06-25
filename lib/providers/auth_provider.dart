import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String authSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$authSegment?key=AIzaSyD2uSOuLXFB5K71nF-tv9vbxuDXgfs-QiU';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email.trim(),
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw Exception(
            'Authentication failed with error: ${responseData['error']['message']}');
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    await _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    await _authenticate(email, password, 'signInWithPassword');
  }
}

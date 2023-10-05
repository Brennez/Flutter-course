import 'dart:async';
import 'dart:io';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;

  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.userChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signup(
      String name, String email, String password, File? image) async {
    final auth = FirebaseAuth.instance;
    final credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (credential.user == null) return;

    // 1. upload da ft do usuário
    final imageName = '${credential.user!.uid}.jpg';
    final imageUrl = await uploadUserImage(image, imageName);

    credential.user?.updateDisplayName(name);
    credential.user?.updatePhotoURL(imageUrl);
    // credential.user?.updatePhotoURL();
  }

  Future<String?> uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;

    final imageRef = storage.ref().child('user_names').child(imageName);

    await imageRef.putFile(image).whenComplete(() {});

    return await imageRef.getDownloadURL();
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  static ChatUser _toChatUser(User user) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageUrl: user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}

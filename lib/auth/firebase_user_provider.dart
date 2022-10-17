import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MusicToVideoFirebaseUser {
  MusicToVideoFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

MusicToVideoFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MusicToVideoFirebaseUser> musicToVideoFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<MusicToVideoFirebaseUser>(
            (user) => currentUser = MusicToVideoFirebaseUser(user));

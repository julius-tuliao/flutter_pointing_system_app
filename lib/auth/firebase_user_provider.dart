import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CommisionWalletFirebaseUser {
  CommisionWalletFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

CommisionWalletFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CommisionWalletFirebaseUser> commisionWalletFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<CommisionWalletFirebaseUser>(
            (user) => currentUser = CommisionWalletFirebaseUser(user));

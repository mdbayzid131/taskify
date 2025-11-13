import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskify/route/route.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _user = Rxn<User>();
  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();

    _user.bindStream(_auth.authStateChanges());
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credential).then((value) {
      Get.offAllNamed(RoutePages.homePage);
    });
  }
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    Get.offAllNamed(RoutePages.loginPage);
  }


}

import 'package:aqwise_stripe_payment/authentication/auth.provider.dart';
import 'package:aqwise_stripe_payment/authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class DeleteAccountWidget extends StatefulWidget {
  const DeleteAccountWidget({super.key});

  @override
  State<DeleteAccountWidget> createState() => _DeleteAccountWidgetState();
}

class _DeleteAccountWidgetState extends State<DeleteAccountWidget> {
  showSnackbar(text) {
    return SnackBar(
      content: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      return auth.user == null

          /// replace this with loginscreen UI
          ? const LoginPage()
          : Scaffold(
              appBar: AppBar(title: const Text('Delete account tutorial')),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Account Name ${auth.user?.displayName ?? 'No Name'}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Account Email ${auth.user?.email ?? 'No Email'}'),
                    ),
                    ElevatedButton(
                      onPressed: _deleted,
                      child: const Text('Basic Delete'),
                    ),
                    ElevatedButton(
                      onPressed: _deletedConfirm,
                      child: const Text('Delete with Confirmation'),
                    ),
                    ElevatedButton(
                      onPressed: _reAuthdeleted,
                      child: const Text('Reauthenticate and Delete'),
                    ),
                    ElevatedButton(
                      onPressed: _reAuthdeletedConfirm,
                      child: const Text(
                          'Reauthenticate and Delete with Confirmation'),
                    ),
                  ],
                ),
              ));
    });
  }

  Future<void> _deleted() async {
    ///basic deleted
    try {
      ///delete func
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      ///show error message
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(showSnackbar(e.message));
    }
  }

  Future<void> _deletedConfirm() async {
    /// basic delete with confirmation
    ///show popup confirm
    QuickAlert.show(
      onConfirmBtnTap: () => {Navigator.pop(context), _deleted()},
      onCancelBtnTap: () => Navigator.pop(context),
      context: context,
      type: QuickAlertType.confirm,
      text: 'Do you want delete account',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
    );
  }

  Future<void> _reAuthdeleted() async {
    /// reauth delete
    ///show popup to enter password
    var passController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter password to continue...'),
        content: TextFormField(
          obscureText: true,
          controller: passController,
          decoration: const InputDecoration(label: Text('Password')),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close)),
          IconButton(
              onPressed: () async =>
                  await reAuthenticateDelete(passController.text),
              icon: const Icon(Icons.check))
        ],
      ),
    );
  }

  Future<void> _reAuthdeletedConfirm() async {
    /// reauth delete with confirmation
    ///show popup to enter password
    var passController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter password to continue...'),
        content: TextFormField(
          obscureText: true,
          controller: passController,
          decoration: const InputDecoration(label: Text('Password')),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close)),
          IconButton(
              onPressed: () async =>
                  await reAuthenticateConfirmDelete(passController.text),
              icon: const Icon(Icons.check))
        ],
      ),
    );
  }

  Future<void> reAuthenticateDelete(String password) async {
    ///reauth func with direct delete
    try {
      var user = FirebaseAuth.instance.currentUser;
      //reauth
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user!.email!, password: password);
      if (credential.user != null) {
        /// success login will delete account
        await _deleted();
        if (!mounted) return;
        Navigator.pop(context);
      } else {
        /// error login
        print('error during re auth');
      }
    } on FirebaseAuthException catch (e) {
      ///show error message
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(showSnackbar(e.message));
    }
  }

  Future<void> reAuthenticateConfirmDelete(String password) async {
    ///reauth func with confirmation delete
    try {
      var user = FirebaseAuth.instance.currentUser;
      //reauth
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user!.email!, password: password);
      if (credential.user != null) {
        /// success login will delete account

        if (!mounted) return;
        Navigator.pop(context);
        await _deletedConfirm();
      } else {
        /// error login
        print('error during re auth');
      }
    } on FirebaseAuthException catch (e) {
      ///show error message
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(showSnackbar(e.message));
    }
  }
}

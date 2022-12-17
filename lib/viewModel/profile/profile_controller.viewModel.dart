import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/res/color.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/res/components/text_field.components.dart';
import 'package:tech_media/utils/utils.utils.dart';
import 'package:tech_media/viewModel/session/session_controller.session.viewmodel.dart';

class ProfileController with ChangeNotifier {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final nameFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();

  final imagePicker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //pick image from gallery
  void pickImageFromGallery(BuildContext context) async {
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  //pick image from camera
  void pickImageFromCamera(BuildContext context) async {
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  void pickProfileImage(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickImageFromCamera(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.camera,
                      color: AppColors.primaryIconColor),
                  title: const Text("Camera"),
                ),
                ListTile(
                  onTap: () {
                    pickImageFromGallery(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.image,
                      color: AppColors.primaryIconColor),
                  title: const Text("Gallery"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    //store user image to firebase Storage
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref("/profile${SessionController().userId}");
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);
    //upload image
    await Future.value(uploadTask);
    //get uploaded image path
    final newUrl = await storageRef.getDownloadURL();
    //upload image path to db ref
    dbRef.child(SessionController().userId.toString()).update({
      "profilePicture": newUrl.toString(),
    }).then((value) {
      Utils.toastMessage("Profile Updated");
      setLoading(false);
      _image = null;
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      setLoading(false);
    });
  }

  //update user details dialog box
  Future<void> showUserNameDetailsDialogBox(BuildContext context, String name) {
    nameController.text = name;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text("Update Username")),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormFieldComponent(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  onFieldSubmitValue: (value) {},
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  hintText: "userName",
                  formFieldValidator: (value) {},
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                dbRef.child(SessionController().userId.toString()).update(
                    {"userName": nameController.text.toString()}).then((value) {
                  Utils.toastMessage("Username updated");
                  nameController.clear();
                }).onError((error, stackTrace) {
                  Utils.toastMessage(error.toString());
                });
                Navigator.pop(context);
              },
              child: Text(
                "Update",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: AppColors.alertColor),
              ),
            )
          ],
        );
      },
    );
  }

  //update user phone dialog box
  Future<void> showUserPhoneNumberDialogBox(
      BuildContext context, String phoneNumber) {
    phoneNumberController.text = phoneNumber;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text("Update PhoneNumber")),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormFieldComponent(
                  controller: phoneNumberController,
                  focusNode: phoneNumberFocusNode,
                  onFieldSubmitValue: (value) {},
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  hintText: "phoneNumber",
                  formFieldValidator: (value) {},
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                dbRef.child(SessionController().userId.toString()).update({
                  "phoneNumber": phoneNumberController.text.toString()
                }).then((value) {
                  Utils.toastMessage("PhoneNumber updated");
                  phoneNumberController.clear();
                }).onError((error, stackTrace) {
                  Utils.toastMessage(error.toString());
                });
                Navigator.pop(context);
              },
              child: Text(
                "Update",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: AppColors.alertColor),
              ),
            )
          ],
        );
      },
    );
  }
}

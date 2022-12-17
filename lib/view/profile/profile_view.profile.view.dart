import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/viewModel/profile/profile_controller.viewModel.dart';
import 'package:tech_media/viewModel/session/session_controller.session.viewmodel.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final dbRef = FirebaseDatabase.instance.ref("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (_) => ProfileController(),
        child: Consumer<ProfileController>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: StreamBuilder(
                stream:
                    dbRef.child(SessionController().userId.toString()).onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            //userProfile
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(20),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 4),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child:

                                        //show picked image
                                        provider.image == null
                                            ? map["profilePicture"]
                                                        .toString() ==
                                                    ""
                                                ? const Icon(
                                                    Icons.person_outline)
                                                : Image(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        map["profilePicture"]
                                                            .toString()),
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    },
                                                    errorBuilder: (context,
                                                        object, stack) {
                                                      return const Icon(
                                                          Icons.error_outline,
                                                          color: AppColors
                                                              .alertColor);
                                                    },
                                                  )
                                            : Image.file(
                                                File(provider.image!.path)
                                                    .absolute),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                provider.pickProfileImage(context);
                              },
                              child: const CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColors.primaryIconColor,
                                child: Icon(Icons.add,
                                    color: Colors.white, size: 15),
                              ),
                            ),
                          ],
                        ),
                        //name and id
                        GestureDetector(
                          onTap: () {
                            provider.showUserNameDetailsDialogBox(
                                context, map["userName"]);
                          },
                          child: ReusableRow(
                            title: "Username",
                            value: map["userName"],
                            iconData: Icons.person_outline_outlined,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            provider.showUserPhoneNumberDialogBox(
                                context, map["phoneNumber"]);
                          },
                          child: ReusableRow(
                            title: "PhoneNumber",
                            value: map["phoneNumber"] == ""
                                ? "9876543223"
                                : map["phoneNumber"],
                            iconData: Icons.phone,
                          ),
                        ),
                        ReusableRow(
                          title: "Email",
                          value: map["email"],
                          iconData: Icons.email,
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Something went wrong",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  const ReusableRow(
      {Key? key,
      required this.title,
      required this.value,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: Icon(iconData),
          trailing: Text(value),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.4),
        ),
      ],
    );
  }
}

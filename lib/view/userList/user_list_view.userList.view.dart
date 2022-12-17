import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/viewModel/session/session_controller.session.viewmodel.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users", style: Theme.of(context).textTheme.bodyText2),
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (context, snapshot, animation, index) {
            if (SessionController().userId.toString() ==
                snapshot.child("uid").value.toString()) {
              return Container();
            } else {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        snapshot.child("profilePicture").value.toString()),
                  ),
                  title: Text(snapshot.child('userName').value.toString()),
                  subtitle: Text(snapshot.child('email').value.toString()),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

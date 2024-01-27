import 'package:flutter/material.dart';
import 'package:start/DB/DB-user.dart';
import 'package:start/pages/home.dart';
import 'package:start/shared/shared.dart';
import 'package:start/widgets/custom_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    email.text = userData['email'];
    name.text = userData['name'];
    bio.text = userData['bio'];
    phone.text = userData['phone'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 24.0),
              TextFormField(
                validator: (value) {
                  /*   const pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//r'(^(?:[+0]9)?[0-9]{10,12}$)'; //+97876767789
                  final regex = RegExp(pattern);
                  return value!.isNotEmpty && !regex.hasMatch(value)
                      ? 'Enter a valid email address'
                      : null;
 */
                  if (value!.isEmpty) {
                    return "please Add Email";
                  } else if (value.contains("@") && value.contains(".")) {
                    return null;
                  } else {
                    return "please Add Valid Email";
                  }
                },
                style: const TextStyle(color: Colors.white),
                controller: email,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "You Email",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return "Fill Field";
                  }
                },
                style: const TextStyle(color: Colors.white),
                controller: name,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "You Name",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return "Please Add Bio";
                  }
                },
                style: const TextStyle(color: Colors.white),
                controller: bio,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "You Bio",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Add Phone";
                  } else if (value.length < 10) {
                    return "Please Add Full Number";
                  } else {
                    return null;
                  }
                },
                style: const TextStyle(color: Colors.white),
                controller: phone,
                maxLines: 2,
                maxLength: 10,
                decoration: const InputDecoration(
                  hintText: "Phone Number",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              InkWell(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    DatabaseHelper databaseHelper = DatabaseHelper();
                    await databaseHelper.init();

                    Map<String, dynamic> newUserData = {
                      "name": name.text.toString(),
                      "email": email.text.toString(),
                      "password": userData['password'],
                      'bio': bio.text.toString(),
                      "id": userData['id'],
                      "phone": phone.text.toString(),
                    };
                    print(newUserData);
                    databaseHelper.update(newUserData).then((value) {
                      print(value);
                      userData = newUserData;
                      customDialog(
                              context: context,
                              title: "Alert",
                              body: "Update Sucsess!")
                          .then((value) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (Route<dynamic> route) => false);
                      });
                    });
                  } else {
                    customDialog(
                        context: context,
                        title: "Alert",
                        body: "Please Fill All Fields");
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.amber.shade300),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

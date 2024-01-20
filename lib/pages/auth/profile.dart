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
  @override
  Widget build(BuildContext context) {
    email.text = userData['email'];
    name.text = userData['name'];
    bio.text = userData['bio'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 24.0),
            TextField(
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
            TextField(
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
            TextField(
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
            SizedBox(height: 24.0),
            InkWell(
              onTap: () async {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                    (Route<dynamic> route) => false);
                /*     DatabaseHelper databaseHelper = DatabaseHelper();
                await databaseHelper.init();

                userData['name'] = name.text.toString();
                userData['email'] = email.text.toString();
                userData['bio'] = bio.text.toString();
                print(userData);
                Map<String, dynamic> newUserData = {
                  "name": name.text.toString(),
                  "email": email.text.toString(),
                  "password": userData['password'],
                  'bio': bio.text.toString(),
                  "id": userData['id'],
                };
                databaseHelper.update(newUserData).then((value) {
                  print(value);
                }); */
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
            /*   ElevatedButton(
              onPressed: () async {
                DatabaseHelper databaseHelper = DatabaseHelper();
                await databaseHelper.init();

                /*  customDialog(
                    context: context, title: "Alert", body: "Update Sucsess!");
                await databaseHelper.update(userData).then((value) {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomePage(),
                    ),
                  );
                }); */
              },
              child: Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
           */
          ],
        ),
      ),
    );
  }
}

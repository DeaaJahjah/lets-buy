import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/features/auth/Services/authentecation_service.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';
import 'package:lets_buy/core/services/user_db_services.dart';
import 'package:lets_buy/features/profile/update_profile_screen.dart';
import 'package:lets_buy/features/home_screen/widgets/custom_navigation_bar.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/features/posts/screens/my_posts_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile_screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: CustomNavigationBar(index: 4),
      body: FutureBuilder<UserModel?>(
          future: UserDbServices().getUser(uid.trim()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 280,
                        color: white,
                        child: Stack(children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: const BoxDecoration(
                                color: dark,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25))),
                          ),
                          Positioned(
                            top: 130,
                            left: (MediaQuery.of(context).size.width / 2) - 72,
                            child: Column(
                              children: [
                                // (client.profilePicUrl != '')?
                                CircleAvatar(
                                  radius: 72,
                                  backgroundColor: purple,
                                  child: CircleAvatar(
                                    backgroundColor: purple,
                                    radius: 70,
                                    backgroundImage:
                                        NetworkImage(snapshot.data!.imgUrl),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      Text(
                        snapshot.data!.name,
                        style: const TextStyle(
                            color: dark,
                            fontFamily: font,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        snapshot.data!.email,
                        style: const TextStyle(
                            color: dark, fontFamily: font, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snapshot.data!.address,
                              style: const TextStyle(
                                  color: dark, fontFamily: font, fontSize: 18)),
                          const Icon(
                            Icons.location_on,
                            color: dark,
                            size: 25,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  dark.withOpacity(0.2)),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(MyPostsScreen.routeName);
                            },
                            child: FutureBuilder<int>(
                                future: PostDbService().myPostCount(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    int length = snapshot.data!;
                                    return Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: dark,
                                          radius: 10,
                                          child: Text(length.toString(),
                                              style: const TextStyle(
                                                  color: white)),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          'المنشورات',
                                          style: TextStyle(
                                              color: dark,
                                              fontFamily: font,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        color: purple),
                                  );
                                })),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  dark.withOpacity(0.2)),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(UpdateProfileScreen.routeName,
                                      arguments: snapshot.data!)
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: dark,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'تعديل الملف الشخصي',
                                  style: TextStyle(
                                      color: dark,
                                      fontFamily: font,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                      ),
                      ElevatedButtonCustom(
                        onPressed: () async {
                          await FlutterFireAuthServices().signOut(context);
                        },
                        text: 'تسجيل خروج',
                        color: dark,
                      )
                    ]),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: purple,
              ));
            }
            return const SizedBox.shrink();
          }),
    );
  }
}

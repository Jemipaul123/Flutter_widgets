import 'dart:convert';
import 'package:chat_app/model/team.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/pages/loginpage.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user;
  List<Team> teams = [];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    getTeams();
  }

  Future<void> getTeams() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    var jsonData = jsonDecode(response.body);
    for (var eachTeam in jsonData['data']) {
      final team = Team(
        abbreviation: eachTeam['abbreviation'],
        city: eachTeam['city'],
      );
      teams.add(team);
    }
    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.3,
            child: FutureBuilder<void>(
              future: getTeams(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: teams.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          teams[index].abbreviation,
                            style: TextStyle(color: Colors.black),),
                          subtitle: Text(teams[index].city)


                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Signed in as ${user.email}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(showRegisterPage: () {}),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    ),
                    child: Text(
                      'Sign out',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
     /*     Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Lottie.network(
                'https://assets7.lottiefiles.com/packages/lf20_pvpf4883.json',
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}

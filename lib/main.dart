import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'NavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'protips.dart';
import 'package:share_plus/share_plus.dart';




Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Side Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tween'),
    );
  }


}





class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}





class _MyHomePageState extends State<MyHomePage> {

  final BannerAd myBanner = BannerAd(

    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),

  );



  Future  <void> quitSmokingDate(String days, String hours,String minutes , String seconds) async{

    String time = days + ":" + hours + ":" + minutes + ":" + seconds;

    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid.toString();
    final surveyQuestion = FirebaseFirestore.instance.collection('surveys').doc('z9KAl1swgqbtdk1BOEMPIUVVRyz1');
    await surveyQuestion.update({"time": time});
  }



  Future  <String> getDays() async{
    DocumentSnapshot snapshot = await(FirebaseFirestore.instance.collection('surveys').doc('z9KAl1swgqbtdk1BOEMPIUVVRyz1').get());
    String day = snapshot['time'];
    return day.toString();
  }





  final CollectionReference _surveyss =
  FirebaseFirestore.instance.collection('surveys');


  static const countdownDuration = Duration(seconds: 10);
  Duration duration = Duration();
  Timer? timer ;
  bool isCountdown = false;

  @override
  void initState() {

    super.initState();
    startTimer();
    reset();
    stopTimer();
    myBanner.load();
  }

  void reset(){
    if(isCountdown){
      setState(()=> duration = countdownDuration);
    }
    else{
      setState(()=> duration= Duration());
    }
  }

  void stopTimer({bool resets = true}){
    if(resets){
      reset();
    }
  }

  void addTime(){
    final addSeconds = 1 ;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      duration = Duration(seconds: seconds);
    });

  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds:1),(_)=>addTime());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        centerTitle: true,
        title: const Text('Tween'),
      ),

      // Using StreamBuilder to display all surveys from Firestore in real-time
      body: StreamBuilder(
        stream: _surveyss.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];

                var cpd = documentSnapshot['cigarattesPerDay'].toString();
                var cpp = documentSnapshot['costPerPack'].toString();
                var qpp = documentSnapshot['quantityPerPack'].toString();


                var cigarattesPerDay = int.parse(cpd);
                var costPerPack = int.parse(cpp);
                var quantityPerPack = int.parse(qpp);


                var moneysaved = ((costPerPack/quantityPerPack)*cigarattesPerDay).toString() ;
                var lifewon = (cigarattesPerDay*11).toString();


                String twoDigits(int n ) => n.toString().padLeft(2,'0');
                final days = twoDigits(duration.inDays);
                final hours = twoDigits(duration.inHours);
                final minutes = twoDigits(duration.inMinutes.remainder(60));
                final seconds = twoDigits(duration.inSeconds.remainder(60));

                int updated = 0;

                if (updated==0) {
                  quitSmokingDate(days, hours, minutes, seconds);
                }

                return Card(
                  child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.cyan,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text("RM"+ moneysaved , style: TextStyle(fontSize: 60)),
                                    Text("Money Saved", style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                                Container(
                                  height: 80,
                                  child: VerticalDivider(
                                    color: Colors.white,
                                    thickness: 5,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(lifewon + "min",style: TextStyle(fontSize: 60)),
                                    Text("Life Won Back", style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          color: Colors.yellow,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                Column(
                                  children: <Widget>[
                                    Text(documentSnapshot['quantityPerPack'].toString(), style: TextStyle(fontSize: 60)),
                                    Text("Achivement unlocked", style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ),

                        SizedBox(height: 5),

                        Container(
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text('$days:$hours:$minutes:$seconds', style: TextStyle(fontSize: 60)),
                                    Text("    Days  :    Hours :    Minutes :  Seconds", style: TextStyle(fontSize: 22)),
                                    Text("Total Stop Smoking", style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(elevation: 2),
                                      onPressed: stopTimer,
                                      child: Text('Reset', style: TextStyle(fontSize: 18)),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(elevation: 2),
                                      onPressed: () async{
                                        final weburl="Total Stop Smoking : $days days $hours hours $minutes Minutes $seconds Seconds";
                                        Share.share('${weburl}');
                                      },
                                      child: Text('Share', style: TextStyle(fontSize: 18)),
                                    ),
                                    ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        ListTile(
                            tileColor: Colors.orange,
                            title: Text('Pro Tips' ,style: TextStyle(fontSize: 30)),
                            trailing: const Icon(Icons.share),
                            subtitle: Text('Connect with a family member, friend or support group member for help in your effort to resist a tobacco craving. Chat on the phone, go for a walk, share a few laughs, or meet to talk and support each other. Counseling can be helpful too.'),
                            onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Protip())),
                        ),
                        Container(
                          color: Colors.orange,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(elevation: 2),
                                      onPressed: () async{
                                        final weburl="Connect with a family member, friend or support group member for help in your effort to resist a tobacco craving. Chat on the phone, go for a walk, share a few laughs, or meet to talk and support each other. Counseling can be helpful too.";
                                        Share.share('${weburl}');
                                      },
                                      child: Text('Share', style: TextStyle(fontSize: 18)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 15),
                        ListTile(
                            tileColor: Colors.purpleAccent,
                            title: Text('Community' ,style: TextStyle(fontSize: 20)),
                            leading: const Icon(Icons.person),
                            //onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Chats()))
                        ),

                        SizedBox(height: 15),

                        // Container(
                        //   alignment: Alignment.center,
                        //   child: AdWidget(ad:myBanner),
                        //    width: 800,
                        //    height:50,
                        // ),

                      ]),
                );



              },
            );


          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
    );
  }




}

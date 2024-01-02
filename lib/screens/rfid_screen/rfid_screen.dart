import 'package:abc/provider/user_provider.dart';
import 'package:abc/screens/home/main_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/fire_user.dart';

class RfidScreen extends StatefulWidget {
  FireUser? data;
  RfidScreen({this.data, super.key});

  @override
  State<RfidScreen> createState() => _RfidScreenState();
}

class _RfidScreenState extends State<RfidScreen> {
  TextEditingController rfidCardNum = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Stream<DocumentSnapshot<Map<String, dynamic>>> checkUserIfHasRFID() => FirebaseFirestore.instance
      .collection('Users')
      .doc(widget.data!.uid)
      .snapshots();
    return Scaffold(
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: checkUserIfHasRFID(),
          builder: (context, snapshot) {
            if (snapshot.hasError){
              return Center(child: Text('Something Went wrong... ${snapshot.error}'));
            } else if (snapshot.hasData) {
              var dataUser = snapshot.data!.data();
              if (dataUser!['rfidtag'] == '' || dataUser!['rfidtag'] == null){
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'You are a new user. Please scan your RFID Tag',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 10,),
                        const Text(
                          'Once RFID is scanned, please enter the following to the RVM',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                  
                        // Text('${dataUser['rfidpass']}'),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: rfidCardNum,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your scanned RFID here'
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: (){
                                final data = {
                                  'rfidtag': rfidCardNum.value.text.toString(),
                                };
                                          
                                var db = FirebaseFirestore.instance;
                                          
                                db
                                .collection("Users")
                                .doc(widget.data!.uid)
                                .set(data)
                                .onError((e, _) => print("Error writing document: $e"));
                              }, 
                              child: Text('Save my RFID Card')
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {

                return const Home(title: 'RVM');
              }
            }else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
      ),
    );
  }
}
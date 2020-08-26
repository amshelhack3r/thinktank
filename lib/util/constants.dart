import 'package:firebase_core/firebase_core.dart';

Future<FirebaseApp> getFirebaseApp() async {
  return await FirebaseApp.configure(
      name: "Think Tank",
      options: FirebaseOptions(
          apiKey: 'AIzaSyAm8EgB9BzYrbmcXm19BSfxEyIrVyBDPXc',
          googleAppID: '1:937735026913:android:3600169eabd0908ea85fa0',
          projectID: 'thinktank-df4ef'));
}

List<String> getMonths() {
  return [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
}

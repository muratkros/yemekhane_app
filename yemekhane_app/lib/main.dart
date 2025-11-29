import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yemekhane Menüsü',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const YemekEkrani(),
    );
  }
}

class YemekEkrani extends StatefulWidget {
  const YemekEkrani({super.key});

  @override
  State<YemekEkrani> createState() => _YemekEkraniState();
}

class _YemekEkraniState extends State<YemekEkrani> {
  // Senin Firebase Linkin buraya gömüldü:
  final DatabaseReference _dbRef = FirebaseDatabase.instance.refFromURL(
    "https://yemekapp-86251-default-rtdb.europe-west1.firebasedatabase.app/",
  );

  String tarih = "Yükleniyor...";
  String yemekler = "Menü bekleniyor...";

  @override
  void initState() {
    super.initState();
    _verileriDinle();
  }

  void _verileriDinle() {
    _dbRef.child('gunluk_menu').onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        setState(() {
          tarih = data['tarih'] ?? "";
          // Hem 'detay' hem 'yemek' alanını kontrol et, hangisi varsa onu getir
          yemekler = data['detay'] ?? (data['yemek'] ?? "Hata");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Günün Menüsü 🍽️"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tarih,
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: const Color(0xFFFFF3E0),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.restaurant_menu,
                        size: 50,
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        yemekler,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Afiyet olsun Reis!",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

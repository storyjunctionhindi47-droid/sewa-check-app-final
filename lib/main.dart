import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(SewaCheckApp());
bool isNepali = true;

class SewaCheckApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF0D47A1), scaffoldBackgroundColor: Color(0xFFE3F2FD)),
      home: MainNav(),
    );
  }
}
class MainNav extends StatefulWidget { @override _MainNavState createState() => _MainNavState(); }
class _MainNavState extends State<MainNav> {
  int idx = 0;
  final pages = [HomeScreen(), TranslatorScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx, onTap: (i)=>setState(()=>idx=i),
        selectedItemColor: Color(0xFF0D47A1), type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: isNepali?'होम':'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.translate), label: 'Translator'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: isNepali?'प्रोफाइल':'Profile'),
        ],
      ),
    );
  }
}
class HomeScreen extends StatefulWidget { @override _HomeScreenState createState() => _HomeScreenState(); }
class _HomeScreenState extends State<HomeScreen> {
  final services = [
    {'np': 'हवाई टिकट जाँच', 'en': 'Flight Ticket Check', 'sub': 'PNR Check', 'i': Icons.flight, 'c': Colors.blue},
    {'np': 'भिसा / मोफा जाँच', 'en': 'Visa / MOFA Check', 'sub': 'Passport No', 'i': Icons.description, 'c': Colors.orange},
    {'np': 'मेडिकल रिपोर्ट', 'en': 'Medical Report', 'sub': 'GAMCA', 'i': Icons.medical_services, 'c': Colors.red},
    {'np': 'पैसा पठाउने ठाउँ', 'en': 'Money Transfer', 'sub': 'IME/Prabhu', 'i': Icons.location_on, 'c': Colors.green},
    {'np': 'नेपाली होटल खोज', 'en': 'Nepali Hotel Finder', 'sub': 'Hotel + Number', 'i': Icons.hotel, 'c': Colors.purple},
    {'np': 'बस टिकट - BUS', 'en': 'BUS Ticket Malaysia', 'sub': 'TBS to Penang/Johor', 'i': Icons.directions_bus, 'c': Colors.teal},
    {'np': 'कोरियर सेवा', 'en': 'Courier Nepal Service', 'sub': 'KL to KTM Tracking', 'i': Icons.local_shipping, 'c': Colors.indigo},
    {'np': 'घर जाने मद्दत', 'en': 'Go Home Help - SOS', 'sub': 'Company Chhoda?', 'i': Icons.home, 'c': Colors.brown},
    {'np': 'नेपाल बाट टिकट', 'en': 'Ticket From Nepal - Return', 'sub': 'KTM to KL - Wapas Aana', 'i': Icons.flight_takeoff, 'c': Colors.deepOrange},
    {'np': 'एमबीसी हेल्पलाइन', 'en': 'MBC Helpline / SOS', 'sub': 'Emergency', 'i': Icons.emergency, 'c': Colors.redAccent},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF0D47A1), title: Text(isNepali? '🇳🇵 सेवा चेक एप 🇲🇾' : '🇳🇵 Sewa Check App 🇲🇾', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), actions: [
        Padding(padding: EdgeInsets.only(right: 8), child: Row(children: [
          GestureDetector(onTap: ()=>setState(()=>isNepali=true), child: Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: isNepali? Colors.white: Colors.transparent, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white)), child: Text('नेपाली', style: TextStyle(color: isNepali? Color(0xFF0D47A1): Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
          SizedBox(width: 4),
          GestureDetector(onTap: ()=>setState(()=>isNepali=false), child: Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color:!isNepali? Colors.white: Colors.transparent, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white)), child: Text('English', style: TextStyle(color:!isNepali? Color(0xFF0D47A1): Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
        ]))
      ]),
      body: SingleChildScrollView(padding: EdgeInsets.all(12), child: Column(children: [
        Card(child: TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: isNepali? 'खोज्नुहोस् - भिसा, बस, टिकट...' : 'Search visa, bus, ticket, hotel...', border: InputBorder.none, contentPadding: EdgeInsets.all(14)))),
        SizedBox(height: 10),
        GridView.builder(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.3, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: services.length, itemBuilder: (c,i) => Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), child: InkWell(onTap: ()=> Navigator.push(c, MaterialPageRoute(builder: (_)=> DetailScreen(title: isNepali? services[i]['np'].toString(): services[i]['en'].toString(), type: i)), borderRadius: BorderRadius.circular(15), child: Padding(padding: EdgeInsets.all(10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(services[i]['i'] as IconData, color: services[i]['c'] as Color, size: 26), SizedBox(height: 6), Text(isNepali? services[i]['np'] as String: services[i]['en'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), Text(services[i]['sub'] as String, style: TextStyle(fontSize: 9, color: Colors.grey))])))))),
      ])),
    );
  }
}
class DetailScreen extends StatelessWidget {
  final String title; final int type; DetailScreen({required this.title, required this.type});
  @override Widget build(BuildContext context) {
    bool isBus = type==5; bool isNepalTicket = type==8; bool isHome = type==7;
    return Scaffold(appBar: AppBar(backgroundColor: Color(0xFF0D47A1), title: Text(title, style: TextStyle(fontSize: 15))),
      body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children: [
        if(isBus)...[
          Text(isNepali? 'उपलब्ध बसहरू • ३ नतिजा' : 'Available Buses • 3 Results', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _busCard('KKKL Express','TBS KL → Penang','9:30 PM','RM 45','4h 30m'),
          _busCard('Transnasional','TBS KL → Johor','9:30 PM','RM 45','5h 00m'),
          _busCard('Causeway Link','TBS KL → KLIA','10:15 PM','RM 15','1h 15m'),
        ] else if(isNepalTicket)...[
          Card(color: Colors.orange.shade50, child: Padding(padding: EdgeInsets.all(12), child: Text(isNepali? 'नेपाल गइसकेका दाजुभाइ जसलाई फर्कन लाज लागिरहेको छ, निर्धक्क सम्पर्क गर्नुहोस्।' : 'Bhai jo Nepal ja chuka hai aur sharm mehsoos kar raha hai - bejhijhak sampark kare.', style: TextStyle(fontWeight: FontWeight.bold)))),
          SizedBox(height: 12),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () async { await launch('https://wa.me/601111817544?text=Nepal se ticket chahiye KTM to KL'); }, child: Text(isNepali?'व्हाट्सएपमा टिकट बुक गर्नुहोस्':'Book on WhatsApp'), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.all(15)))),
        ] else if(isHome)...[
          Card(color: Colors.red.shade50, child: Padding(padding: EdgeInsets.all(12), child: Text(isNepali?'कम्पनी छोड्नु भएको? घर जान चाहनुहुन्छ?':'Company chhod diya? Ghar jana hai?', style: TextStyle(fontWeight: FontWeight.bold)))),
          SizedBox(height: 10),
          Row(children: [Expanded(child: ElevatedButton.icon(onPressed: () async => await launch('tel:+601111817544'), icon: Icon(Icons.call), label: Text('Call Ramesh'))), SizedBox(width: 8), Expanded(child: ElevatedButton.icon(onPressed: () async => await launch('https://wa.me/601111817544'), icon: Icon(Icons.chat), label: Text('WhatsApp'), style: ElevatedButton.styleFrom(backgroundColor: Colors.green)))])
        ] else...[
          TextField(decoration: InputDecoration(labelText: title, hintText: isNepali?'पासपोर्ट / PNR नं हाल्नुहोस्':'Enter Passport / PNR', border: OutlineInputBorder())),
          SizedBox(height: 12),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: Text('${isNepali?'जाँच गर्नुहोस्':'Check'} $title'), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0D47A1), padding: EdgeInsets.all(14)))),
        ]
      ])),
    );
  }
  Widget _busCard(String n, String r, String t, String p, String d) => Card(child: ListTile(title: Text('$n - $p', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), subtitle: Text('$r • $t • $d', style: TextStyle(fontSize: 11)), trailing: ElevatedButton(onPressed: (){}, child: Text('Book'), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0D47A1)))));
}
class TranslatorScreen extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Translator 6 Language'), backgroundColor: Color(0xFF0D47A1)), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [Text('Nepali, Hindi, English, Malay, Maithili, Bhojpuri'), SizedBox(height: 15), TextField(maxLines: 3, decoration: InputDecoration(hintText: 'Boliye - Malaai paisa pathaunu cha...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))), SizedBox(height: 10), Icon(Icons.arrow_downward, color: Color(0xFF0D47A1)), SizedBox(height: 10), Container(width: double.infinity, padding: EdgeInsets.all(14), decoration: BoxDecoration(color: Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)), child: Text('Saya ingin hantar wang...', style: TextStyle(fontWeight: FontWeight.bold))), SizedBox(height: 20), Row(children: [Expanded(child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.mic), label: Text('Tap to Speak'), style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: EdgeInsets.all(14)))), SizedBox(width: 10), Expanded(child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.translate), label: Text('Translate'), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0D47A1), padding: EdgeInsets.all(14))))])]))); }
class ProfileScreen extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(isNepali? 'प्रोफाइल - रमेश':'Profile - Ramesh'), backgroundColor: Color(0xFF0D47A1)), body: SingleChildScrollView(padding: EdgeInsets.all(20), child: Column(children: [
      CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
      SizedBox(height: 10),
      Text('Ramesh Prasad Yadav', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Text('Founder - Sewa Check App | BUS Ticket Service', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
      Text('NP-MY-284759 ✅ Active', style: TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold)),
      SizedBox(height: 15),
      Card(child: ListTile(leading: Icon(Icons.phone, color: Colors.green), title: Text('+601111817544 - Malaysia'), onTap: () async => await launch('tel:+601111817544'))),
      Card(child: ListTile(leading: Icon(Icons.phone, color: Colors.blue), title: Text('+9779823008293 - Nepal'), onTap: () async => await launch('tel:+9779823008293'))),
      Card(child: ListTile(leading: Icon(Icons.email), title: Text('ry666372@gmail.com'), onTap: () async => await launch('mailto:ry666372@gmail.com'))),
      SizedBox(height: 15),
      Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)), child: Text(isNepali? 'सूचना: यो एप रमेश प्रसाद यादव द्वारा नेपाली दाजुभाइको सहयोगको लागि बनाइएको निजी सेवा एप हो। यो कुनै सरकारी निकायको आधिकारिक एप होइन।' : 'Disclaimer: This app is a private help app created by Ramesh Prasad Yadav. It is NOT an official app of any government body.', style: TextStyle(fontSize: 10, color: Colors.grey[700]), textAlign: TextAlign.center)),
      SizedBox(height: 15),
      Row(children: [Expanded(child: ElevatedButton.icon(onPressed: () async => await launch('tel:+601111817544'), icon: Icon(Icons.call), label: Text(isNepali?'कल गर्नुहोस्':'Call Now'), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0D47A1)))), SizedBox(width: 10), Expanded(child: ElevatedButton.icon(onPressed: () async => await launch('https://wa.me/601111817544'), icon: Icon(Icons.chat), label: Text('WhatsApp'), style: ElevatedButton.styleFrom(backgroundColor: Colors.green)))])
    ])));
  }
}

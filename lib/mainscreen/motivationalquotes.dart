import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:virtual_gym_coach/global/global.dart';
import 'package:virtual_gym_coach/mainscreen/mainscreen.dart';

class Quote {
  final String quote;
  final String author;

  Quote({required this.quote, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      quote: json['quote'],
      author: json['author'],
    );
  }
}

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  Quote? randomQuote;
  String? backgroundImageAsset;
  List<String> maleBackgroundImages = [
    'images/imgA.jpg',
    'images/man1.jpg',
    'images/imgC.jpg',
    'images/imgD.jpg',
    'images/imgE.jpg',
    'images/imgF.jpg',
    'images/imgG.jpg',
    'images/man2.jpg',
    'images/man3.jpg',
    'images/man4.jpg',

  ];

  List<String> femaleBackgroundImages = [
    'images/imgH.jpg',
    'images/imgI.jpg',
    'images/woman3.jpg',
    'images/woman4.jpg',
    'images/woman1.jpg',
  ];

  @override
  void initState() {
    super.initState();
    loadRandomQuote();
  }

  Future<void> loadRandomQuote() async {
    final quotesData = await DefaultAssetBundle.of(context).loadString('dataset/quotes.json');
    final quotes = json.decode(quotesData)['quotes'];

    final random = Random();
    final randomIndex = random.nextInt(quotes.length);
    final randomQuoteData = quotes[randomIndex];

    setState(() {
      if(userGender == UserGender.males){
        randomQuote = Quote.fromJson(randomQuoteData);
        final randomBackgroundIndex = random.nextInt(maleBackgroundImages.length);
        backgroundImageAsset = maleBackgroundImages[randomBackgroundIndex];
      }
      else{
        randomQuote = Quote.fromJson(randomQuoteData);
        final randomBackgroundIndex = random.nextInt(femaleBackgroundImages.length);
        backgroundImageAsset = femaleBackgroundImages[randomBackgroundIndex];
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Pumped Up!!!',
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width*0.06,
          color: secColor
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> const MainScreen()));
          },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: secColor,
              size: MediaQuery.of(context).size.width*0.06,
            )
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details){
          loadRandomQuote();
        },
        child: Container(
          decoration: BoxDecoration(
            image: backgroundImageAsset != null
                ? DecorationImage(image: AssetImage(backgroundImageAsset!),fit: BoxFit.cover,)
                : const DecorationImage(image: AssetImage('images/default_image.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.06,),
                  child: Text(
                    randomQuote?.quote ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width*0.06,
                      fontWeight: FontWeight.bold,
                      color: secColor
                    ),
                  ),
                ),
                Text(
                  '- ${randomQuote?.author ?? ''}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: secColor
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

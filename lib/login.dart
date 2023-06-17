import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_chat_client/resources/image_resources.dart';
import 'package:my_chat_client/style/main_style.dart';
import 'package:my_chat_client/resources/text_resources.dart';
void main() {
  runApp(const StartPanel());
}

class StartPanel extends StatelessWidget {
  const StartPanel({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TextResources.nameApp,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MainPanel(),
    );
  }
}


//Placeholder fajnie pokazuje wielksoci
class MainPanel extends StatelessWidget {

  const MainPanel({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const Expanded(flex: 1,child: SizedBox(),)
            ,
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("----------"),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: ButtonWhiteWithBorder(text: "I FORGOT MY PASSWORD", borderColor: const Color(0xff3B5999),),
                  ),
                  Text("----------")
                ],
              ),
            )
            ,
            
            const Spacer(),
            Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child:ButtonWithImage( text:"Google",imageAsset: "assets/google_icon.png",color:const Color(0xffFF3333)),
                  ),
                  Container(
                     margin: const EdgeInsets.all(10.0),
                     child: ButtonWithImage( text:"Facebook",imageAsset: "assets/facebook_icon.png",color:const Color(0xff3B5999)),
                  )
                ],
              )

              //ButtonWithImage( text:"Google",imageAsset: "assets/google_icon.png",color:const Color(0xffFF3333)),
            ),
          ],
        ),
      ),

    );
  }
}


class BigAppLogo extends StatelessWidget{
  static const logoMarginTop = 150.0;
  static const imageDimension = 250.0;
  const BigAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage(ImageResources.logoApp),
      width: imageDimension,
      height: imageDimension,
    );
  }

}

class NameApp extends StatelessWidget {
  static const letterSpacingInNameApp = 0.5;
  static const nameAppFontSize = 30.0;
  static const nameAppNameMargin = 20.0;

  const NameApp({super.key});

  @override
  Widget build(BuildContext context) {

    return Text(
      TextResources.nameApp,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
            color: Color(MainAppStyle.mainColorApp),
            letterSpacing: letterSpacingInNameApp,
            fontSize: nameAppFontSize,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

}

class ButtonWithImage extends StatelessWidget{
  late String textButton;
  late String imageButton;
  late Color colorBackground;
  ButtonWithImage({required String text,required String imageAsset,required Color color,super.key}){
      textButton = text;
      imageButton = imageAsset;
      colorBackground = color;
  }



  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon:  ImageIcon(
          AssetImage(imageButton),
        color: null,

      ),
      label: Text(textButton), // <-- Text
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0), backgroundColor: colorBackground, foregroundColor: Color(0xffffffff),
           minimumSize: Size(130, 50),
           maximumSize: Size(130, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          )
      ),
    );
  }


}


class ButtonWhiteWithBorder extends StatelessWidget{
  late String textButton;

  late Color colorBackground;
  ButtonWhiteWithBorder({required String text,required Color borderColor,super.key}){
    textButton = text;
    colorBackground = borderColor;
  }



  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: null,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
        side: MaterialStateProperty.all (BorderSide(width: 1.0, color: Color(0xff1184EF))),
        textStyle: MaterialStateProperty.all(const TextStyle(
            fontSize: 12.0,
        )),
      ),
      child:  Text(textButton),
    );
  }


}


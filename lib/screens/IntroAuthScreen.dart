import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:myvideo/authentication/NavigateAuthScreen.dart';
import 'package:myvideo/variable.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Welcome',
          body: 'Welcome to myvideo, the best video conferencing app',
          image: Center(
            child: Image.asset(
              "assets/Images/welcome.png",
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20, Colors.black),
            titleTextStyle: mystyle(20, Colors.black),
          )
        ),
        PageViewModel(
            title: 'Join or create meetings',
            body: 'Easy to use interface, join or create meetings in fast timeouts',
            image: Center(
              child: Image.asset(
                "assets/Images/conference.png",
                height: 175,
              ),
            ),
            decoration: PageDecoration(
              bodyTextStyle: mystyle(20, Colors.black),
              titleTextStyle: mystyle(20, Colors.black),
            )
        ),
        PageViewModel(
            title: 'Security',
            body: 'Your security is important to us.',
            image: Center(
              child: Image.asset(
                "assets/Images/secure.jpg",
                height: 175,
              ),
            ),
            decoration: PageDecoration(
              bodyTextStyle: mystyle(20, Colors.black),
              titleTextStyle: mystyle(20, Colors.black),
            )
        ),
      ],
      onDone: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigateAuthScreen()));
      },
      onSkip: (){},
      skip: Icon(Icons.skip_next, size: 45),
      next: Icon(Icons.arrow_forward_ios),
      showSkipButton: true,
      done: Text(
        "Done",
        style: mystyle(20, Colors.black),
      ),
    );
  }
}

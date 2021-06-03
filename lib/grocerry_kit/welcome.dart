import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'Place of Meeting',
                   style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, letterSpacing: 2.0, color: Colors.green),
                ),
                Icon(
                    Icons.people_alt_outlined,
                    size: 50.0,
                    color: Colors.green,
                ),
                SizedBox(
                  height: 230,
                ),
                Container(
                  margin: EdgeInsets.only(top: 32, bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  width: 250,
                  child: FlatButton(
                    child: Text('Sign In',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/grocerry/login');
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0, bottom: 16),
                  decoration: BoxDecoration(
                    // color: Colors.green,
                    border: Border.all(color: Colors.green),
                    // shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  width: 250,
                  child: FlatButton(
                    child: Text('Sign Up',
                        style: TextStyle(fontSize: 20, color: Colors.green)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/grocerry/signup');
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

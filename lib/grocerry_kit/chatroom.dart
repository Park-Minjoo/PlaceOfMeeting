import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.green,
  accentColor: Colors.orangeAccent[400],
);

String _name = 'Your Name';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatRoom',
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: ChatScreen(),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({@required this.text, @required this.animationController});
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_name, style: Theme.of(context).textTheme.bodyText1),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Text(_name[0])),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;

  Future<int> getChat(TextEditingController msg) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting',
        password: 'databaseproject'
    ));

    // var t = await conn.query();
    var results = await conn.query(
        'insert into chat_records values (?, ?, ?, ?, ?)',
        [msg.text, msg.text, msg.text, msg.text, msg.text]
    );

    if(results.isNotEmpty){
      for(var row in results){
        if(msg.text == '${row[0]}'){
          print('DEBUG' + msg.text + '${row[0]}');
          return 1;
        }
      }
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatRoom'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        automaticallyImplyLeading: true,
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop,
        )
      ),

      body: Container(
        decoration: Theme.of(context).platform == TargetPlatform.iOS //new
            ? BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey[200]),
          ),
        )
            : null,
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                    // Icon(Icons.directions_run);
                  });
                },
                onSubmitted: _isComposing ? _handleSubmitted : null,
                decoration:
                InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: _focusNode,
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child:
                Theme.of(context).platform == TargetPlatform.iOS ?
                CupertinoButton(
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null,
                  child: _isComposing ?
                  Icon(Icons.directions_run) : Icon(Icons.directions_walk),
                )
                    :
                IconButton(
                  icon: Icon(Icons.directions_walk),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null,
                )
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    var message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
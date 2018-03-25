import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpeechRecognition _speech;
  var s=1;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';

  String _currentLocale = 'To The Customer';

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('ParktheVehcile'),
        ),
        body: new Padding(
            padding: new EdgeInsets.all(8.0),
            child: new Center(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  new Expanded(
                      child: new Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey.shade200,
                          child: new Text(transcription))),
                  _buildButton(
                    onPressed: _speechRecognitionAvailable && !_isListening
                        ? () => start()
                        : null,
                    label: _isListening
                        ? 'Listening...'
                        : 'Listen',
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildButton({String label, VoidCallback onPressed}) => new Padding(
      padding: new EdgeInsets.all(12.0),
      child: new RaisedButton(
        color: Colors.red.shade600,
        onPressed: onPressed,
        child: new Text(
          label,
          style: const TextStyle(color: Colors.yellow),
        ),
      ));

  void start() => _speech
      .listen(locale: _currentLocale)
      .then((result) 
      { 
        print('_MyAppState.start => result ${result}');
      });

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) =>
      setState(() => _currentLocale = locale);

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) { 
    setState(() 
            { 
              transcription = "The person says " + text;
            }
            );
            //This is the array used
    List l=['West Mambalam','Anna Nagar','Nungambakkam','Kodambakkam','Tambaram'];
    bool k;
    s=s+1;
    print("s is $s");
    for (var i = 0; i < 5; i++) 
      {
      k=text.contains(l[i]);
      //The actual text is here which we speak
      print(text);
      print("k has a vakue which is $k and ${l[i]}");
      //This checks whether the array contains the text
      print(text.contains(l[i]));
      if(k==true)
      print("yes it contains the place");
      else
      print("no it does not contain the place");
      }
  }

  void onRecognitionComplete() => setState(() => _isListening = false);

}
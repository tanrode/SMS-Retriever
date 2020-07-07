import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main(List<String> args) {
  runApp(smsTest());
}

/*Future getSMS(SmsQuery sms) async
{
  return await sms.querySms({
    address: getContactAddress()
});
}*/

class smsTest extends StatefulWidget {
  @override
  _smsTestState createState() => _smsTestState();
}

class _smsTestState extends State<smsTest> {
  SmsQuery sms=new SmsQuery();
  SmsReceiver receiver = new SmsReceiver();
  FlutterTts flutterTts = FlutterTts();
  String msg='';
  String sender='';
  List content=new List();
  String upi='';
  String username='';
  List<String> upiID=[];
  int x;
  listenSMS()
  {
      receiver.onSmsReceived.listen((SmsMessage s) {
        content=s.body.split(' ');
        print(s.body);
        print(s.address);
        print(content[content.length-1]);
        upiID=content.where((e) => e.contains('@ok')).toList();
        /*outer:for(int i=0;i<content.length;i++)
            {
              for(int j=0;j<content[i].length();j++)
                if(content[i].charAt(j)=='@')
                {
                  x=i;
                  break outer;
                }
            }
          */  
        if(s.address.compareTo('+918217229861')==0)
        {
            setState(() {
            msg=s.body;
            sender=s.address;
            upi=content[content.length-1];
            username=upiID[0].split('@')[0];     
          });
        }
        print(username);
    });
  }

  List messages=new List();
  
  fetchSMS() async
  {
    //messages = await sms.getAllSms;
    /*await sms.querySms(
      address: '+918217229861',
    );
    */
     listenSMS();
  }

  @override
  initState() 
  {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black45,
        appBar: AppBar(
          title: Text('SMS Retriever'),
          centerTitle: true,
          backgroundColor: Colors.blue[300],
        ),
        body: FutureBuilder(
        future: fetchSMS() ,
        builder: (context, snapshot)
                  {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top:10.0),
                      child: Column(
                        children: <Widget>[
                          Container(padding: EdgeInsets.symmetric(vertical: 8.0,horizontal:14.0) ,width: MediaQuery.of(context).size.width*0.8, decoration: BoxDecoration(color: Colors.green[500]), child: Text('Sender: '+sender+'\n____________________________Content: \n'+msg+'\n____________________________\nUPI Ref No: \n'+upi+'\n____________________________\nUsername: \n'+username, style: TextStyle(color:Colors.white,fontSize: 20),)),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    );
                  }  
      ),)
      );
    }
}
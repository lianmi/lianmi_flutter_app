import 'dart:async';
import 'package:flutter/material.dart';
import 'package:aly_oss/aly_oss.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

const bucketName = 'lianmi-ipfs';
const endpoint = 'https://oss-cn-hangzhou.aliyuncs.com';
const accessKeyId = 'STS.NUyEGCkFxMKtQguYc75HwahTh';
const accessKeySecret = 'Cc4GxLvQ2rqNsL4xA9JvQBHDvsNqXddnYEowz4dkRNCE';
const securityToken =
    'CAISmQV1q6Ft5B2yfSjIr5bMDv33hplZ+omfU0HEvWNiOcdbjq3/ijz2IHhFfXNqBuwasfU+nGpX7vYblq94T55IQ1Cc1EjPGgsRo22beIPkl5Gfa9dm4cTXmQPxZjf/2MjNGeybKPrWZvaqbX3diyZ32sGUXD6+XlujQ7zr7Jl8dYY4UxWfZzhLD8s0QQx5s50+NGDNEvyvPxX2mQi1C1Fz6DJhlUR166m03q/s7QHF3nTwzfUJgpn1Ppm8ZtNwAY97VN65pn8cFMz73TVX9gJB+YpvkaVA4k2nhNyGBERL6Bj0hYC2v9RkN11+fbNoWfwG/vz9nPt9u6nSj4rsjB9TNP1cST+YRYz5h4mmXOqiLYQ+bq2peSaPgNSOP5/wskYleXwAcwxHfdc7I3t5FxUwQyvBba6roReIAE6qQLPX17otg9gnjQfs/NOMIlnKQq2XymEdIZB7bk9xcFx0l2Xqaf0BaBceMQElVbKURIN2bVVfsa3z+gjJWTYnz30O+L+cKfrdofIYcp6tHMAEg44cbZJDsi4rV1rsDKq0jUsJf3B+Brdaie6vW9O246TXx/6IM6yUSKIDu1xcdDGUrjKDUjRLMSrr68ZkaFbBvIazgKXH6MFnCxB8pIIdXwWEeNBorhln+6WpqBOJ/OL5STer8jN/uLuX9oJUu0x/ZaXm0a3Auj/XunmRJKghltyQRGBmRBW8fHpih/Ge3zVFxVsImHrmPA0EuRbDlzS0fcQd1/3Ox2tKGeBOgunCUHCh8jwnS/DxuuxQAb8+IrATDarigF82nceK9UPg59fz1j5+fPPxerccZIpFPgn++qyFb6tNwb47VWWhJfID+9oGnUbPj20xuMENftI+BktACp06e7aIrJ4WARW5LiSl+hqAASUp4v7QG5u3jw+8cVHZOKE/A4Xocnlj5ptZVXBU+JZi+L+b6WiHVWH4EiRI3auxpERYD9wVxp7nB2wIve7A9MmcVDmUQq4NzmhwJMQ/In2lFYKn';
const expiration = '2021-02-05T19:05:43Z';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final _uuid = Uuid();
  final AlyOss _alyOss = AlyOss();
  StreamSubscription<UploadResponse> subscription;

  @override
  void initState() {
    super.initState();

    subscription = _alyOss.onUpload.listen((data) {
      print(data.toString());
      if (data.success) {
      } else {}
    });
  }

  @override
  void dispose() {
    if (subscription != null) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Aly Oss Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('INIT'),
                onPressed: () async {
                  var result = await _alyOss.init(InitRequest(
                      _uuid.v4(),
                      endpoint,
                      accessKeyId,
                      accessKeySecret,
                      securityToken,
                      expiration));

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("INIT"),
                        content: Text(result['instanceId']),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('UPLOAD'),
                onPressed: () async {
                  // var image =
                  //     await ImagePicker(source: ImageSource.gallery);

                  // _alyOss.upload(UploadRequest(_uuid.v4(), bucketName,
                  //     'products/id1/a.jpg', image.absolute.path));
                },
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('EXIST'),
                onPressed: () async {
                  var result = await _alyOss.exist(
                      KeyRequest(_uuid.v4(), bucketName, 'msg/id1/a.jpg'));

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("EXIST"),
                        content: Text(result['exist']),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('DELETE'),
                onPressed: () async {
                  var result = await _alyOss.delete(
                      KeyRequest(_uuid.v4(), bucketName, 'msg/id1/a.jpg'));

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("DELETE"),
                        content: Text('OK'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 180,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

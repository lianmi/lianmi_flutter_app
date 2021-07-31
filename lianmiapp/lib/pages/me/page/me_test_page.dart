import 'dart:async';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/res/styles.dart';
import 'package:lianmiapp/widgets/my_app_bar.dart';

class MeTestPage extends StatefulWidget {

  @override
  _MeTestPageState createState() => _MeTestPageState();
}

class _MeTestPageState extends State<MeTestPage> {
  var completer = Completer();
  Future? zyn;


  @override
  void initState() { 
    super.initState();
    zyn = completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          centerTitle: '测试',
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text('test', style: TextStyles.textBold14,),
              onPressed: (){
                _clickTest();
              },
            ),
            MaterialButton(
              child: Text('complete zyn', style: TextStyles.textBold14,),
              onPressed: (){
                _complete();
              },
            ),
            MaterialButton(
              child: Text('err zyn', style: TextStyles.textBold14,),
              onPressed: (){
                _completeError();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _clickTest() {
    zyn!.then((value) {
      print(value);
    }).catchError((err) {
      print(err);
    });
    // doStuff().then((value) {
    //   print(value);
    // });
    // Stream.fromFutures([
    //   // 1秒后返回结果
    //   Future.delayed(new Duration(seconds: 3), () {
    //     return "任务1完成";
    //   }),
    //   // 抛出一个异常
    //   Future.delayed(new Duration(seconds: 6),(){
    //     throw AssertionError("任务2失败");
    //   }),
    //   // 3秒后返回结果
    //   Future.delayed(new Duration(seconds: 1), () {
    //     return "任务3完成";
    //   })
    // ]).listen((data){
    //   print(data);
    // }, onError: (e){
    //   print(e.message);
    // },onDone: (){

    // });
  }

  Future<String> someAsyncOperation() async{
    await Future.delayed(new Duration(seconds: 3), () {
    });
    return '我是someAsyncOperation的返回值';
  }

  Future someOtherAsyncOperation(String result) async {
    print('我在someOtherAsyncOperation打印:$result');
    return;
  }

  Future<String> doStuff(){
    return someAsyncOperation().then((result) {
      return 'doStuff的返回值';
      // return someOtherAsyncOperation(result);
    });
  }

  void _complete() {
    completer.complete('返回了');
  }

  void _completeError() {
    completer.completeError('抛出异常了');
  }
}


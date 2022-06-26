
import 'dart:math';
import 'package:eng_apli/api/NotificationFirebase.dart';
import 'package:eng_apli/api/notifications_api.dart';
import 'package:eng_apli/awesomeNotifications.dart';
import 'package:eng_apli/controllers/patron_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';
import './database/db.dart';
import './models/models.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:convert';
import './globals.dart' as globals;
import 'package:rxdart/rxdart.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eng_apli/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:card_swiper/card_swiper.dart';

Future<void> backgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  print(message.notification!.title);
}

final onNotifications2=BehaviorSubject<String?>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  AwesomeNotifications().initialize('resource://drawable/ic_stat_spider', [
    NotificationChannel(channelKey: "basic_channel",
      channelName: "channelName",
      channelDescription: "channelDescription",
      defaultColor: Colors.teal,
      importance: NotificationImportance.Max,
      channelShowBadge: true,
      enableVibration: true,

      ledColor: Colors.white

    ),
    NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        locked: false,
        defaultColor: Colors.teal,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelDescription: "shedul is mejor",
        channelShowBadge: true
    ),



  ]);
  Workmanager().initialize(callbackDispatcher2,isInDebugMode: false);
  // Workmanager().initialize(
  //     // The top level function, aka callbackDispatcher
  //     callbackDispatcher,
  //     // If enabled it will post a notification whenever
  //     // the task is running. Handy for debugging tasks
  //     isInDebugMode: false);
  // Periodic task registration
  runApp(const MyApp2());
}
void callbackDispatcher2()async{
  Workmanager().executeTask((taskName, inputData) async{
    List<String> images=["https://img.freepik.com/vector-gratis/lindo-gato-donut-estilo-dibujos-animados-plana_138676-2624.jpg?size=338&ext=jpg",
    "https://img.freepik.com/vector-gratis/ilustracion-dibujos-animados-lindo-rey-cerdo-gafas-concepto-animal-aislado-caricatura-plana_138676-2291.jpg?size=338&ext=jpg",
    "https://img.freepik.com/vector-gratis/lindo-gato-malo-traje-gafas-sol-ilustracion-icono-dibujos-animados-bate-beisbol-concepto-icono-moda-animal-aislado-estilo-dibujos-animados-plana_138676-2170.jpg?size=338&ext=jpg",
    "https://img.freepik.com/vector-gratis/ilustracion-icono-vector-dibujos-animados-lindo-gato-mano-concepto-icono-naturaleza-animal-aislado-premium-vector-estilo-dibujos-animados-plana_138676-4085.jpg?size=338&ext=jpg",
    "https://img.freepik.com/vector-gratis/kitsune-lindo-personaje-dibujos-animados-espada-objeto-arte-aislado_138676-3159.jpg?size=338&ext=jpg",
    "https://img.freepik.com/vector-gratis/personaje-dibujos-animados-lindo-gato-aguacate-fruta-animal-aislada_138676-3141.jpg?size=338&ext=jpg",
    "https://img.freepik.com/vector-gratis/ejemplo-lindo-icono-vector-historieta-nino-monstruo-concepto-icono-vacaciones-monstruo-aislado-vector-premium-estilo-dibujos-animados-plana_138676-3995.jpg?size=338&ext=jpg",
    "https://img.freepik.com/vector-gratis/gato-lindo-ilustracion-icono-vector-dibujos-animados-hueso-pescado-concepto-icono-naturaleza-animal-aislado-premium-vector-estilo-dibujos-animados-plana_138676-4270.jpg?size=338&ext=jpg",
    "https://img.freepik.com/vector-gratis/astronauta-flotando-ilustracion-icono-vector-historieta-globo-estrella-concepto-icono-tecnologia-ciencia-aislado-vector-premium-estilo-dibujos-animados-plana_138676-3404.jpg?size=338&ext=jpg",
    "https://img.freepik.com/vector-gratis/lindo-astronauta-montando-cohete-agitando-mano-icono-dibujos-animados-ilustracion-concepto-icono-tecnologia-ciencia_138676-2130.jpg?size=338&ext=jpg",
    "https://img.freepik.com/vector-gratis/lindo-conejo-sosteniendo-zanahoria-dibujos-animados-vector-icono-ilustracion-animal-naturaleza-icono-concepto-aislado_138676-5071.jpg?size=338&ext=jpg",
    "https://img.freepik.com/vector-gratis/ilustracion-vector-dibujos-animados-lindo-corgi-beber-leche-te-boba-bebida-animal-concepto-aislado-vector-estilo-dibujos-animados-plana_138676-1943.jpg?w=2000",];
    var rng = Random();
    var num=rng.nextInt(inputData!["num"]);
    var num2=rng.nextInt(images.length);
    createPlantFoodNotification(inputData["arrays"][num],{"word":inputData["arrays"][num], "answer":inputData["array2"][num]},images[num2]);
    //_showNotificationWithDefaultSound2(inputData["arrays"][num],inputData["array2"][num]);
    return Future.value(true);});

}
void callbackDispatcher() async{
  Workmanager().executeTask((task, inputData) async {
    // initialise the plugin of flutterlocalnotifications.
    var rng = Random();
    print(inputData!["num"]);
    print(inputData["arrays"][0]);
    print(inputData["array2"][0]);
    var num=rng.nextInt(inputData["num"]);
    FlutterLocalNotificationsPlugin flip =
        FlutterLocalNotificationsPlugin();
    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = const AndroidInitializationSettings('@drawable/spider');
    var IOS = const IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = InitializationSettings(android: android, iOS: IOS);
    flip.initialize(
      settings,
      onSelectNotification: (payload) async => {
      debugPrint('notification payload: ' + payload!),
        print(payload),
        onNotifications2.add(payload)

      },
    );
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flip.getNotificationAppLaunchDetails();
    String? payload=notificationAppLaunchDetails!.payload;
    print(payload);
    _showNotificationWithDefaultSound(flip,inputData["arrays"][num],inputData["array2"][num]);
    return Future.value(true);
  });
}



Future _showNotificationWithDefaultSound(flip,String word,String payload) async {
  print(payload);
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id', 'Improve',
      importance: Importance.max,
      priority: Priority.high,
      color: Colors.teal,
      channelShowBadge: true,
      ledColor: Colors.white

  );
  var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flip.show(
      0,
      'GeeksforGeeks',
      word,
      platformChannelSpecifics,
      payload: payload,
  );
 // createPlantFoodNotification(word,payload);

}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'SpiderKills'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  var palabra = Word( word: "robodadto", respuesta: "ldfsaspi6");
  int _counter = 0;
  List<Answer> pa = [];
  var ss;
  keti() async {
     globals.answer= await procesDb.answers();
    print(globals.answer);
    setState(() {
      pa = globals.answer;
    });
  }

  @override
  void initState(){
    super.initState();
    print("si corri ");
    LocalNotificationService.initialize(this.context);
    //NotificationApi.init();
     //listenNotification();

     //Background
    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          if (message.data['ruta'] != null) {
            Navigator.of(this.context).push(
              MaterialPageRoute(
                builder: (context) => DemoScreen(
                  id: message.data['_id'],
                ),
              ),
            );
          }
        }
      },
    );


     //Foreground
     FirebaseMessaging.onMessage.listen((message) {
       if(message.notification !=null){
         print("entre en firebase");
         print(message.notification!.body);
         print(message.notification!.title);
       }
       LocalNotificationService.display(message);

     });

     FirebaseMessaging.onMessageOpenedApp.listen((message) {
       final route=message.data["route"];
       print(route);
     });


    // listenNotification2();
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if(!isAllowed){
    //     showDialog(context: this.context, builder: (context)=>AlertDialog(
    //       title: Text("Allaw Notifications"),
    //       content: Text ('Ouer app would like to send your notifications'),
    //       actions: [
    //         TextButton(onPressed: (){
    //         Navigator.pop(context);
    //       },
    //           child: Text('Dond allow',style: TextStyle(color: Colors.black12,fontSize: 18),)
    //       ),
    //         TextButton(
    //             onPressed: ()=>AwesomeNotifications().requestPermissionToSendNotifications().
    //             then((_) => Navigator.pop(context)),
    //             child: Text('Allaw',
    //           style: TextStyle(color: Colors.teal,fontSize: 18,fontWeight: FontWeight.bold),))
    //       ],
    //     )
    //
    //     );
    //   }
    //   else{
    //     print("falooo esta mierda");
    //   }
    // });
    AwesomeNotifications().createdStream.listen((notification) {
      ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
          content: Text("Notification Created on ${notification.channelKey}")));
    });
    AwesomeNotifications().actionStream.listen((event) {
      print(event.payload);
      Navigator.pushAndRemoveUntil(
          this.context, MaterialPageRoute(builder:(_) =>TercePage(payload: event.payload!,)),
              (route) =>route.isFirst );
    });

    requestUserPermissions(this.context, channelKey: 'basic_channel', permissionList: mis_permisos);
  }
  List<NotificationPermission> mis_permisos=[
    NotificationPermission.Alert,
    NotificationPermission.Sound,
    NotificationPermission.Badge,
    NotificationPermission.PreciseAlarms,
    NotificationPermission.Light,
    NotificationPermission.Vibration,
    NotificationPermission.FullScreenIntent,

  ];

  static Future<List<NotificationPermission>> requestUserPermissions(
      BuildContext context,{
        // if you only intends to request the permissions until app level, set the channelKey value to null
        required String? channelKey,
        required List<NotificationPermission> permissionList}
      ) async {

    // Check if the basic permission was conceived by the user
    // if(!await requestBasicPermissionToSendNotifications(context))
    //   return [];

    // Check which of the permissions you need are allowed at this time
    List<NotificationPermission> permissionsAllowed = await AwesomeNotifications().checkPermissionList(
        channelKey: channelKey,
        permissions: permissionList
    );

    // If all permissions are allowed, there is nothing to do
    if(permissionsAllowed.length == permissionList.length)
      return permissionsAllowed;

    // Refresh the permission list with only the disallowed permissions
    List<NotificationPermission> permissionsNeeded =
    permissionList.toSet().difference(permissionsAllowed.toSet()).toList();

    // Check if some of the permissions needed request user's intervention to be enabled
    List<NotificationPermission> lockedPermissions = await AwesomeNotifications().shouldShowRationaleToRequest(
        channelKey: channelKey,
        permissions: permissionsNeeded
    );

    // If there is no permissions depending on user's intervention, so request it directly
    if(lockedPermissions.isEmpty){

      // Request the permission through native resources.
      await AwesomeNotifications().requestPermissionToSendNotifications(
          channelKey: channelKey,
          permissions: permissionsNeeded
      );

      // After the user come back, check if the permissions has successfully enabled
      permissionsAllowed = await AwesomeNotifications().checkPermissionList(
          channelKey: channelKey,
          permissions: permissionsNeeded
      );
    }
    else {
      // If you need to show a rationale to educate the user to conceived the permission, show it
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Color(0xfffbfbfb),
            title: Text('Awesome Notificaitons needs your permission',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image.asset(
                //   'assets/images/animated-clock.gif',
                //   height: MediaQuery.of(context).size.height * 0.3,
                //   fit: BoxFit.fitWidth,
                // ),
                Text(
                  'To proceede, you need to enable the permissions above'+
                      (channelKey?.isEmpty ?? true ? '' : ' on channel $channelKey')+':',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  lockedPermissions.join(', ').replaceAll('NotificationPermission.', ''),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: (){ Navigator.pop(context); },
                  child: Text(
                    'Deny',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  )
              ),
              TextButton(
                onPressed: () async {

                  // Request the permission through native resources. Only one page redirection is done at this point.
                  await AwesomeNotifications().requestPermissionToSendNotifications(
                      channelKey: channelKey,
                      permissions: lockedPermissions
                  );

                  // After the user come back, check if the permissions has successfully enabled
                  permissionsAllowed = await AwesomeNotifications().checkPermissionList(
                      channelKey: channelKey,
                      permissions: lockedPermissions
                  );

                  Navigator.pop(context);
                },
                child: Text(
                  'Allow',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
      );
    }

    // Return the updated list of allowed permissions
    return permissionsAllowed;
  }
  static requestBasicPermissionToSendNotifications(BuildContext context) {

  }


  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  void listenNotification(){
      NotificationApi.onNotifications.stream.listen(onClickNoti);
  }
  // void listenNotification2(){
  //   NotificationApi.onNotifications.stream.listen(onClickNoti2);
  // }
  //
  void onClickNoti(String? payload)=>
      Navigator.of(this.context).push(MaterialPageRoute(builder: (context)=>SecondPage(payload:payload),
      ));
  // void onClickNoti2(String? payload)=>
  //     Navigator.of(this.context).push(MaterialPageRoute(builder: (context)=>SecondPage(payload:payload),
  //     ));
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await blocks.init();
    await  blocks.findCheckWords();
   }
  void _incrementCounter() {
    setState(() {
      //_counter++;
      // var count = Random().nextInt(pa.length - 1);
      //ss = pa[0].word;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body:Center(
        child: StreamBuilder<List<CheckWordsData>>(
          stream: blocks.chekWodsStream,
          builder: (context,AsyncSnapshot<List<CheckWordsData>> snapshot){
            if (snapshot.data==null || snapshot.data!.isEmpty){
              return Container(
                child: Center(
                    child: MaterialButton(
                      elevation: 15,
                      minWidth: 100,
                      height: 40,
                      onPressed: () {
                        AddWord(context);
                      },
                      color: Colors.deepOrange,
                      child: const Text(
                        "Add Topic",
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
              );
            }
            else{
              return Column(
                children: [
                  Cartas(context, snapshot.data!),
                  //MySwiper(datos: snapshot.data!, context: context),

                  const SizedBox(height: 60,),
                  Container(                    
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          style: style,
                          onPressed: (){
                            AddWord(context);
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60,),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          heroTag: "btn7",
                          onPressed: ()async{
                            showDialog(
                                context: context,
                                builder: (_) => new AlertDialog(
                                  content: Text("interval minimum 15 minutes",textAlign: TextAlign.center,),
                                  alignment: Alignment.center,
                                  actions: [
                                    OutlinedButton(onPressed: (){
                                      showTimerPicker(context);
                                    }, child: Text("Interval")),

                                    OutlinedButton(onPressed: (){
                                      if(globals.minutos.abs().inMinutes<15){
                                        ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
                                              backgroundColor: Colors.pinkAccent,
                                                  content: Text("Minimum interval 15 minutes")));
                                      }
                                      else{
                                          List<String> array1=[];
                                          List<String> array2=[];
                                          snapshot.data?.asMap().forEach((key, value) {array2.add(value.answer);
                                          array1.add(value.word);});
                                          Workmanager().registerPeriodicTask(
                                          "2",
                                                                //This is the value that will be
                                                                // returned in the callbackDispatcher
                                          "simplePeriodicTask",

                                                                // When no frequency is provided
                                                                // the default 15 minutes is set.
                                                                // Minimum frequency is 15 min.
                                                                // Android will automatically change
                                                                // your frequency to 15 min
                                                                // if you have configured a lower frequency.
                                          frequency:globals.minutos,
                                          inputData: {
                                            "num":array1.length,
                                            "arrays":array1,
                                            "array2":array2
                                                           }
                                                );

                                          Navigator.pop(context);

                                          ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
                                              backgroundColor: Colors.pinkAccent,
                                              content: Text("Interval of ${globals.minutos.abs().inMinutes} minutes created")));



                                      }

                                      // createRepeatNotification();
                                      // NotificationApi.periodicalNotification(title: "perron",body: "este es una pruba");


                                    }, child: Text("Create",textAlign: TextAlign.center,),),

                                    OutlinedButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("Cancel",textAlign: TextAlign.center,),)

                                  ],
                                  buttonPadding: EdgeInsets.all(15),
                                    title: const Text("Created notification",textAlign: TextAlign.center,)                                  ,
                                      ));


                            // showTimerPicker(context);
                            // if(globals.minutos.abs().inMinutes<15){
                            //   ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
                            //   backgroundColor: Colors.amber,
                            //       content: Text("Minimum interval 15 minutes")));
                            // }
                            // else{
                            //     List<String> array1=[];
                            //                        List<String> array2=[];
                            //                        snapshot.data?.asMap().forEach((key, value) {array2.add(value.answer);
                            //                                                                     array1.add(value.word);});
                            //
                            //                       Workmanager().registerPeriodicTask(
                            //                         "2",
                            //                         //This is the value that will be
                            //                         // returned in the callbackDispatcher
                            //                         "simplePeriodicTask",
                            //
                            //                         // When no frequency is provided
                            //                         // the default 15 minutes is set.
                            //                         // Minimum frequency is 15 min.
                            //                         // Android will automatically change
                            //                         // your frequency to 15 min
                            //                         // if you have configured a lower frequency.
                            //                         frequency: const Duration(minutes: 15),
                            //                         inputData: {
                            //                           "num":array1.length,
                            //                           "arrays":array1,
                            //                           "array2":array2
                            //                         }
                            //
                            //                       );
                            //
                            //     ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
                            //         content: Text("Interval of ${globals.minutos.abs().inMinutes} minutes created")));
                            //
                            // }


                          // createRepeatNotification(snapshot.data!);
                        },
                          backgroundColor: Colors.teal,
                          tooltip: 'Open Notification',
                          child: const Icon(Icons.ad_units_outlined),
                        ),
                        const SizedBox(width: 150,),
                        FloatingActionButton(
                            heroTag: "btn9",
                            onPressed: (){
                          ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(
                              content: Text("Notification Canceled")));
                          cancellshueNotification();
                          Workmanager().cancelByUniqueName("2");
                        },
                          tooltip: 'Open Notification',
                          backgroundColor: Colors.deepPurpleAccent,
                          child: const Icon(Icons.close)
                        )
                      ],
                    ),

                  )

                  // StreamBuilder<bool>(
                  //   stream: blockAppbar.appbarstream,
                  //     builder: (context,snapshot1){
                  //     print(snapshot1.data);
                  //       if (snapshot1.data==false || snapshot1.data==null){
                  //         return Container(
                  //           alignment: Alignment.center,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               FloatingActionButton(
                  //                 heroTag: "btn5",
                  //                 onPressed: (){
                  //                   var rng = Random();
                  //                   var num=rng.nextInt(snapshot.data!.length);
                  //
                  //                    List<String> array1=[];
                  //                    List<String> array2=[];
                  //                    snapshot.data?.asMap().forEach((key, value) {array2.add(value.answer);
                  //                                                                 array1.add(value.word);});
                  //                   //
                  //                   // Workmanager().registerPeriodicTask(
                  //                   //   "2",
                  //                   //   //This is the value that will be
                  //                   //   // returned in the callbackDispatcher
                  //                   //   "simplePeriodicTask",
                  //                   //
                  //                   //   // When no frequency is provided
                  //                   //   // the default 15 minutes is set.
                  //                   //   // Minimum frequency is 15 min.
                  //                   //   // Android will automatically change
                  //                   //   // your frequency to 15 min
                  //                   //   // if you have configured a lower frequency.
                  //                   //   frequency: const Duration(minutes: 15),
                  //                   //   inputData: {
                  //                   //     "num":array1.length,
                  //                   //     "arrays":array1,
                  //                   //     "array2":array2
                  //                   //   }
                  //                   //
                  //                   // );
                  //
                  //                   createRepeatNotification(snapshot.data![num].word, snapshot.data![num].answer);
                  //
                  //                   blockAppbar.appbar=true;
                  //                   blockAppbar.Providerappbar();
                  //
                  //                 },
                  //                 tooltip: 'Open Notification',
                  //                 child: const Icon(Icons.add),
                  //               ),
                  //               const SizedBox(width: 130),
                  //               const FloatingActionButton(
                  //                 heroTag: "btn4",
                  //                 onPressed: null,
                  //                 tooltip: 'Close Notification',
                  //                 backgroundColor: Colors.black12,
                  //                 child: Icon(Icons.close),
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       }
                  //       else{
                  //         return Container(
                  //           alignment: Alignment.center,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               const FloatingActionButton(
                  //                 heroTag: "btn3",
                  //                 onPressed: null,
                  //                 tooltip: 'Open Notification',
                  //                 backgroundColor: Colors.teal,
                  //                 child: Icon(Icons.add),
                  //               ),
                  //               const SizedBox(width: 130,),
                  //               FloatingActionButton(
                  //                 heroTag: "btn1",
                  //                 onPressed: (){
                  //                  // Workmanager().cancelByUniqueName("2");
                  //                   cancellshueNotification();
                  //                   blockAppbar.appbar=false;
                  //                   blockAppbar.Providerappbar();
                  //
                  //                 },
                  //                 tooltip: 'Close Notification',
                  //                 child: const Icon(Icons.close),
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       }
                  //     }
                  //
                  // )
                ],
              );
            }
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: "btn2",
      //   onPressed: (){
      //     //createPlantFoodNotification();
      //     createRepeatNotification("pencil","lapiz");
      //     // NotificationApi.periodicalNotification(
      //     //   title: "sapo hp",
      //     //   body: "mamaluco",
      //     //   payload: "Default_Sound",
      //     // );
      //
      //
      //
      //      // NotificationApi.showSheduleNotification(
      //      //   title: "dinner",
      //      //     body: "today",
      //      //     payload: "sapo hp",
      //      //     scheduledDate: DateTime.now().add(const Duration(seconds:12 )),
      //      // );
      //      //
      //      //  NotificationApi.ShowNotification(
      //      //    title: "pepe",
      //      //    body: "mamame el tubo",
      //      //    payload: 'el cangry'
      //      //  );
      //
      //     },
      // ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
class DemoScreen extends StatelessWidget{
  late String id;
  DemoScreen({required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text(id),
      ),

    );

  }

}


AddWord(BuildContext context){
  final key2 = GlobalKey<FormState>();
  late String words;
  late String answers;
  return showDialog(context: context, builder:(context){
    return AlertDialog(
      title: const Text("Add Words"),
      actions: [
       SingleChildScrollView(
         child:  Form(
              key: key2,
             child: Column(
           children: [
             TextFormField(
               decoration: const InputDecoration(
                   hintText: 'what do yo want learn?',
                   labelText: "Add words"
               ),
               onChanged: (text){
                 words =text;
               },
               validator: (text){
                 if (text!.isEmpty){
                   return "Add word";
                 }
               },
             ),
             TextFormField(
               decoration: const InputDecoration(
                   hintText: 'is its meaning',
                   labelText: "Add answer"
               ),
               onChanged: (text){
                 answers =text;
               },
               validator: (text2){
                 if (text2!.isEmpty){
                   return "Add word";
                 }
               },
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 MaterialButton(onPressed: ()async{
                   if(key2.currentState!.validate()){
                     CheckWords pal=CheckWords(words,answers);
                     await blocks.insertWords(pal);
                     await blocks.findCheckWords();
                     await check.init();
                     await blockAppbar.Providerappbar();
                      Navigator.pop(context);
                   }
                   else{

                   }

                 },
                   child: Text("ACCEPT"),),
                 const SizedBox(width: 80),
                 MaterialButton(
                     child: Text("CANCELAR"),
                     onPressed: () {
                       Navigator.pop(context);
                     })

               ],

             )
           ],
         )),
       )
      ],
    );
  });
}


Cartas(BuildContext context, List<CheckWordsData> datos){
  final _controller = SwiperController();
  // "animation: false" does the trick
  // "index" is the initial value when the swiper is shown

     return SizedBox(
         height: MediaQuery.of(context).size.height*0.5,
         width: MediaQuery.of(context).size.width,
           child:Container(
           padding: const EdgeInsets.all(15),
           child: Swiper(
             itemCount: datos.length,
             itemBuilder: (BuildContext context, int index) {
               //  Future.delayed(Duration(milliseconds: 1000), () {
               //   return Center(child: CircularProgressIndicator());
               // });



               return InkWell(
                 onLongPress: (){
                   showDialog(
                       context: context,
                       builder: (_) => new AlertDialog(
                         alignment: Alignment.center,
                         content: Text("Delete?",textAlign: TextAlign.center,),
                         actions: [
                           OutlinedButton(onPressed: ()async{
                             await blocks.deleteWord(datos[index].rowid,datos[index]);
                             Navigator.pop(context);
                           }, child: Text("Delete")),
                           SizedBox(width: 90,),
                           OutlinedButton(onPressed: (){
                             Navigator.pop(context);
                           }, child: Text("Cancel"))
                         ],

                       ));
                 },
                 child: FlipCard(
                   front:Container(color: Colors.deepOrangeAccent,child: Center(child: Text(datos[index].word,
                       style: TextStyle(fontStyle: FontStyle.normal,fontSize: 20)),)) ,
                   back: Container(color: Colors.amber, child: Center(child:Text(datos[index].answer,
                     style: TextStyle(fontStyle: FontStyle.normal,fontSize: 20),) ,),),
                 ),
               );

             },
             pagination: new SwiperPagination(),
             control: new SwiperControl(),
             viewportFraction: 0.8,
             scale: 0.9,
           ),
     )

     );
}

class TercePage extends StatelessWidget {
   final Map<String,String> payload;


  const TercePage({Key? key, required this.payload}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Tercer pagina"),
      ),
      body:Container( alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child:Column(
          children: [
            Text(payload.values.first),
            SizedBox(height: 50,),
            Text(payload.values.elementAt(1))
          ],
        )
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
class SecondPage extends StatelessWidget {
  final String? payload;

  const SecondPage({Key? key, this.payload}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Second page"),
      ),
      body:Container( alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: Text(payload??""),),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

 void showTimerPicker(BuildContext context) {
  Duration selectedValue;
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery
              .of(context)
              .copyWith()
              .size
              .height * 0.25,
          width: double.infinity,
          color: Colors.white,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
              initialTimerDuration: Duration(hours:0, minutes: 0),
              onTimerDurationChanged: (value) {
        globals.minutos = value;


        },
        )
        );
      }
  );

}
class MySwiper extends StatefulWidget {
  BuildContext context;
  List<CheckWordsData> datos;

   MySwiper({Key? key, required this.datos, required this.context}) : super(key: key);

  @override
  State<MySwiper> createState() => _MySwiperState();
}

class _MySwiperState extends State<MySwiper> {
  late List<CheckWordsData> datos=this.datos;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    print(datos);
    //reload();
  }

  Future reload()async{
    setState((){
      isLoading = true;
    });

     setState((){
       isLoading = false;

     });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // if (isLoading) {
    //   return Center(child: CircularProgressIndicator());
    // }
    // else{
    //   return Expanded(child:
    //     SizedBox(
    //       height: MediaQuery.of(this.context).size.height*0.5,
    //       width: MediaQuery.of(this.context).size.width,
    //       child:Container(
    //         padding: const EdgeInsets.all(15),
    //         child: Swiper(
    //           itemBuilder: (BuildContext context, int index) {
    //             return InkWell(
    //               onLongPress: (){
    //                 showDialog(
    //                     context: context,
    //                     builder: (_) => new AlertDialog(
    //                       alignment: Alignment.center,
    //                       content: Text("Delete?",textAlign: TextAlign.center,),
    //                       actions: [
    //                         OutlinedButton(onPressed: ()async{
    //                           await blocks.deleteWord(datos[index].rowid,datos[index]);
    //                           Navigator.pop(context);
    //                         }, child: Text("Delete")),
    //                         SizedBox(width: 90,),
    //                         OutlinedButton(onPressed: (){
    //                           Navigator.pop(context);
    //                         }, child: Text("Cancel"))
    //                       ],
    //
    //                     ));
    //               },
    //               child: FlipCard(
    //                 front:Container(color: Colors.deepOrangeAccent,child: Center(child: Text(datos[index].word,
    //                     style: TextStyle(fontStyle: FontStyle.normal,fontSize: 20)),)) ,
    //                 back: Container(color: Colors.amber, child: Center(child:Text(datos[index].answer,
    //                   style: TextStyle(fontStyle: FontStyle.normal,fontSize: 20),) ,),),
    //               ),
    //             );
    //           },
    //           pagination: new SwiperPagination(),
    //           itemCount: datos.length,
    //           viewportFraction: 0.8,
    //           scale: 0.9,
    //         ),
    //       )
    //
    //   ),
    //   );
    //
    // }

  }
}


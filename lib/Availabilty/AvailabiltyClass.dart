import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:salon_app/Global/ApiController.dart';
import 'package:salon_app/Global/Dialogs.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/Global/GlobalFile.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:salon_app/Global/NetworkCheck.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLocalizations.dart';

import '../CommonMenuClass.dart';
import 'ConfirmationClass.dart';


class AvailabiltyActivity extends StatefulWidget {

  var data_val;

  AvailabiltyActivity(
      this.data_val); // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title="cal";

  @override
  _AvailabiltyActivityState createState() => new _AvailabiltyActivityState();
}

class _AvailabiltyActivityState extends State<AvailabiltyActivity> {
  ScrollController _scrollController = ScrollController();

  static var now1 = new DateTime.now();
  int year=now1.year;
  DateTime _currentDate = DateTime(now1.year, now1.month, now1.day);
  DateTime _currentDate2 =  DateTime(now1.year, now1.month, now1.day);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2020, 10, 3));
  DateTime _targetDateTime =  DateTime(now1.year, now1.month, now1.day);
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.red,
        //borderRadius: BorderRadius.all(Radius.circular(2)),
        border: Border.all(color: Colors.blue, width: 1.0)),

  );

  String returnMonth(DateTime date) {
    return new DateFormat.MMMM().format(date).toUpperCase()+"  "+new DateFormat.y().format(date).toUpperCase();
  }
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2020, 10, 28): [
        new Event(
          date: new DateTime(2020, 10, 28),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2020, 10, 28),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2020, 10, 28),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  CalendarCarousel  _calendarCarouselNoHeader;

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    ///
    ///
    data=widget.data_val['store'];
    setState(() {

    });
    //SubmitData();
    for(int i=0;i<30;i+=4)
      {

        _markedDateMap.add(
            new DateTime(2020, 10, i),
            new Event(
              date: new DateTime(2020, 10, i),
              title: 'Event 5',
              icon: _eventIcon,
            ));

        _markedDateMap.add(
            new DateTime(2020, 10, i),
            new Event(
              date: new DateTime(2020, 10, i),
              title: 'Event 5',
              icon: _eventIcon,
            ));

      }
  /*  _markedDateMap.add(
        new DateTime(2020, 10, 28),
        new Event(
          date: new DateTime(2020, 10, 28),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2020, 10, 11), [
      new Event(
        date: new DateTime(2020, 10, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2020, 10, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2020, 10, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);*/
    for(int i=0;i<10;i++)
      {
        products.add("i $i");
      }
    setState(() {

    });
    super.initState();
  }  var data;

  String selected_date="";
  List<String> litems = ["1","2","Third","4"];
  _scrollToBottom(){  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
  @override
  Widget build(BuildContext context) {
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events)
      {
        this.setState(() => _currentDate2 = date);
        selected_date= new DateFormat.d().format(date).toUpperCase()+" - "+
           new DateFormat.MMMM().format(date).toUpperCase()+" - "+
           new DateFormat.y().format(date).toUpperCase()+"  "+DateFormat('EEEE').format(date);
       products=new List();

       setState(() {
         Timer(
           Duration(seconds: 1),
               () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
         );
       });

        print(_currentDate2);
       /* Utility.setStringPreference(GlobalConstant.Selected_Date, selected_date);
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (_) => new CommonDashBord("booking_page",true,widget.data_val)));*/
      /*  events.forEach((event){
          products.add(_currentDate2);
        });*/
      },
      daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 400.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
        borderRadius: const BorderRadius.all(const Radius.circular(1.0)),
      ),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.blue,
      ),
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 12,

      ),
      showHeader: true,
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return new Scaffold(
        body:  new Container(
          color: Colors.white,
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              data!=null?new Container(
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(0),
                    color: Colors.black,
                    image: DecorationImage(
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),

                        image: new NetworkImage(
                            widget.data_val['images'][0]['src']
                        ),
                        fit: BoxFit.fill
                    )
                ),
                child: new Column(
                  children: [

                    new Container(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: new Text(
                        GlobalFile.getCaptialize(widget.data_val['name']),
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),

                    SizedBox(height: 10.0,),

                    data['vendor_shop_logo']!=null?new InkWell(
                      onTap: (){
                        Utility.setStringPreference(GlobalConstant.Verder_Id, data['vendor_id'].toString());

                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (_) => new CommonDashBord("vendor_dtl",true)));
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xffFDCF09),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage:  NetworkImage(data['vendor_shop_logo']),
                        ),
                      ),
                    ):new Container(),
                    SizedBox(height: 10.0,),

                    Container(
                      alignment: Alignment.center,
                      child: new Text(
                        GlobalFile.getCaptialize(data['vendor_shop_name']),
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: new Text(GlobalFile.getCaptialize(data['vendor_address']),
                        style: TextStyle(fontSize: 14.0, color: Colors.white),),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      alignment: Alignment.center,
                      child: new Text(
                        "10:00 AM to 8:00 PM ",
                        style: TextStyle(fontSize: 14.0, color: Colors.blue),
                      ),
                    ),

                  ],
                ),
              ):new Container(),
              SizedBox(height: 10.0,),
              Container(
                alignment: Alignment.center,
                child: new Text(
                  AppLocalizations.of(context).translate("select_date"),
                  style: TextStyle(fontSize: 20.0, color: GlobalConstant.getTextColor()),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:10.0,right: 10.0),
                child: _calendarCarouselNoHeader,
              ),
              ListView.builder(
                  itemCount: 12,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){

                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (_) => new Confirmation( GlobalFile.getCaptialize(data['vendor_display_name']),selected_date)));

                      },
                      child: getData(index),
                    );
                  }),


            ],
          ),
        ));
  }


  getData(int index) {
    index=index+1;
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Row(
          children: [
            Expanded(flex: 1,
              child: Icon(Icons.add,size: 30.0,color: Colors.grey,),),
            SizedBox(width: 10.0,),
            Expanded(flex: 4,
              child: Text("Time : $index:00 AM "),),
            Expanded(flex: 5,
              child:
              new Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(AppLocalizations.of(context).translate('make_appoint'),style: TextStyle(color: GlobalConstant.getTextColor()),textAlign: TextAlign.right,),
              ),)
          ],
        ),
        new Divider(thickness: 1.0,)
      ],
    );
  }


  List products=new List();
  String TAG = "VenderAvailabiltyActivity";

  void SubmitData() async {
    /* Map<String, String> body =
    {
      'tour_destination_id': "${widget.taskId.toString()}",
      'status_id': _user.toString(),
      'salesman_comment': _description_controller.text.toString(),
    };

    print("body$body");
   */

    String Verder_Id = (await Utility.getStringPreference(GlobalConstant.Verder_Id));
    String Url = GlobalConstant.CommanUrl + "store-vendors/"+Verder_Id;

    ApiController apiController = new ApiController.internal();

    if (await NetworkCheck.check()) {
      Dialogs.showProgressDialog(context);
      apiController.Get(Url).then((value) {
        try {
          Dialogs.hideProgressDialog(context);
          var data1 = json.decode(value.body);
          data = data1;
          Utility.log(TAG, data1);
          if (data1.length != 0) {
            setState(() {});
          } else {
            GlobalWidget.showMyDialog(context, "Error", data1.toString());
          }
        } catch (e) {
          GlobalWidget.showMyDialog(context, "Error", "" + e.toString());
        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }


}
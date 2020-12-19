import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:salon_app/Global/AppColor.dart';
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
import 'package:salon_app/Profile/edit_billing_detail.dart';
import 'package:salon_app/language/AppLocalizations.dart';
import '../CommonMenuClass.dart';
import 'ConfirmationClass.dart';
class AvailabiltyActivity extends StatefulWidget
{
    var data_val;
    AvailabiltyActivity(this.data_val);
    final String title="cal";

    @override
    _AvailabiltyActivityState createState() => new _AvailabiltyActivityState();
}

class _AvailabiltyActivityState extends State<AvailabiltyActivity>
{
  String serevr_day,serevr_month,serevr_year;
  ScrollController _scrollController = ScrollController();
  static var now1 = new DateTime.now();
  int year=now1.year;
  DateTime _currentDate = DateTime(now1.year, now1.month, now1.day);
  DateTime _currentDate2 =  DateTime(now1.year, now1.month, now1.day);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2020, 10, 3));
  DateTime _targetDateTime =  DateTime(now1.year, now1.month, now1.day);
  String min_date=now1.year.toString()+"-"+now1.month.toString()+"-"+now1.day.toString();
  String max_date="";

   static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(2)),
        border: Border.all(color: Colors.blue, width: 1.0)),
  );

  String returnMonth(DateTime date)
  {
    return new DateFormat.MMMM().format(date).toUpperCase()+"  "+new DateFormat.y().format(date).toUpperCase();
  }

  EventList<Event> _markedDateMap = new EventList<Event>(events:
    {
      /*
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
      */
    },
  );

  CalendarCarousel  _calendarCarouselNoHeader;
  @override
  void initState()
  {
     var today = new DateTime.now();
     dateval=today;
     var OneDaysFromNow = today.add(new Duration(days: 1));
     max_date=OneDaysFromNow.year.toString()+"-"+OneDaysFromNow.month.toString()+"-"+OneDaysFromNow.day.toString();
     data=widget.data_val['store'];
     setState(()
     {
     });

      setServerDate(today);
      selected_date = new DateFormat.d().format(today).toUpperCase()+" - "+ new DateFormat.MMMM().format(today).toUpperCase()+" - "+ new DateFormat.y().format(today).toUpperCase()+"  "+DateFormat('EEEE').format(today);
      GetSlots();


    setState(() {
    });
    super.initState();
  }

  var data;
  String selected_date="";
  DateTime dateval;
  List<String> litems = ["1","2","Third","4"];

  @override
  Widget build(BuildContext context)
  {
      _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: GlobalConstant.getTextColor(),
      headerMargin: EdgeInsets.all(0.0),
      onDayPressed: (DateTime date, List<Event> events)
      {
        dateval=date;
        this.setState(() => _currentDate2 = date);
        selected_date = new DateFormat.d().format(date).toUpperCase()+" - "+
           new DateFormat.MMMM().format(date).toUpperCase()+" - "+
           new DateFormat.y().format(date).toUpperCase()+"  "+
           DateFormat('EEEE').format(date);
        setServerDate(date);
        products=new List();
        min_date=_currentDate2.year.toString()+"-"+_currentDate2.month.toString()+"-"+_currentDate2.day.toString();
        var OneDaysFromNow = _currentDate2.add(new Duration(days: 1));
        max_date=OneDaysFromNow.year.toString()+"-"+OneDaysFromNow.month.toString()+"-"+OneDaysFromNow.day.toString();
        GetSlots();
        print(_currentDate2);

       /*
        Utility.setStringPreference(GlobalConstant.Selected_Date, selected_date);
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (_) => new CommonDashBord("booking_page",true,widget.data_val)));
            */

      /*  events.forEach((event){
          products.add(_currentDate2);
        });*/
      },

      daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      // border in day
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 350.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
        markedDateCustomShapeBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
        borderRadius: const BorderRadius.all(const Radius.circular(1.0)),
      ),
      headerTextStyle: TextStyle(color: Colors.black,fontSize: 18.0),
      weekDayBackgroundColor: Colors.grey[200],
        weekDayPadding: EdgeInsets.all(8.0),
        weekdayTextStyle: TextStyle(color: Colors.black,fontSize: 10.0),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.blue,
      ),
      todayTextStyle: TextStyle(
        color: Colors.white,
      ),
      iconColor: Colors.black,
      todayButtonColor: GlobalConstant.getTextColor(),
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
     dayButtonColor: Colors.white,
     thisMonthDayBorderColor: Colors.white,
     selectedDayButtonColor: GlobalConstant.getTextColor(),
     selectedDayBorderColor: GlobalConstant.getTextColor(),
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

      showHeader: false,
      onCalendarChanged: (DateTime date)
      {
        this.setState(()
        {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date)
      {
        print('long pressed date $date');
      },
    );

    return new Scaffold(
        body:  new Container(
          color: Colors.white,
          child: ListView(
            controller: _scrollController,
            children: <Widget>[

              data!=null? new Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.black,
                    image: DecorationImage(
                        colorFilter: new ColorFilter.mode(Colors.grey.withOpacity(0.6), BlendMode.dstATop),
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
                      onTap: ()
                      {
                        Utility.setStringPreference(GlobalConstant.Verder_Id, data['vendor_id'].toString());
                        Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new CommonDashBord("vendor_dtl",true)));
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
                        style: TextStyle(fontSize: 14.0, color: Colors.white),textAlign: TextAlign.center,),
                    ),

                    SizedBox(height: 10.0,),

                    /*
                    Container(
                      alignment: Alignment.center,
                      child: new Text(
                        "10:00 AM to 8:00 PM ",
                        style: TextStyle(fontSize: 14.0, color: Colors.blue),
                      ),
                    ),
                    */

                  ],
                ),
              ):new Container(),

              Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: new Text(
                  AppLocalizations.of(context).translate("select_date"),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: GlobalConstant.getTextColor()),
                ),
              ),

              Container(
                padding: EdgeInsets.only(right: 15.0),
                margin: EdgeInsets.only(left:10.0,right: 10.0),
                color: Colors.grey[300],
                child: new Row(
                  children: <Widget>[
                    Expanded(flex: 1,
                      child:  FlatButton(
                        child: Icon(Icons.arrow_back_ios,size: 20.0,),
                        onPressed: () {
                          setState(()
                          {
                            _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month -1);
                            _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      ),
                    ),

                    Expanded(
                        flex: 8,
                        child: Text(
                          _currentMonth,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        )
                    ),

                    Expanded(flex: 1,
                      child: FlatButton(
                        child: Icon(Icons.arrow_forward_ios,size: 20.0,),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month +1);
                            _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      ),),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(left:10.0,right: 10.0),
                child: _calendarCarouselNoHeader,
              ),

              ListView.builder(
                  itemCount: AppointMent_List.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: ()
                      {
                        Utility.setStringPreference(GlobalConstant.Order_Name, GlobalFile.getCaptialize(data['vendor_display_name']));
                        Utility.setStringPreference(GlobalConstant.Order_Date,  selected_date);
                        Utility.setStringPreference(GlobalConstant.Order_Time, AppointMent_List[index].date);
                        var dateinmilli=dateval.millisecondsSinceEpoch;
                        var timezone=dateval.toUtc();
                       // removeCartData();

                       addCartData(index);

                         /*   Map<String, dynamic> appointment() =>
                            {
                              "timezone" : "Asia/Karachi",
                              "time" : AppointMent_List[index].date,
                              "qty" : "1",
                              "start_date" : dateinmilli,
                              "end_date" : dateinmilli,
                              "all_day" : "0",
                              "duration" : "60",
                              "cost" : "5"
                            };

                           print(appointment());*/
                           /*
                            Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new Confirmation()));
                          */
                      //  getExistData(appointment());

                      },
                      child: getData(index),
                    );
                  }),
            ],
          ),
        ));
  }

  var profile;

  void getExistData(var appointmentarray) async
  {
    String store_id = (await Utility.getStringPreference(GlobalConstant.store_id));
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    String Url = GlobalConstant.CommanUrlLogin + "wp/v2/users/"+store_id;
    String USER_ID = (await Utility.getStringPreference(GlobalConstant.store_id));
    ApiController apiController = new ApiController.internal();
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.GetWithMyToken(Url,token).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data1 = json.decode(value.body);
          // data = data1;
          Utility.log(TAG, data1['meta']);
          if (data1.length != 0)
          {
            profile=data1;
            setState(()
            {
              try
              {
                if(GlobalFile.getStringValue(profile['meta']['city'][0])==""|| GlobalFile.getStringValue(profile['meta']['state'][0])==""|| GlobalFile.getStringValue(profile['meta']['address_1'][0])==""|| GlobalFile.getStringValue(profile['meta']['postcode'][0])=="")
                {
                  Navigator.of(context).push(new MaterialPageRoute(builder: (_)=> new  CommonDashBord("edit_bill", true)),).then((val)
                  {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if(val!=null)
                    {
                      Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new Confirmation(val,appointmentarray)));
                    }
                  });
                }else{
                  Map<String, dynamic> mapBilling() => {
                    "first_name" : profile['meta']['first_name'][0],
                    "last_name" :  profile['meta']['last_name'][0],
                    "company" : "",
                    "address_1" :  profile['meta']['address_1'][0],
                    "address_2" :  profile['meta']['address_1'][0],
                    "city" :  profile['meta']['city'][0],
                    "state" :  profile['meta']['state'][0],
                    "postcode" :  profile['meta']['postcode'][0],
                    "email" :  profile['meta']['email'][0],
                    "phone" :  profile['meta']['phone'][0]
                  };
                  Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new Confirmation(mapBilling(),appointmentarray)));
                }
              }catch(e)
              {
                Navigator.of(context).push(new MaterialPageRoute(builder: (_)=> new  CommonDashBord("edit_bill", true)),).then((val)
                {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if(val!=null)
                  {
                    Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new Confirmation(val,appointmentarray)));
                  }
                });
              }
            });
          } else {
          }
        } catch (e)
        {

        }
      });
    } else {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }
  }

  void addCartData(var index) async
  {

    String store_id = (await Utility.getStringPreference(GlobalConstant.store_id));
    String token = (await Utility.getStringPreference(GlobalConstant.token));
    String Url = GlobalConstant.CommanUrlLogin + "wcfmmp/v1/cart/add-item";
    String USER_ID = (await Utility.getStringPreference(GlobalConstant.store_id));
    print(widget.data_val['id'].toString());

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'Authorization': 'Bearer $token'
    };
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);

      var response = await http.post(Url, headers: headers, body:
      {
        "id":widget.data_val['id'].toString(),
        "qty":"1",
        "wc_appointments_field_timezone":"Asia/Karachi",
        "wc_appointments_field_start_date_month":serevr_month,
        "wc_appointments_field_start_date_day":serevr_day,
        "wc_appointments_field_start_date_year":serevr_year,
        "wc_appointments_field_start_date_time":"14:00",
        "wc_appointments_field_addons_duration":"0",
        "wc_appointments_field_addons_cost":"0",
        "add-to-cart":widget.data_val['id'].toString(),
      });
      // check the status code for the result

      print(response.body);
      Dialogs.hideProgressDialog(context);
      if(response.body.toLowerCase()=="{}")
        {
          GlobalWidget.GetToast(context, "Something went wrong . Please change date and time .");
        }else
          {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (_) => new CommonDashBord("my_cart",true)));
          }

       // GlobalWidget.GetToast(context, response.body);
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      String body1 = response.body;
    }else
    {
      GlobalWidget.GetToast(context, "No Internet Connection");
    }

  }

  getData(int index) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Row(
          children: [
            Expanded(flex: 1,
              child: Icon(Icons.date_range,size: 30.0,color: Colors.grey,),),
            SizedBox(width: 10.0,),
            Expanded(flex: 3,
              child: Text(AppointMent_List[index].date),),
            Expanded(flex: 6,
              child: new Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.only(top:10.0,bottom: 10.0,left: 5.0,right: 5.0),
                  decoration: BoxDecoration(
                  border: Border.all(color: GlobalConstant.getTextColor())),
                  child: Text(AppLocalizations.of(context).translate('make_appoint'),style: TextStyle(color: GlobalConstant.getTextColor(),fontWeight: FontWeight.bold,fontSize: 16.0),textAlign: TextAlign.center,),
                  )
              /*
              new Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(AppLocalizations.of(context).translate('make_appoint'),style: TextStyle(color: GlobalConstant.getTextColor()),textAlign: TextAlign.right,),
              ),*/
              )
          ],
        ),
       // new Divider(thickness: 1.0,)
      ],
    );
  }


  List products=new List();
  List<Datamodel> AppointMent_List=new List();
  String TAG = "VenderAvailabiltyActivity";

  void GetSlots() async {
    AppointMent_List=new List();
    setState(()
    {
    });
    String Verder_Id = (await Utility.getStringPreference(GlobalConstant.Verder_Id));
    String Url = GlobalConstant.CommanUrlLogin + "wc-appointments/v1/slots/?product_ids=${widget.data_val['id']}&min_date=$min_date&max_date=$max_date";
    ApiController apiController = new ApiController.internal();
    if (await NetworkCheck.check())
    {
      Dialogs.showProgressDialog(context);
      apiController.GetWithToken(Url).then((value)
      {
        try
        {
          Dialogs.hideProgressDialog(context);
          var data1 = json.decode(value.body);
          var data = data1["records"];
          Utility.log(TAG, data);
          if (data.length != 0) {
               for(int i=0;i<data.length;i++)
               {
                 String date="${data[i]["date"].toString()}";
                 print(date.split("T"));
                 var array_val=date.split("T");
                 var dateTime = DateFormat.jm().format(DateFormat("hh:mm").parse("${array_val[1]}"));
                 print(dateTime);
                 AppointMent_List.add(new Datamodel("${dateTime}", "${array_val[1]}"));
               }
            setState(()
            {
              //Timer(Duration(seconds: 1), () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent),);
            });
          } else
          {
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

  void setServerDate(DateTime today)
  {
    serevr_day=new DateFormat.d().format(today).toUpperCase();
    serevr_month= new DateFormat.M().format(today).toUpperCase();
    serevr_year= new DateFormat.y().format(today).toUpperCase();
    Utility.log(TAG, serevr_year+"  "+serevr_day+"  "+serevr_month);
  }
}

class Datamodel
{
  String date;
  Datamodel(this.date, this.data);
  var data;
}
/*
import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

*/
/*
TODO: The following data are using for testing only, so that when you go live
      don't forget to replace the following test credentials with the live
      credentials provided by MyFatoorah Company.
*//*


// Base Url
final String baseUrl = "https://apitest.myfatoorah.com";

// Token for regular payment
final String regularPaymentToken = "bearer gqtDGpuJQkrzmxCcslg8RY8OnY0dSiHV65r5q-1kjt2lWDpvhtQRy712gF9AMdHwIiNUBwLWL8kMSvsIsrSxVJgrLTUXxBfiP4lCnMxe1KqOwKI5_C21UQjwJ-aHhVA93FDkWeuXoRFFfTDoUroeOXg9yoBWI9hjFndypdpjPI4_2PGLgwGzGRIy7bj_P_GzfpPODqRaZyn1bT-kjNoGF5fKkRopmdIlU2OeLV6lqDKF__smfyauGVTixIJKpmtxTa_p_YjRanbWBnWd13aBxTJSIVGBYszmK3pev1POgXDLO9K6b4pP8jT8Lodkl7f60osRDjLSiLKzt93ztrR0ERuu8sfpVa-eg-v3dBi870ZSPDNI7esQ7cQ9pe9OTj4JT8Hwef1zZuXCsBO7HzL2JQGYPyrx-iVQsv_0Bc7rhv1fHfLtsN3FrsQEq-aLzGtH-qRMq3S_M6T2-I-fQdgsbuHqDG6VKc2TXnId2SrAKX26kGSZfOH7rDYtb86Nu3iI-EMzztt8RnbpkBr9fKEtqOuJ0SNMhN716FgJKFei2mbOxMxVrZtTqu38fSh1m6WYWOy_48f6P2TYplMdo5S-G_J9PtkrUMs6eqzqhhjPWsppwtAJhb6rKhoBQkSHKpbKIWvzOOi826_ryUyNvMCmMlesgoWcWcQJEcob4RzB3OZjAgWQ";

// Token for direct payment and recurring
final String directPaymentToken = "fVysyHHk25iQP4clu6_wb9qjV3kEq_DTc1LBVvIwL9kXo9ncZhB8iuAMqUHsw-vRyxr3_jcq5-bFy8IN-C1YlEVCe5TR2iCju75AeO-aSm1ymhs3NQPSQuh6gweBUlm0nhiACCBZT09XIXi1rX30No0T4eHWPMLo8gDfCwhwkbLlqxBHtS26Yb-9sx2WxHH-2imFsVHKXO0axxCNjTbo4xAHNyScC9GyroSnoz9Jm9iueC16ecWPjs4XrEoVROfk335mS33PJh7ZteJv9OXYvHnsGDL58NXM8lT7fqyGpQ8KKnfDIGx-R_t9Q9285_A4yL0J9lWKj_7x3NAhXvBvmrOclWvKaiI0_scPtISDuZLjLGls7x9WWtnpyQPNJSoN7lmQuouqa2uCrZRlveChQYTJmOr0OP4JNd58dtS8ar_8rSqEPChQtukEZGO3urUfMVughCd9kcwx5CtUg2EpeP878SWIUdXPEYDL1eaRDw-xF5yPUz-G0IaLH5oVCTpfC0HKxW-nGhp3XudBf3Tc7FFq4gOeiHDDfS_I8q2vUEqHI1NviZY_ts7M97tN2rdt1yhxwMSQiXRmSQterwZWiICuQ64PQjj3z40uQF-VHZC38QG0BVtl-bkn0P3IjPTsTsl7WBaaOSilp4Qhe12T0SRnv8abXcRwW3_HyVnuxQly_OsZzZry4ElxuXCSfFP2b4D2-Q";

class MyAppPayemntPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyFatoorah Plugin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'MyFatoorah Plugin Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _response = '';
  String _loading = "Loading...";

  @override
  void initState() {
    super.initState();

    // TODO, don't forget to init the MyFatoorah Plugin with the following line
    MFSDK.init(baseUrl, regularPaymentToken);

    // (Optional) un comment the following lines if you want to set up properties of AppBar.

//    MFSDK.setUpAppBar(
//      title: "MyFatoorah Payment",
//      titleColor: Colors.white,  // Color(0xFFFFFFFF)
//      backgroundColor: Colors.black, // Color(0xFF000000)
//      isShowAppBar: true); // For Android platform only

    // (Optional) un comment this line, if you want to hide the AppBar.
    // Note, if the platform is iOS, this line will not affected

//    MFSDK.setUpAppBar(isShowAppBar: false);
  }

  */
/*
    Send Payment
   *//*

  void sendPayment() {
    var request = MFSendPaymentRequest(
        invoiceValue: 0.100,
        customerName: "Customer name",
        notificationOption: MFNotificationOption.LINK);

    MFSDK.sendPayment(
        MFAPILanguage.EN,
        request,
            (MFResult<MFSendPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  */
/*
    Initiate Payment
   *//*

  void initiatePayment() {
    var request = new MFInitiatePaymentRequest(5.5, MFCurrencyISO.KUWAIT_KWD);
    MFSDK.initiatePayment(
        request,
        MFAPILanguage.EN,
            (MFResult<MFInitiatePaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  */
/*
    Execute Regular Payment
   *//*

  void executeRegularPayment() {
    // The value "1" is the paymentMethodId of KNET payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    String paymentMethod = "1";

    var request = new MFExecutePaymentRequest(paymentMethod, "100");

    MFSDK.executePayment(
        context,
        request,
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(invoiceId);
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(invoiceId);
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  */
/*
    Execute Direct Payment
   *//*

  void executeDirectPayment() {
    // The value "2" is the paymentMethodId of Visa/Master payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    String paymentMethod = "2";

    var request = new MFExecutePaymentRequest(paymentMethod, "100");

//    var mfCardInfo = new MFCardInfo(cardToken: "Put your token here");

    var mfCardInfo = new MFCardInfo(
        cardNumber: "2223000000000007",
        expiryMonth: "05",
        expiryYear: "21",
        securityCode: "100",
       // cardHolderName: "Set Name",
        bypass3DS: true,
        saveToken: true);

    MFSDK.executeDirectPayment(
        context,
        request,
        mfCardInfo,
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(invoiceId);
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(invoiceId);
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  */
/*
    Execute Direct Payment with Recurring
   *//*

  void executeDirectPaymentWithRecurring() {
    // The value "2" is the paymentMethodId of Visa/Master payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    String paymentMethod = "2";

    var request = new MFExecutePaymentRequest(paymentMethod, "100");

    var mfCardInfo = new MFCardInfo(
        cardNumber: "2223000000000007",
        expiryMonth: "05",
        expiryYear: "21",
        securityCode: "100",
       // cardHolderName: "Set Name",
        bypass3DS: true,
        saveToken: true);

    int intervalDays = 5;

    MFSDK.executeDirectPaymentWithRecurring(
        context,
        request,
        mfCardInfo,
        intervalDays,
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(invoiceId);
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(invoiceId);
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  */
/*
    Payment Enquiry
   *//*

  void getPaymentStatus() {
    var request = MFPaymentStatusRequest(invoiceId: "12345");

    MFSDK.getPaymentStatus(
        MFAPILanguage.EN,
        request,
            (MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  */
/*
    Cancel Token
   *//*

  void cancelToken() {
    MFSDK.cancelToken(
        "Put your token here",
        MFAPILanguage.EN,
            (MFResult<bool> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toString());
                _response = result.response.toString();
              })
            }
          else
            {
              setState(() {
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  */
/*
    Cancel Recurring Payment
   *//*

  void cancelRecurringPayment() {
    MFSDK.cancelRecurringPayment(
        "Put RecurringId here",
        MFAPILanguage.EN,
            (MFResult<bool> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toString());
                _response = result.response.toString();
              })
            }
          else
            {
              setState(() {
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [
            IntrinsicWidth(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  RaisedButton(
                    child: Text('Send Payment'),
                    onPressed: sendPayment,
                  ),
                  RaisedButton(
                    child: Text('Initiate Payment'),
                    onPressed: initiatePayment,
                  ),
                  RaisedButton(
                    child: Text('Execute Regular Payment'),
                    onPressed: executeRegularPayment,
                  ),
                  RaisedButton(
                    child: Text('Execute Direct Payment'),
                    onPressed: executeDirectPayment,
                  ),
                  RaisedButton(
                    child: Text('Execute Direct Payment with Recurring'),
                    onPressed: executeDirectPaymentWithRecurring,
                  ),
                  RaisedButton(
                    child: Text('Cancel Recurring Payment'),
                    onPressed: cancelRecurringPayment,
                  ),
                  RaisedButton(
                    child: Text('Cancel Token'),
                    onPressed: cancelToken,
                  ),
                  RaisedButton(
                    child: Text('Get Payment Status'),
                    onPressed: getPaymentStatus,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Text(_response),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}*/

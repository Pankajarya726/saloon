/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:salon_app/Global/GlobalWidget.dart';
import 'package:http/http.dart' as http;

class PayemntActivity extends StatefulWidget {
  @override
  _PayemntActivityState createState() => _PayemntActivityState();
}

class _PayemntActivityState extends State<PayemntActivity>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;


  final String baseUrl = "https://apitest.myfatoorah.com";

// Token for regular payment
// String regularPaymentToken = "cxu2LdP0p0j5BGna0velN9DmzKJTrx3Ftc0ptV8FmvOgoDqvXivkxZ_oqbi_XM9k7jgl3SUriQyRE2uaLWdRumxDLKTn1iNglbQLrZyOkmkD6cjtpAsk1_ctrea_MeOQCMavsQEJ4EZHnP4HoRDOTVRGvYQueYZZvVjsaOLOubLkdovx6STu9imI1zf5OvuC9rB8p0PNIR90rQ0-ILLYbaDZBoQANGND10HdF7zM4qnYFF1wfZ_HgQipC5A7jdrzOoIoFBTCyMz4ZuPPPyXtb30IfNp47LucQKUfF1ySU7Wy_df0O73LVnyV8mpkzzonCJHSYPaum9HzbvY5pvCZxPYw39WGo8pOMPUgEugtaqepILwtGKbIJR3_T5Iimm_oyOoOJFOtTukb_-jGMTLMZWB3vpRI3C08itm7ealISVZb7M3OMPPXgcss9_gFvwYND0Q3zJRPmDASg5NxRlEDHWRnlwNKqcd6nW4JJddffaX8p-ezWB8qAlimoKTTBJCe5CnjT4vNjnWlJWscvk38VNIIslv4gYpC09OLWn4rDNeoUaGXi5kONdEQ0vQcRjENOPAavP7HXtW1-Vz83jMlU3lDOoZsdEKZReNYpvdFrGJ5c3aJB18eLiPX6mI4zxjHCZH25ixDCHzo-nmgs_VTrOL7Zz6K7w6fuu_eBK9P0BDr2fpS";
  String regularPaymentToken = "cxu2LdP0p0j5BGna0velN9DmzKJTrx3Ftc0ptV8FmvOgoDqvXivkxZ_oqbi_XM9k7jgl3SUriQyRE2uaLWdRumxDLKTn1iNglbQLrZyOkmkD6cjtpAsk1_ctrea_MeOQCMavsQEJ4EZHnP4HoRDOTVRGvYQueYZZvVjsaOLOubLkdovx6STu9imI1zf5OvuC9rB8p0PNIR90rQ0-ILLYbaDZBoQANGND10HdF7zM4qnYFF1wfZ_HgQipC5A7jdrzOoIoFBTCyMz4ZuPPPyXtb30IfNp47LucQKUfF1ySU7Wy_df0O73LVnyV8mpkzzonCJHSYPaum9HzbvY5pvCZxPYw39WGo8pOMPUgEugtaqepILwtGKbIJR3_T5Iimm_oyOoOJFOtTukb_-jGMTLMZWB3vpRI3C08itm7ealISVZb7M3OMPPXgcss9_gFvwYND0Q3zJRPmDASg5NxRlEDHWRnlwNKqcd6nW4JJddffaX8p-ezWB8qAlimoKTTBJCe5CnjT4vNjnWlJWscvk38VNIIslv4gYpC09OLWn4rDNeoUaGXi5kONdEQ0vQcRjENOPAavP7HXtW1-Vz83jMlU3lDOoZsdEKZReNYpvdFrGJ5c3aJB18eLiPX6mI4zxjHCZH25ixDCHzo-nmgs_VTrOL7Zz6K7w6fuu_eBK9P0BDr2fpS";
// Token for direct payment and recurring
  final String directPaymentToken = "fVysyHHk25iQP4clu6_wb9qjV3kEq_DTc1LBVvIwL9kXo9ncZhB8iuAMqUHsw-vRyxr3_jcq5-bFy8IN-C1YlEVCe5TR2iCju75AeO-aSm1ymhs3NQPSQuh6gweBUlm0nhiACCBZT09XIXi1rX30No0T4eHWPMLo8gDfCwhwkbLlqxBHtS26Yb-9sx2WxHH-2imFsVHKXO0axxCNjTbo4xAHNyScC9GyroSnoz9Jm9iueC16ecWPjs4XrEoVROfk335mS33PJh7ZteJv9OXYvHnsGDL58NXM8lT7fqyGpQ8KKnfDIGx-R_t9Q9285_A4yL0J9lWKj_7x3NAhXvBvmrOclWvKaiI0_scPtISDuZLjLGls7x9WWtnpyQPNJSoN7lmQuouqa2uCrZRlveChQYTJmOr0OP4JNd58dtS8ar_8rSqEPChQtukEZGO3urUfMVughCd9kcwx5CtUg2EpeP878SWIUdXPEYDL1eaRDw-xF5yPUz-G0IaLH5oVCTpfC0HKxW-nGhp3XudBf3Tc7FFq4gOeiHDDfS_I8q2vUEqHI1NviZY_ts7M97tN2rdt1yhxwMSQiXRmSQterwZWiICuQ64PQjj3z40uQF-VHZC38QG0BVtl-bkn0P3IjPTsTsl7WBaaOSilp4Qhe12T0SRnv8abXcRwW3_HyVnuxQly_OsZzZry4ElxuXCSfFP2b4D2-Q";

 // final String regularPaymentToken = "bearer gqtDGpuJQkrzmxCcslg8RY8OnY0dSiHV65r5q-1kjt2lWDpvhtQRy712gF9AMdHwIiNUBwLWL8kMSvsIsrSxVJgrLTUXxBfiP4lCnMxe1KqOwKI5_C21UQjwJ-aHhVA93FDkWeuXoRFFfTDoUroeOXg9yoBWI9hjFndypdpjPI4_2PGLgwGzGRIy7bj_P_GzfpPODqRaZyn1bT-kjNoGF5fKkRopmdIlU2OeLV6lqDKF__smfyauGVTixIJKpmtxTa_p_YjRanbWBnWd13aBxTJSIVGBYszmK3pev1POgXDLO9K6b4pP8jT8Lodkl7f60osRDjLSiLKzt93ztrR0ERuu8sfpVa-eg-v3dBi870ZSPDNI7esQ7cQ9pe9OTj4JT8Hwef1zZuXCsBO7HzL2JQGYPyrx-iVQsv_0Bc7rhv1fHfLtsN3FrsQEq-aLzGtH-qRMq3S_M6T2-I-fQdgsbuHqDG6VKc2TXnId2SrAKX26kGSZfOH7rDYtb86Nu3iI-EMzztt8RnbpkBr9fKEtqOuJ0SNMhN716FgJKFei2mbOxMxVrZtTqu38fSh1m6WYWOy_48f6P2TYplMdo5S-G_J9PtkrUMs6eqzqhhjPWsppwtAJhb6rKhoBQkSHKpbKIWvzOOi826_ryUyNvMCmMlesgoWcWcQJEcob4RzB3OZjAgWQ";

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    MFSDK.init(baseUrl, regularPaymentToken);
    MFSDK.setUpAppBar(
        title: "MyFatoorah Payment",
        titleColor: Colors.white,  // Color(0xFFFFFFFF)
        backgroundColor: Colors.black, // Color(0xFF000000)
        isShowAppBar: true);
   initiatePayment();
    executeRegularPayment();

  }



    Initiate Payment


  var _response;
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


    var request = new MFInitiatePaymentRequest(0.100, MFCurrencyISO.KUWAIT_KWD);

    MFSDK.initiatePayment(request, MFAPILanguage.EN,
            (MFResult<MFInitiatePaymentResponse> result) => {

  if(result.isSuccess()) {
            print(result.response.toJson().toString())
          }
          else
          {
            print(result.error.message)
          }

        });
    setState(() {
     // _response = _loading;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Center(
        ),

      ),
    );
  }

  void executeRegularPayment() {
    // The value "1" is the paymentMethodId of KNET payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    String paymentMethod = "1";

    var request = new MFExecutePaymentRequest(paymentMethod, "5");

    MFSDK.executePayment(
        context,
        request,
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              setState(()
              {
                print("Success");
                print(invoiceId);
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              //  GlobalWidget.showMyDialog(context, "Succes",invoiceId);
                Navigator.of(context).pop();
              })
            }
          else
            {
              setState(()
              {
                print("Failure");
                print(invoiceId);
                int errorcode=1;
                try
                {

                  print("mesage ${result.error.toJson()['statusCode']}");
                  print("error ${result.error.message}");
                  errorcode=result.error.toJson()['statusCode'];
                }catch(e)
                {
                }

                if(errorcode== -1)
                  {
                    GlobalWidget.showMyDialog(context,"Error", result.error.message);
                  }
                _response = result.error.message;
              })
            }
        });

    setState(() {
     // _response = _loading;
    });
  }

}
*/

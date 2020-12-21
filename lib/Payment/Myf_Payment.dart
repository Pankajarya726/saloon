import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:salon_app/Global/GlobalConstant.dart';
import 'package:salon_app/Global/Utility.dart';
import 'package:salon_app/language/AppLanguage.dart';
import 'package:salon_app/language/AppLocalizations.dart';

class MyfaPayment extends StatefulWidget
{
  String amount;

  MyfaPayment(this.amount);

  @override
  State<StatefulWidget> createState() {
    return Myview();
  }

}

class Myview extends State<MyfaPayment>
{
  AppLanguage appLanguage = AppLanguage();
  @override
  Widget build(BuildContext context) {
   // print(appLanguage.fetchLocale().toString());
    print(appLanguage.appLocale.toString());
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(title: Text(AppLocalizations.of(context).translate("payment")),),
      backgroundColor: Colors.white,
      body: Builder(
        builder: (BuildContext context) {
          return MyFatoorah(
            afterPaymentBehaviour: AfterPaymentBehaviour.None,
            request: MyfatoorahRequest(
              url: GlobalConstant.myFattorhUrl,
              token: GlobalConstant.MyFatoorhToken,
              currencyIso: Country.SaudiArabia,
              successUrl: "https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png",
              errorUrl: "https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png",
              invoiceAmount: double.parse(widget.amount),
              language: appLanguage.appLocale.toString()=="en"?ApiLanguage.English:ApiLanguage.Arabic,
            ),
            errorChild: Center(
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.error,
                  color: Colors.redAccent,
                  size: 50,
                ),
              ),
            ),
            succcessChild: Center(
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                },
                child: Icon(
                  Icons.done_all,
                  color: Colors.greenAccent,
                  size: 50,
                ),
              )
            ),

            onResult: (PaymentResponse res)
            {
              Navigator.of(context).pop();
              Utility.log("Errrofinal", res.toString());
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(res.status.toString()),));
            },
          );
        },
      ),
    );
  }
}
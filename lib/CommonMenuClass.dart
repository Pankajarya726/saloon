import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_app/Appointment/OrderDetailClass.dart';
import 'package:salon_app/Availabilty/AvailabiltyClass.dart';
import 'package:salon_app/BarberPackage/barber_home.dart';
import 'package:salon_app/CartPackage/GetCartItemClass.dart';
import 'package:salon_app/CategoryWiseProduct/ProductCategory.dart';
import 'package:salon_app/FaqsTerms/faqs_and_terms.dart';
import 'package:salon_app/Profile/edit_billing_detail.dart';
import 'package:salon_app/Profile/edit_personal_info_class.dart';
import 'package:salon_app/Profile/edit_other_detail.dart';
import 'package:salon_app/VendorList/ProductClass.dart';
import 'Appointment/AppointmentClass.dart';
import 'Appointment/AppointmentDetailClass.dart';
import 'Appointment/MybookedOrderClass.dart';
import 'Availabilty/AvailabiltySchduleClass.dart';
import 'BarberPackage/MyProductClass.dart';
import 'BarberPackage/create_product.dart';
import 'CategoryWiseProduct/CategoryWiseProduct.dart';
import 'DrawerPackage/SideDrawer.dart';
import 'Global/GlobalConstant.dart';
import 'Global/GlobalWidget.dart';
import 'Global/Utility.dart';
import 'NearByBarber/NearByClass.dart';
import 'Profile/view_profile.dart';
import 'VendorList/ProductDetailClass.dart';
import 'VendorList/VendorClass.dart';
import 'VendorList/VendorDetailClass.dart';
import 'language/AppLocalizations.dart';

class CommonDashBord extends StatefulWidget {

  String From;
  bool back_icon;
  var data;

  CommonDashBord(From, back_icon, [data]) {
    this.From = From;
    this.back_icon = back_icon;
    this.data = data;
  }

  @override
  State<StatefulWidget> createState() {
    return CommonView();
  }
}
class CommonView extends State<CommonDashBord> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        appBar: GlobalWidget.getAppBar("" + getText(), context, widget.back_icon),
        drawer: SideDrawer(roles),
        key: _scaffoldKey,
        body: getBody(),
        bottomNavigationBar: getBottomView(),
      ),
    );
  }

  getBottomView() {
    return new Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 10.0),
      child: new Row(
        children: [

          Expanded(
            flex: 8,
            child: Text(
              AppLocalizations.of(context).translate('Tapered'),
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),

          Expanded(
            flex: 2,
            child: InkWell(
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 30.0,
              ),
              onTap: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
        ],
      ),
    );
  }

  getBody() {
    switch (widget.From) {
      case "vendor_list":
        if (roles == "wcfm_vendor") {
          return MyProductActivity();
        } else if (roles != "") {
          return ProductCategory();
        }
        break;
      case "vendor_dtl":
        return VendoeDetailActivity();
        break;
      case "appoint_dtl":
        return AppointDetailActivity(widget.data);
        break;
      case "vendor_avail":
        return AvailabiltyActivity(widget.data);
        break;
      case "Product_dtl":
        return ProductDetailActivity(widget.data);
        break;
      case "Cat_Product":
        return CategoryWiseProductActivity(widget.data["id"].toString());
        break;
      case "Product_list":
        return ProductActivity(widget.data);
        break;
      case "booking_page":
        return SchduledClassActivity(widget.data);
        break;
      case "map_view":
        //return NearByActivity();
        return VendorActivity();
        break;
      case "my_acc":
        return ViewProfile();
        break;
      case "my_appoint":
        return AppointmentActivity();
        break;
      case "my_order":
        return OrderActivity();
        break;
      case "add_product":
        return CreateProduct(widget.data);
        break;
      case "edit_basic":
        return EditPersonalInfoClass();
        break;
      case "edit_bill":
        return EditBillingDetail();
        break;
      case "edit_oth":
        return EditOtherDetail();
        break;
      case "my_pref":
        return FaqsAndTerms();
        break;
      case "my_term":
        return FaqsAndTerms();
        break;
      case "my_feqs":
        return FaqsAndTerms();
        break;
      case "my_cart":
        return CartActivity();
        break;
      case "order_dtl":
        return OrderDetailActivity(widget.data);
        break;
    }
  }

  String getText()
  {
    switch (widget.From)
    {
      case "vendor_list":
        if (roles == "wcfm_vendor") {
          return AppLocalizations.of(context).translate('barber_account');
        } else if (roles != "") {
          return AppLocalizations.of(context).translate('Tapered');
        }
        break;
      case "vendor_dtl":
        return AppLocalizations.of(context).translate('Tapered');
        break;
      case "add_product":
        return AppLocalizations.of(context).translate('Tapered');
        break;
      case "appoint_dtl":
        return AppLocalizations.of(context).translate('Appoint_dtl');
        break;
        case "Cat_Product":
      return widget.data["name"].toString();
      break;
      case "vendor_avail":
        return AppLocalizations.of(context).translate('Tapered');
        break;
      case "Product_dtl":
        return AppLocalizations.of(context).translate('our_shop');
        break;
      case "Product_list":
        return AppLocalizations.of(context).translate('our_shop');
        break;
      case "my_acc":
        return AppLocalizations.of(context).translate('account_head');
        break;
      case "edit_basic":
        return AppLocalizations.of(context).translate('personal_info');
        break;
      case "edit_bill":
        return AppLocalizations.of(context).translate('account_head');
        break;
      case "edit_ship":
        return AppLocalizations.of(context).translate('account_head');
        break;
      case "my_pref":
        return AppLocalizations.of(context).translate('my_pref');
        break;
      case "my_appoint":
        return AppLocalizations.of(context).translate('my_app');
        break;
      case "my_term":
        return AppLocalizations.of(context).translate('terms');
        break;
      case "my_feqs":
        return AppLocalizations.of(context).translate('feqs');
        break;

      case "my_cart":
        return AppLocalizations.of(context).translate('my_cart');
        break;
      case "order_dtl":
        return AppLocalizations.of(context).translate('order_dtl');
        break;
      case "my_order":
        return AppLocalizations.of(context).translate('my_order');
        break;
      default:
        return "Saloon App";
        break;
    }
  }

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    getRole();
  }

  String roles = "";
  Future<String> getRole() async {
    roles = await Utility.getStringPreference(GlobalConstant.roles);
    setState(() {
      Utility.log("tagroles", roles);
    });
    return roles;
  }
}

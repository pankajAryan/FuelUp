//
//  FFurls.h
//  FabFurnish
//
//  Created by Avneesh.minocha on 18/05/15.
//  Copyright (c) 2015 Bluerock eServices Pvt Ltd. All rights reserved.
//

#ifndef FabFurnish_FFurls_h
#define FabFurnish_FFurls_h


#define Mobile_Api_Version_Key        @"XINDFURMOBAPIVERSION"
#define Mobile_Api_Version            @"v3" //ce25302eed61a8a9f2aef604d4b0c11f
#define Mobile_Platform_Key           @"XFABMOBAPIPLATFORM"
#define Mobile_Platform               @"ios"
#define Mobile_lat                    @"lat"
#define Mobile_long                   @"long"
#define Mobile_city                   @"city"
#define Mobile_UserLocation           @"userLocation"


// ************ LIVE APP CONFIGURATIONS ************************************************************ //

#define COOKIE_DOMAIN     @".fabfurnish.com"       //***** Live & Staging *****//

#define BASE_URL          @"http://www.fabfurnish.com/mobileapi/"

#define WV_BASE_URL       @"https://m.fabfurnish.com/"



// ************ STAGING APP CONFIGURATIONS ********************************************************* //

//#define COOKIE_DOMAIN     @".fabfurnish.com"       //***** Live & Staging *****//
//
//#define BASE_URL          @"http://alice-staging.fabfurnish.com/mobileapi/"
//
//#define WV_BASE_URL       @"https://m-staging.fabfurnish.com/"



// ************ DEVELOPMENT ENVIRONMENT CONFIGURATIONS ********************************************* //

// 1. ************|| Coockie Configuration ||************ //

//#define COOKIE_DOMAIN   @".fabteam.in"

// **********| Other Dev Environments |*********

//#define COOKIE_DOMAIN  @".fabfurnish.loc"



// 2. ************|| WebServices Configuration ||************ //

//#define BASE_URL        @"http://full.fabteam.in/mobileapi/"

// checkout , new-analytics , mapi , payment , fab_deeplink , full

// **********| Other Dev Environments |*********

//#define BASE_URL      @"http://qa3501.fabfurnish.loc/mobileapi/"



// 3. ************|| WEB-View Implementation ||************ //

//#define WV_BASE_URL     @"http://m-full.fabteam.in/"

// **********| Other Dev Environments |*********

//#define WV_BASE_URL     @"http://mobile-qa3501.fabfurnish.loc/"





// 2. *********************|| Prefix BASE_URL ||**************************************************** //

#define FIRST_DISCOUNT_COUPON             @"main/firstdiscountcoupon/" //1. Device token URL
#define APP_VERSION                       @"main/versions/"  //2.call on load
#define HOME_PAGE                         @"main/getteaserswebview/"  //3.call on load
#define CATEGORIES                        @"catalog/categories/"  //4.call on load

#define LOGIN                             @"customer/login/"
#define AUTO_LOGIN                        @"customer/checkautologin/"//TO-DO
#define CATEGORYBYID                      @"catalog/categoriesbyparentId?cid=%d"//TO-DO
#define REGISTER                          @"customer/register/" // this is new API
#define CONTACT_US                        @"main/contactus/"

#define MYORDER                           @"cart/cartdata/"
#define ADD_PRODUCT                       @"cart/add/"
#define REMOVE_PRODUCT                    @"cart/remove/"
#define CART_CHANGE_QTY                   @"cart/cartchange/"
#define CUSTOMER_DETAIL                   @"customer/getdetails/"
#define CUSTOMER_LOGOUT                   @"customer/logout/"
#define ADD_VOUCHER                       @"cart/addvoucher/?coupon="
#define REMOVE_VOUCHER                    @"cart/removevoucher/"

#define PRODUCT_AVAILABLE_AT_PINCODE      @"catalog/deliverydetails/"
#define ADD_GIFT_WRAP                     @"cart/giftwrap/"
#define REMOVE_GIFT_WRAP                  @"cart/giftwrapcancel/"
#define EMI_POP                           @"catalog/productemipopup"

#define URL_SUGGESTION                    @"search/suggest/?q=%@"
#define URL_SEARCH                        @"search/?q=%@"
#define TRACK_ORDER                       @"customer/trackorder/"
#define FORGOT_PASS                       @"customer/forgotpassword/"

#define REWRAD_CREDIT_POINTS              @"customer/getpointdetails/"
#define MY_ORDER                          @"customer/getmyorderlist/"
#define MY_ORDER_DETAIL                   @"customer/getorderdetail/?order_id=%@"

#define CHANGE_PASS                       @"customer/changepass/"
#define ADD_ADDRESS                       @"customer/address/"
#define GET_REGION                        @"customer/RegionList/"
#define GET_CITY_STATE_BY_PIN             @"customer/pincode/?find=%@"
#define ADD_CMS                           @"main/getcms/"   //not in use
#define ADD_CALATOG_NEW                   @"catalog/categories/"

#define CONTACTUS_API                     @"mapi_contactus"
#define WHYFABFURNISH_API                 @"mapi_whyfabfurnish"

#define APP_CMS                           @"main/getcms?key=" //not in use
#define APP_URL_TYPE                      @"main/getUrlType/" //TO-DO Switch/Deep Link
#define SOCIAL_LOGIN                      @"customer/sociallogin/"
#define CUSTOMER_NEWSLETTER               @"customer/newsletter/"

#define API_PRODUCT_DETAIL_BY_SKU         @"catalog/detail/?q="
#define API_RELATED_PRODUCTS_BY_SKU       @"catalog/relateddesignproducts/?"
#define API_ADDRESS_DISPLAY_LOG           @"main/ondisplaylog/?"

#define API_REVIEWS                       @"catalog/reviews/?sku="
#define API_SUBMIT_REVIEWS                @"catalog/sendrating"

#define API_MY_SCAN_LIST                  @"social/MyscanList"

#define URL_CITY_SUGGESTION               @"search/location/?q=%@"
#define API_SHOWROOMS                     @"social/showrooms/?sku="

#define API_LOCATION_BY_GPS               @"search/nearestlocation"

//  http://full.fabteam.in/mobileapi/catalog/colorfamily?sku=FU748FU94VZTINDFUR&page=1
//  http://full.fabteam.in/mobileapi/catalog/productfamily?sku=FU748FU94VZTINDFUR&page=1
//
#define API_COLOR_FAMILY_ALL              @"catalog/colorfamily?sku=%@&page=%i"
#define API_PRODUCT_FAMILY_ALL            @"catalog/productfamily?sku=%@&page=%i"


// ************** DESIGN & INSPIRATION MODULE ******************** //

#define API_APPOINTMENT_SERVICES          @"main/appointmentservices"
#define API_MAKE_APPOINTMENT              @"customer/makeappointment"
#define API_SEND_FAQ                      @"catalog/sendfaq"
#define API_FABIDEA_LIKE                  @"social/like/?sku="
#define API_BOOK_DESIGN                   @"main/BookServicesCategory"
#define API_BOOK_SERVICE                  @"customer/BookService/"




// 3. ************************|| Prefix WV_BASE_URL ||************************************************ //

#define CHECKOUT_APPEND = "?wt_af=in.android_app.FFApp.1.1.1&utm_source=FFApp&utm_medium=android_app"

#define INITIATE_ORDER_PAYMENT            @"mcheckout/index" // Initiate payment

/**
 *  Check Status of Payment process by redirection URL's
 */
#define SUCCESS                           @"/checkout/success" //TO-DO
#define CHECKOUT_SUCCESS                  @"/checkout/success/msuccess/?s=" // Done
#define ERROR                             @"/mCheckout/error"  //TO-DO
#define CHECKOUT_ERROR                    @"/checkout/error/merror/?s=" //TO-DO


// For Payment whitelist base urls
#define PAY_YOU                           @"https://test.payu.in" //TO-DO
#define String MASTERCARD                 @"https://migs.mastercard.com.au/" //TO-DO
#define CAP_ATTEMPTS_SECURE               @"https://cap.attempts.securecode.com/" //TO-DO

// -----------------------------------

//add WV_BASE_URL Before
#define REDIRECTION                       @"/checkout/redirection" //TO-DO
#define FINISH_PAYMENT                    @"/checkout/finish/payment" //TO-DO
#define WHITELIST_ERROR                   @"/checkout/error" //TO-DO
#define LOGOUT_WEBVIEW                    @"/mcheckout/index/mlogout" //TO-DO
#define LOGIN_REGISTER_SUCCESS_WEBVIEW    @"/mcheckout/common/customerreg" //TO-DO



// After getting out of payment process, use below urls by adding BASE_URL as prefix
#define SUCCESS_ORDER                     @"customer/lastsuccessorderdetail" //TO-DO
#define ERROR_ORDER                       @"customer/lastfailedorder" //TO-DO


// Blacklist URLs
#define MAINTENANCE                       @"/maintenance.php" //TO-DO
#define NOT_FOUND                         @"/index/error" //TO-DO
#define CART_INDEX                        @"/cart/index" //TO-DO

// ----------------------------------



#endif

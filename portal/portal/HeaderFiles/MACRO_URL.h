//
//  MACRO_URL.h
//  Tourism
//
//  Created by Store on 16/11/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#ifndef MACRO_URL_h
#define MACRO_URL_h



#ifdef DEBUG

#define URLBASIC @"https://zeji.tempus.cn/zeji-front"


//#define  URLBASIC  @"https://zeji.tempus.cn/zeji-front/test"
#else
#define  URLBASIC  @"https://zeji.tempus.cn/zeji-front"
#endif

#ifdef DEBUG
#define URLAddress  @"URLAddress"
#define productURLAddress  @"https://zeji.tempus.cn/zeji-front"

#define tesetURLAddress @"https://zeji.tempus.cn/zeji-front"
//#define tesetURLAddress  @"https://zeji.tempus.cn/zeji-front/test"
#endif



#define     URLBASIC_tpurseappappIdApply        @"/app/appIdApply"       //申请appId和appSerect z
#define     URLBASIC_apptokenApply        @"/app/tokenApply"       //申请token
#define     URLBASIC_userrefreshLogin       @"/user/refreshLogin"
#define     URLBASIC_appappUpdate       @"/app/appUpdate"
#define     URLBASIC_appgetGlobalParams       @"/app/getGlobalParams"
#define     URLBASIC_tpurseusermyInfo       @"/user/myInfo"
#define     URLBASIC_jcRegistered       @"/app/jcRegistered"
#define     URLBASIC_jcLogin       @"/app/jcLogin"
#define     URLBASIC_jcMyInfo       @"/user/jcMyInfo"
#define     URLBASIC_tpurseuserlogout       @"/user/logout"
#define     URLBASIC_jcModifyMyInfo         @"/app/jcModifyMyInfo"
#define     URLBASIC_appjcEmailValid         @"/app/jcEmailValid"


#define     REQUESTURLappUpdate         @"/app/appUpdate"        //App版本更新
#define     URLBASIC_userlogin       @"/tpurse/user/login"
#define     URLBASIC_useraddPayPassword       @"/user/addPayPassword"
#define     URLBASIC_tpursesystemgetGraphicVerifyCode       @"/tpurse/system/getGraphicVerifyCode"

#define     URLBASIC_tpurseusermyCardInfo       @"/tpurse/user/myCardInfo"
#define     URLBASIC_tpurseusermodifyNickname       @"/tpurse/user/modifyNickname"

#define     URLBASIC_userheadUpload       @"/tpurse/user/headUpload"

#define     URLBASIC_userqueryBank       @"/user/queryBank"
#define     URLBASIC_userbindBankCard       @"/user/bindBankCard"


#define     URLBASIC_tpursesystemcheckVerifyCode      @"/tpurse/system/checkVerifyCode"

/////
#define     URLBASIC_tpurseusersubmitFeedback       @"/tpurse/user/submitFeedback"
#define     URLBASIC_flightqueryGssFlightDynamic       @"/flight/queryGssFlightDynamic"
#define     URLBASIC_userwithdraw       @"/user/withdraw"
#define     URLBASIC_userrecharge       @"/user/recharge"
#define     URLBASIC_qrCodegenerateQRCode      @"/qrCode/generateQRCode"
#define     URLBASIC_qrCodescanQRCode      @"/qrCode/scanQRCode"
#define     URLBASIC_qrCodeunifiedPay      @"/qrCode/unifiedPay"
#define     URLBASIC_tpurseuserqueryPayMethod       @"/tpurse/user/queryPayMethod"
#define     URLBASIC_orderpayThirdOrder       @"/order/payThirdOrder"
#define     URLBASIC_systemsendVerifyCode       @"/system/sendVerifyCode"

#define     URLBASIC_usercheckVerifyCode       @"/user/checkVerifyCode"
#define     URLBASIC_usercheckVerifyCode       @"/user/checkVerifyCode"
#define     URLBASIC_usercheckPayPassword       @"/tpurse/user/checkPayPassword"
#define     URLBASIC_qrCodecancelUnifiedPay       @"/qrCode/cancelUnifiedPay"
#define     URLBASIC_regularFinmyRegularFin       @"/regularFin/myRegularFin"
#define     URLBASIC_regularFintpurseRecharge       @"/regularFin/tpurseRecharge"

#define     URLBASIC_regularFinrecharge       @"/regularFin/recharge"
#define     URLBASIC_regularFinwithdraw       @"/regularFin/withdraw"

#define     URLBASIC_userthirdUserLogin       @"/tpurse/user/thirdUserLogin"

#define     URLBASIC_usermyInfo       @"/user/myInfo"
#define     URLBASIC_portalusermyNews       @"/portal/user/myNews"



#define     URLBASIC_portalcommonInfoaddContactInfo       @"/portal/commonInfo/addContactInfo"
#define     URLBASIC_portalcommonInfodeleteContactInfo       @"/portal/commonInfo/deleteContactInfo"
#define     URLBASIC_portalcommonInfoeditContactInfo       @"/portal/commonInfo/editContactInfo"
#define     URLBASIC_portalcommonInfoqueryContactInfos       @"/portal/commonInfo/queryContactInfos"

#define     URLBASIC_portalcommonInfoaddAddressInfo       @"/portal/commonInfo/addAddressInfo"
#define     URLBASIC_portalcommonInfodeleteAddressInfo       @"/portal/commonInfo/deleteAddressInfo"
#define     URLBASIC_portalcommonInfoeditAddressInfo       @"/portal/commonInfo/editAddressInfo"
#define     URLBASIC_portalcommonInfoqueryAddressInfos       @"/portal/commonInfo/queryAddressInfos"

#define     URLBASIC_commonInfoaddPassengerInfo       @"/portal/commonInfo/addPassengerInfo"
#define     URLBASIC_commonInfodeletePassengerInfo       @"/portal/commonInfo/deletePassengerInfo"
#define     URLBASIC_commonInfoeditPassengerInfo       @"/portal/commonInfo/editPassengerInfo"
#define     URLBASIC_portalcommonInfoqueryPassengerInfos       @"/portal/commonInfo/queryPassengerInfos"


#define     URLBASIC_portalqueryOrderInfo       @"/portal/order/queryOrderInfo"



#define     URLBASIC_userthirdUserBind       @"/user/thirdUserBind"
#define     URLBASIC_appsubmitFeedback       @"/portal/app/submitFeedback"


#define     URLBASIC_userlogout       @"/user/logout"
#define     URLBASIC_portalqueryFinaProducts       @"/portal/queryFinaProducts"
#define     URLBASIC_usermodifyNickname       @"/user/modifyNickname"


#define     URLBASIC_portaladdFavorite       @"/portal/addFavorite"
#define     URLBASIC_portalqueryFavorites       @"/portal/queryFavorites"
#define     URLBASIC_portalcancelFavorite       @"/portal/cancelFavorite"

#endif /* MACRO_URL_h */

//
//  ToolModeldata.h
//  TourismT
//
//  Created by Store on 16/12/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>





typedef enum {
    RechargeandcashwithdrawalVcState_Recharge,
    RechargeandcashwithdrawalVcState_WithdrawCash
} RechargeandcashwithdrawalVcState;


#define HOME_TYPE_BANK  @"1"  //银行卡
#define HOME_TYPE_AIR  @"2" //机票

///JC
@interface AppSetPlist : NSObject
@property (nonatomic,strong) NSString *internation;
@end


///JC
@interface countryOne : NSObject
@property (nonatomic,strong) NSString *countryCode;
@property (nonatomic,strong) NSString *countryName;
@property (nonatomic,strong) NSString *areaCode;
@end


///JC
@interface transactionStatus : NSObject
@property (nonatomic,strong) NSString *appName;
@property (nonatomic,strong) NSString *errorCode;
@property (nonatomic,strong) NSString *memo;
@property (nonatomic,strong) NSString *replyCode;
@property (nonatomic,strong) NSString *replyText;
@end

///我的消息
@interface appIdAndSecret : NSObject
@property (nonatomic,strong) NSString *appId;
@property (nonatomic,strong) NSString *appSecret;
@end

@interface accessToken : NSObject
@property (nonatomic,strong) NSString *sessionSecret;
@property (nonatomic,strong) NSString *sessionKey;
@property (nonatomic,strong) NSDate *expireTime;
@property (nonatomic,strong) NSString *accessToken;
@end

@interface UserInfo : NSObject
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *surname;
@property (nonatomic,strong) NSString *enName;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *certType;
@property (nonatomic,strong) NSString *certNo;
@property (nonatomic,strong) NSURL *avatar;
@property (nonatomic,strong) NSString *authenTicket;
@property (nonatomic,strong) NSString *authenUserId;
@property (nonatomic,strong) NSString *zone;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *nationality;
@end

@interface AirInfo : NSObject
@property (nonatomic,strong) NSString *depActual;
@property (nonatomic,strong) NSString *depWeather;
@property (nonatomic,strong) NSString *arrEstimated;
@property (nonatomic,strong) NSString *arrActual;
@property (nonatomic,strong) NSString *depEstimated;

@property (nonatomic,strong) NSString *arrWeather;
@property (nonatomic,strong) NSString *flightStatus;
@property (nonatomic,strong) NSString *boardingGate;
@property (nonatomic,strong) NSString *carousel;
@property (nonatomic,strong) NSString *arrTerminal;

@property (nonatomic,strong) NSString *preFlightNo;
@property (nonatomic,strong) NSString *depTerminal;
@property (nonatomic,strong) NSString *flightzj;
@property (nonatomic,strong) NSString *rate;
@property (nonatomic,strong) NSString *flyTimePercent;
@end


@interface UserInfoDeatil : NSObject
@property (nonatomic,strong) NSString *finaUserName;
@property (nonatomic,strong) NSURL *headUrl;
@property (nonatomic,strong) NSURL *integralUrl;
@property (nonatomic,strong) NSNumber *totalAsset;
@property (nonatomic,strong) NSNumber *totalIncome;
@property (nonatomic,strong) NSString *errorMsg;
@property (nonatomic,strong) NSNumber *finaAsset;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *bankMobile;

@property (nonatomic,strong) NSNumber *acctBal;
@property (nonatomic,strong) NSNumber *unCashAcctBal;

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSNumber *cashAcctBal;
@property (nonatomic,strong) NSNumber *integral;

@property (nonatomic,strong) NSMutableArray *Arry_list;

@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *payPasswordFlag;
@property (nonatomic,strong) NSString *realFlag;

@property (nonatomic,strong) NSString *hasUnreadNews;
@end


@interface bankCard : NSObject
@property (nonatomic,strong) NSString *type;

@property (nonatomic,strong) NSNumber *bindId;
@property (nonatomic,strong) NSString *cardNo;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSURL *bankIcon;
@property (nonatomic,strong) NSURL *bigBankIcon;
@property (nonatomic,strong) NSString *bankCode;


@property (nonatomic,strong) NSString *arrTime;
@property (nonatomic,strong) NSString *ticketNo;
@property (nonatomic,strong) NSString *arrCityName;
@property (nonatomic,strong) NSString *duration;
@property (nonatomic,strong) NSString *arrCityCode;
@property (nonatomic,strong) NSString *flightNo;
@property (nonatomic,strong) NSString *depTime;
@property (nonatomic,strong) NSString *displayFlag;
@property (nonatomic,strong) NSString *airName;
@property (nonatomic,strong) NSString *depCityName;
@property (nonatomic,strong) NSString *depDate;
@property (nonatomic,strong) NSString *passengerName;
@property (nonatomic,strong) NSURL *airLogo;
@property (nonatomic,strong) NSString *depCityCode;
@end


@interface RechargeSuccess : NSObject
@property (nonatomic,strong) NSURL *bankIcon;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *cardNo;
@property (nonatomic,strong) NSNumber *money;
@end


@interface scanQRCodeOk : NSObject
@property (nonatomic,strong) NSURL *payeeLogo;
@property (nonatomic,strong) NSString *payeeName;
@property (nonatomic,strong) NSString *acctBal;
@property (nonatomic,strong) NSMutableArray *bankCardArray;
@end


@interface Conductfinancialtransactions : NSObject
@property (nonatomic,strong) NSNumber *totalAsset;//总资产
@property (nonatomic,strong) NSNumber *finaAsset;//理财资产
@property (nonatomic,strong) NSNumber *acctBal;//账户余额
@property (nonatomic,strong) NSNumber *freezeBal;// 冻结金额
@property (nonatomic,strong) NSNumber *totalIncome;//累计总收益

@property (nonatomic,strong) NSString *realFlag;//实名标志

@property (nonatomic,strong) NSNumber *bindId;//绑卡编号

@property (nonatomic,strong) NSString *cardNo;//卡号
@property (nonatomic,strong) NSString *bankName;//银行名称
@property (nonatomic,strong) NSURL *bankIcon;//银行icon
@property (nonatomic,strong) NSString *cfcaSignFlag;//数字签名申请标志

@property (nonatomic,strong) NSNumber *tpurseAcctBal;//T钱包账户余额
@property (nonatomic,strong) NSString *tpurseRealFlag;//T钱包实名标志
@property (nonatomic,strong) NSString *userName;//用户姓名
@property (nonatomic,strong) NSString *certNo;//身份证号
@end




@interface scanQRCodeDone : NSObject
@property (nonatomic,strong) NSString *bankIcon;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *payeeName;
@end



@interface scanQRCodeBankOne : NSObject
@property (nonatomic,strong) NSNumber *bindId;
@property (nonatomic,strong) NSNumber *bankNo;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSURL *bankIcon;
@end

@interface ThreeOk : NSObject
@property (nonatomic,strong) NSNumber *cashAcctBal;
@property (nonatomic,strong) NSNumber *integral;
@property (nonatomic,strong) NSNumber *unCashAcctBal;
@property (nonatomic,strong) NSNumber *acctBal;
@property (nonatomic,strong) NSMutableArray *bankCardsArray;
@end


@interface ThreeOkBankOne : NSObject
@property (nonatomic,strong) NSURL *bigBankIcon;
@property (nonatomic,strong) NSURL *bankIcon;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSNumber *bindId;
@property (nonatomic,strong) NSString *cardNo;
@end




@interface Successincashwithdrawal : RechargeSuccess
@property (nonatomic,strong) NSString *estimateArrDatetime;
@property (nonatomic,strong) NSNumber *fee;
@property (nonatomic,strong) NSNumber *applyDatetime;
@end



@interface graphicVerifyCodeUrlInfo : NSObject
@property (nonatomic,strong) NSURL *graphicVerifyCodeUrl;
@end


@interface GlobalParameter : NSObject
@property (nonatomic,strong) NSURL *jcPassengerUrl;
@property (nonatomic,strong) NSURL *jcFilghtUrl;
@property (nonatomic,strong) NSURL *jcMyTripUrl;
@property (nonatomic,strong) NSURL *jcContactUrl;
@property (nonatomic,strong) NSURL *jcAboutUrl;
@property (nonatomic,strong) NSURL *jcGccUrl;
@property (nonatomic,strong) NSURL *jcPrivacyPolicyUrl;


//JC常用旅客地址
//JC预定航班地址
//JC我的行程地址
//JC联系我们地址
//JC关于我们地址
@end

@interface UMdeviceToken : NSObject
@property (nonatomic,strong) NSString *deviceToken;
@end


@interface QRcode : NSObject
@property (nonatomic,strong) NSURL *codeUrl;
@property (nonatomic,strong) NSString *codeId;
@end

@interface bankList : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_list;
@end


@interface ximengOK : NSObject
@property (nonatomic,strong) NSURL *redirectUrl;
@end


@interface HomeData : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_merchList;
@end

@interface HomeDataOne : NSObject
@property (nonatomic,strong) NSString *finFlag;
@property (nonatomic,strong) NSURL *merchLink;
@property (nonatomic,strong) NSString *merchName;
@property (nonatomic,strong) NSURL *merchIcon;
@property (nonatomic,strong) NSString *merchId;
@property (nonatomic,assign) BOOL needLogin;
@end


@interface noticationData : NSObject
@property (nonatomic,strong) NSString *codeId;
@property (nonatomic,strong) NSURL *content;
@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *money;
@end


@interface leftData : NSObject
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSURL *url;
@end

@interface MyNewsData : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_newsList;
@property (nonatomic,strong) NSString *hasMore;
@end

@interface MyNewsData_One : NSObject
@property (nonatomic,strong) NSString *newsDate;
@property (nonatomic,strong) NSURL *newsImg;
@property (nonatomic,strong) NSString *newsTitle;
@property (nonatomic,strong) NSURL *newsLink;
@property (nonatomic,strong) NSNumber *newsId;
@property (nonatomic,strong) NSString *newsType;
@end

@interface MyCollecData : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_List;
@property (nonatomic,strong) NSString *hasMore;
@end

@interface MyCollecData_One : NSObject
@property (nonatomic,strong) NSURL *logo;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSNumber *favorId;
@property (nonatomic,strong) NSString *date;
@end


@interface FinanceVcData : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_insuranceProductList;
@property (nonatomic,strong) NSMutableArray *Arry_tourProductList;
@property (nonatomic,strong) NSMutableArray *Arry_tpurseProductList;
@property (nonatomic,strong) NSURL *fundProductLink;
@property (nonatomic,strong) NSURL *fundProductPicture;
@property (nonatomic,strong) NSURL *vcProductLink;
@property (nonatomic,strong) NSURL *vcProductPicture;
@end

@interface FinanceVcData_One : NSObject
@property (nonatomic,strong) NSString *productPrice;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *productDesc;
@property (nonatomic,strong) NSString *productName;
@property (nonatomic,assign) BOOL needLogin;
@property (nonatomic,strong) NSURL *productLink;
@property (nonatomic,strong) NSURL *productPicture;
@end


@interface passengerInfos : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_passengerInfos;
@property (nonatomic,strong) NSString *hasMore;
@end
@interface passengerInfos_one : NSObject
@property (nonatomic,strong) NSString *enName;
@property (nonatomic,strong) NSMutableArray *Arry_certInfos;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,assign) NSInteger passengerId;
@property (nonatomic,strong) NSString *selfFlag;
@property (nonatomic,strong) NSString *surname; 
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *certNo;
@property (nonatomic,strong) NSString *nationalityCode;
@property (nonatomic,strong) NSString *nationalityName;
@property (nonatomic,strong) NSString *certType;
@property (nonatomic,strong) NSString *expireDate;
@end

@interface certInfos_one : NSObject
@property (nonatomic,strong) NSString *certNo;
@property (nonatomic,strong) NSString *nationality;
@property (nonatomic,strong) NSString *certType;
@property (nonatomic,assign) NSInteger certId;
@property (nonatomic,strong) NSString *expireDate;
@end

@interface contactInfos : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_contactInfos;
@property (nonatomic,strong) NSString *hasMore;
@end
@interface contactInfos_one : NSObject
@property (nonatomic,strong) NSString *email;
@property (nonatomic,assign) NSInteger contactId;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *selfFlag;
@end

@interface addressInfos : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_addressInfos;
@property (nonatomic,strong) NSString *hasMore;
@end
@interface addressInfos_one : NSObject
@property (nonatomic,strong) NSString *receiverMobile;
@property (nonatomic,strong) NSString *area;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,assign) NSInteger addressId;
@property (nonatomic,strong) NSString *receiverName;
@property (nonatomic,strong) NSString *selfFlag;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *detailAddress;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *postCode;
@end

@interface CheckApp : NSObject
@property (nonatomic,strong) NSString *appName;
@property (nonatomic,strong) NSNumber *verCode;
@property (nonatomic,strong) NSString *verName;
@property (nonatomic,strong) NSString *packName;
@property (nonatomic,strong) NSString *downloadUrl;
@property (nonatomic,strong) NSString *updateInfoUrl;
@property (nonatomic,strong) NSString *updateType;
@end


@interface setUpAll : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_all;    //所有账号的手势密码
@property (nonatomic,strong) NSMutableArray *Arry_allPhone;    //所有账号的手机号
@end


@interface setUp : NSObject
@property (nonatomic,strong) NSString *phone;    //手机号码
@property (nonatomic,strong) NSString *FingerprintPassword;  //@"1" 开启  @“0” 关闭
@property (nonatomic,strong) NSString *GestureCipher;
@property (nonatomic,strong) NSString *GestureCipherStr;    //手势密码

@property (nonatomic,strong) NSString *staue;    //首页 显示 和 隐藏  ／／显示 @“1”
@end


@interface setUpdatePre : NSObject
@property (nonatomic,strong) NSDate *datePre;
@end


@interface payPre : NSObject
@property (nonatomic,strong) NSString *sysId;
@property (nonatomic,strong) NSString *sign;
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,strong) NSString *v;
@property (nonatomic,strong) NSString *orderId;
@end

@interface payData : NSObject
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *orderName;
@property (nonatomic,strong) NSString *supportTcoin;
@property (nonatomic,strong) NSNumber *orderPrice;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface setUpData : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *describe;



//绑定银行用到的
@property (nonatomic,assign) NSInteger  clearButtonMode;
@property (nonatomic,assign) NSInteger  keyboardType;
@property (nonatomic,assign) NSInteger  contentType;
@property (nonatomic,assign) NSUInteger  existedLength;
@end


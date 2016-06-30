//
//  ZWSLocationManager.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/28.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSUInteger, ZWSLocationManagerLocationServiceStatus) {
    ZWSLocationManagerLocationServiceStatusDefault,               //默认状态
    ZWSLocationManagerLocationServiceStatusOK,                    //定位功能正常
    ZWSLocationManagerLocationServiceStatusUnknownError,          //未知错误
    ZWSLocationManagerLocationServiceStatusUnAvailable,           //定位功能关掉了
    ZWSLocationManagerLocationServiceStatusNoAuthorization,       //定位功能打开，但是用户不允许使用定位
    ZWSLocationManagerLocationServiceStatusNoNetwork,             //没有网络
    ZWSLocationManagerLocationServiceStatusNotDetermined          //用户还没做出是否要允许应用使用定位功能的决定，第一次安装应用的时候会提示用户做出是否允许使用定位功能的决定
};

typedef NS_ENUM(NSUInteger, ZWSLocationManagerLocationResult) {
    ZWSLocationManagerLocationResultDefault,              //默认状态
    ZWSLocationManagerLocationResultLocating,             //定位中
    ZWSLocationManagerLocationResultSuccess,              //定位成功
    ZWSLocationManagerLocationResultFail,                 //定位失败
    ZWSLocationManagerLocationResultParamsError,          //调用API的参数错了
    ZWSLocationManagerLocationResultTimeout,              //超时
    ZWSLocationManagerLocationResultNoNetwork,            //没有网络
    ZWSLocationManagerLocationResultNoContent             //API没返回数据或返回数据是错的
};


@interface ZWSLocationManager : NSObject

@property (nonatomic, assign, readonly) ZWSLocationManagerLocationResult locationResult;
@property (nonatomic, assign,readonly) ZWSLocationManagerLocationServiceStatus locationStatus;
@property (nonatomic, copy, readonly) CLLocation *currentLocation;

+ (instancetype)sharedInstance;

- (void)startLocation;
- (void)stopLocation;
- (void)restartLocation;

@end

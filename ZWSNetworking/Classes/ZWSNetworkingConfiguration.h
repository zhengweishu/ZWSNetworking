//
//  ZWSNetworkingConfiguration.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/29.
//
//

#ifndef ZWSNetworkingConfiguration_h
#define ZWSNetworkingConfiguration_h

typedef NS_ENUM(NSInteger, ZWSAppType) {
    ZWSAppTypexxx
};

typedef NS_ENUM(NSUInteger, ZWSURLResponseStatus)
{
    ZWSURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的ZWSAPIBaseManager来决定。
    ZWSURLResponseStatusErrorTimeout,
    ZWSURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};

static NSString *ZWSKeychainServiceName = @"xxxxx";
static NSString *ZWSUDIDName = @"xxxx";
static NSString *ZWSPasteboardType = @"xxxx";

static BOOL kZWSShouldCache = YES;
static BOOL kZWSServiceIsOnline = NO;
static NSTimeInterval kZWSNetworkingTimeoutSeconds = 20.0f;
static NSTimeInterval kZWSCacheOutdateTimeSeconds = 300; // 5分钟的cache过期时间
static NSUInteger kZWSCacheCountLimit = 1000; // 最多1000条cache

// services
extern NSString * const kZWSServiceGDMapV3;

#endif /* ZWSNetworkingConfiguration_h */

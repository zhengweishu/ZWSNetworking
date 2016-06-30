//
//  ZWSLogger.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/27.
//
//

#import <Foundation/Foundation.h>
#import "ZWSService.h"
#import "ZWSLoggerConfiguration.h"
#import "ZWSURLResponse.h"

@interface ZWSLogger : NSObject

@property (nonatomic, strong, readonly) ZWSLoggerConfiguration *configParams;

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request
                        apiName:(NSString *)apiName
                        service:(ZWSService *)service
                  requestParams:(id)requestParams
                     httpMethod:(NSString *)httpMethod;

+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                   resposeString:(NSString *)responseString
                         request:(NSURLRequest *)request
                           error:(NSError *)error;

+ (void)logDebugInfoWithCachedResponse:(ZWSURLResponse *)response
                            methodName:(NSString *)methodName
                     serviceIdentifier:(ZWSService *)service;

+ (instancetype)sharedInstance;
- (void)logWithActionCode:(NSString *)actionCode params:(NSDictionary *)params;

@end

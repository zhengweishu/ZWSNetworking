//
//  ZWSAPIProxy.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/27.
//
//

#import <Foundation/Foundation.h>
#import "ZWSURLResponse.h"

typedef void(^ZWSCallback)(ZWSURLResponse *response);

@interface ZWSAPIProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callGETWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                    methodName:(NSString *)methodName
                       success:(ZWSCallback)success
                          fail:(ZWSCallback)fail;

- (NSInteger)callPOSTWithParams:(NSDictionary *)params
              serviceIdentifier:(NSString *)servieIdentifier
                     methodName:(NSString *)methodName
                        success:(ZWSCallback)success
                           fail:(ZWSCallback)fail;

- (NSInteger)callPUTWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                    methodName:(NSString *)methodName
                       success:(ZWSCallback)success
                          fail:(ZWSCallback)fail;

- (NSInteger)callDELETEWithParams:(NSDictionary *)params
                serviceIdentifier:(NSString *)servieIdentifier
                       methodName:(NSString *)methodName
                          success:(ZWSCallback)success
                             fail:(ZWSCallback)fail;


- (NSNumber *)callApiWithRequest:(NSURLRequest *)request
                         success:(ZWSCallback)success
                            fail:(ZWSCallback)fail;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;


@end

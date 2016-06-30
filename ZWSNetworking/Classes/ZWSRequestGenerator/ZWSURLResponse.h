//
//  ZWSURLResponse.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/5/13.
//
//

#import <Foundation/Foundation.h>
#import "ZWSNetworkingConfiguration.h"

@interface ZWSURLResponse : NSObject

@property (nonatomic, assign, readonly) ZWSURLResponseStatus status;
@property (nonatomic, assign, readonly) NSInteger            requestId;
@property (nonatomic, copy, readonly  ) NSString             *contentString;
@property (nonatomic, copy, readonly  ) id                   content;
@property (nonatomic, copy, readonly  ) NSURLRequest         *request;
@property (nonatomic, copy, readonly  ) NSData               *responseData;
@property (nonatomic, copy            ) NSDictionary         *requestParams;

@property (nonatomic, assign, readonly) BOOL isCache;

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(ZWSURLResponseStatus)status;

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error;

// 使用initWithData的response，它的isCache是YES，上面两个函数生成的response的isCache是NO
- (instancetype)initWithData:(NSData *)data;


@end

//
//  ZWSURLResponse.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/5/13.
//
//

#import "ZWSURLResponse.h"
#import "NSURLRequest+ZWSNetworking.h"
#import "NSObject+ZWSNetworking.h"

@interface ZWSURLResponse ()

@property (nonatomic, assign, readwrite) ZWSURLResponseStatus status;
@property (nonatomic, assign, readwrite) NSInteger            requestId;
@property (nonatomic, assign, readwrite) BOOL                 isCache;
@property (nonatomic, copy, readwrite  ) NSString             *contentString;
@property (nonatomic, copy, readwrite  ) id                   content;
@property (nonatomic, copy, readwrite  ) NSURLRequest         *request;
@property (nonatomic, copy, readwrite  ) NSData               *responseData;

@end

@implementation ZWSURLResponse

#pragma mark - life cycle
- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(ZWSURLResponseStatus)status
{
    self = [super init];
    if (self) {
        self.contentString = responseString;
        self.content = [NSJSONSerialization JSONObjectWithData:responseData
                                                       options:NSJSONReadingMutableContainers
                                                         error:NULL];
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
    }
    return self;
}


- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.contentString = [responseString zws_defaultValue:@""];
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData
                                                           options:NSJSONReadingMutableContainers
                                                             error:NULL];
        } else {
            self.content = nil;
        }
    }
    return self;
}


- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingMutableContainers
                                                         error:NULL];
        self.isCache = YES;
    }
    return self;
}


#pragma mark - private methods
- (ZWSURLResponseStatus)responseStatusWithError:(NSError *)error
{
    if (error) {
        ZWSURLResponseStatus result = ZWSURLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = ZWSURLResponseStatusErrorNoNetwork;
        }
        return result;
    } else {
        return ZWSURLResponseStatusSuccess;
    }
}


@end

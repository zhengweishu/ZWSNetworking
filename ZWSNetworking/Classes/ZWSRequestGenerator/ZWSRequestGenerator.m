//
//  ZWSRequestGenerator.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/5/16.
//
//

#import "ZWSRequestGenerator.h"

#import <AFNetworking/AFNetworking.h>

#import "NSURLRequest+ZWSNetworking.h"
#import "NSDictionary+ZWSNetworking.h"
#import "NSObject+ZWSNetworking.h"
#import "NSURLRequest+ZWSNetworking.h"

#import "ZWSSignatureGenerator.h"
#import "ZWSCommonParamsGenerator.h"
#import "ZWSLogger.h"
#import "ZWSService.h"
#import "ZWSServiceFactory.h"

@interface ZWSRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation ZWSRequestGenerator

#pragma mark - public methods

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ZWSRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ZWSRequestGenerator alloc] init];
    });
    return sharedInstance;
}

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName
{
    ZWSService *service = [[ZWSServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString;
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxxx"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:requestParams error:NULL];
    request.requestParams = requestParams;
    if ([ZWSAppContext sharedInstance].accessToken) {
        [request setValue:[ZWSAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
    }
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                             requestParams:(NSDictionary *)requestParams
                                                methodName:(NSString *)methodName
{
    ZWSService *service = [[ZWSServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxxx"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    if ([ZWSAppContext sharedInstance].accessToken) {
        [request setValue:[ZWSAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
    }
    request.requestParams = requestParams;
    return request;
}

- (NSURLRequest *)generatePutRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName
{
    ZWSService *service = [[ZWSServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxxx"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"PUT" URLString:urlString parameters:requestParams error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    if ([ZWSAppContext sharedInstance].accessToken) {
        [request setValue:[ZWSAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
    }
    request.requestParams = requestParams;
    return request;
}

- (NSURLRequest *)generateDeleteRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                               requestParams:(NSDictionary *)requestParams
                                                  methodName:(NSString *)methodName
{
    ZWSService *service = [[ZWSServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxxx"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:urlString parameters:requestParams error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    if ([ZWSAppContext sharedInstance].accessToken) {
        [request setValue:[ZWSAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
    }
    request.requestParams = requestParams;
    return request;
}

#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kZWSNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}


@end







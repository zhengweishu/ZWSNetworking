//
//  ZWSAPIProxy.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/27.
//
//

#import "ZWSAPIProxy.h"
#import <AFNetworking/AFNetworking.h>
#import "ZWSRequestGenerator.h"
#import "ZWSServiceFactory.h"
#import "ZWSLogger.h"
#import "NSURLRequest+ZWSNetworking.h"

static NSString * const kZWSAPIProxyDispatchItemKeyCallbackSuccess = @"kZWSAPIProxyDispatchItemCallbackSuccess";
static NSString * const kZWSApiProxyDispatchItemKeyCallbackFail = @"kZWSAPIProxyDispatchItemCallbackFail";

@interface ZWSAPIProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;
//AFNetworking stuff
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end


@implementation ZWSAPIProxy

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ZWSAPIProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ZWSAPIProxy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - getters and setters
- (NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
    }
    return _sessionManager;
}

#pragma mark - public methods

- (NSInteger)callGETWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                    methodName:(NSString *)methodName
                       success:(ZWSCallback)success
                          fail:(ZWSCallback)fail
{
    NSURLRequest *request = [[ZWSRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callPOSTWithParams:(NSDictionary *)params
              serviceIdentifier:(NSString *)servieIdentifier
                     methodName:(NSString *)methodName
                        success:(ZWSCallback)success
                           fail:(ZWSCallback)fail
{
    NSURLRequest *request = [[ZWSRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callPUTWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                    methodName:(NSString *)methodName
                       success:(ZWSCallback)success
                          fail:(ZWSCallback)fail
{
    NSURLRequest *request = [[ZWSRequestGenerator sharedInstance] generatePutRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callDELETEWithParams:(NSDictionary *)params
                serviceIdentifier:(NSString *)servieIdentifier
                       methodName:(NSString *)methodName
                          success:(ZWSCallback)success
                             fail:(ZWSCallback)fail
{
    NSURLRequest *request = [[ZWSRequestGenerator sharedInstance] generateDeleteRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

#pragma mark - 

- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

/** 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。 */
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request
                         success:(ZWSCallback)success
                            fail:(ZWSCallback)fail
{
    
    NSLog(@"\n\n==============================================================\n=                        Request Start                       =\n==============================================================\n\n%@\n\n", request.URL);
    
    // 跑到这里的block的时候，就已经是主线程了。
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSData *responseData = responseObject;
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        if (error) {
            [ZWSLogger logDebugInfoWithResponse:httpResponse
                                 resposeString:responseString
                                       request:request
                                         error:error];
            ZWSURLResponse *response = [[ZWSURLResponse alloc] initWithResponseString:responseString
                                                                            requestId:requestID
                                                                              request:request
                                                                         responseData:responseData
                                                                                error:error];
            fail?fail(response):nil;
        } else {
            // 检查http response是否成立。
            [ZWSLogger logDebugInfoWithResponse:httpResponse
                                 resposeString:responseString
                                       request:request
                                         error:NULL];
            
            ZWSURLResponse *response = [[ZWSURLResponse alloc] initWithResponseString:responseString
                                                                            requestId:requestID
                                                                              request:request
                                                                         responseData:responseData
                                                                               status:ZWSURLResponseStatusSuccess];
            success?success(response):nil;
        }
    }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    
    return requestId;
}


@end

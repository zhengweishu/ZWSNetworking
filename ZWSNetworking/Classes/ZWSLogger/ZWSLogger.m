//
//  ZWSLogger.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/27.
//
//

#import "ZWSLogger.h"
#import "NSObject+ZWSNetworking.h"
#import "NSMutableString+ZWSNetworking.h"
#import "ZWSCommonParamsGenerator.h"
#import "ZWSAppContext.h"
#import "NSArray+ZWSNetworking.h"
#import "ZWSAPIProxy.h"
#import "ZWSServiceFactory.h"

@interface ZWSLogger ()

@property (nonatomic, strong, readwrite) ZWSLoggerConfiguration *configParams;

@end

@implementation ZWSLogger

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request
                        apiName:(NSString *)apiName
                        service:(ZWSService *)service
                  requestParams:(id)requestParams
                     httpMethod:(NSString *)httpMethod
{
#ifdef DEBUG
    BOOL isOnline = NO;
    if ([service respondsToSelector:@selector(isOnline)]) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[service methodSignatureForSelector:@selector(isOnline)]];
        invocation.target = service;
        invocation.selector = @selector(isOnline);
        [invocation invoke];
        [invocation getReturnValue:&isOnline];
    }
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                       Request Start                        *\n**************************************************************\n\n"];
    
    [logString appendFormat:@"API Name:\t\t%@\n", [apiName zws_defaultValue:@"N/A"]];
    [logString appendFormat:@"Method:\t\t\t%@\n", [httpMethod zws_defaultValue:@"N/A"]];
    [logString appendFormat:@"Version:\t\t%@\n", [service.apiVersion zws_defaultValue:@"N/A"]];
    [logString appendFormat:@"Service:\t\t%@\n", [service class]];
    [logString appendFormat:@"Status:\t\t\t%@\n", isOnline ? @"online" : @"offline"];
    [logString appendFormat:@"Public Key:\t\t%@\n", [service.publicKey zws_defaultValue:@"N/A"]];
    [logString appendFormat:@"Private Key:\t%@\n", [service.privateKey zws_defaultValue:@"N/A"]];
    [logString appendFormat:@"Params:\n%@", requestParams];
    
    [logString appendURLRequest:request];
    
    [logString appendFormat:@"\n\n**************************************************************\n*                         Request End                        *\n**************************************************************\n\n\n\n"];
    NSLog(@"%@", logString);
#endif
}

+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                   resposeString:(NSString *)responseString
                         request:(NSURLRequest *)request
                           error:(NSError *)error
{
#ifdef DEBUG
    BOOL shouldLogError = error ? YES : NO;
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                        API Response                        =\n==============================================================\n\n"];
    
    [logString appendFormat:@"Status:\t%ld\t(%@)\n\n", (long)response.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]];
    [logString appendFormat:@"Content:\n\t%@\n\n", responseString];
    if (shouldLogError) {
        [logString appendFormat:@"Error Domain:\t\t\t\t\t\t\t%@\n", error.domain];
        [logString appendFormat:@"Error Domain Code:\t\t\t\t\t\t%ld\n", (long)error.code];
        [logString appendFormat:@"Error Localized Description:\t\t\t%@\n", error.localizedDescription];
        [logString appendFormat:@"Error Localized Failure Reason:\t\t\t%@\n", error.localizedFailureReason];
        [logString appendFormat:@"Error Localized Recovery Suggestion:\t%@\n\n", error.localizedRecoverySuggestion];
    }
    
    [logString appendString:@"\n---------------  Related Request Content  --------------\n"];
    
    [logString appendURLRequest:request];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];
    
    NSLog(@"%@", logString);
#endif
}

+ (void)logDebugInfoWithCachedResponse:(ZWSURLResponse *)response
                            methodName:(NSString *)methodName
                     serviceIdentifier:(ZWSService *)service
{
#ifdef DEBUG
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                      Cached Response                       =\n==============================================================\n\n"];
    
    [logString appendFormat:@"API Name:\t\t%@\n", [methodName zws_defaultValue:@"N/A"]];
    [logString appendFormat:@"Version:\t\t%@\n", [service.apiVersion zws_defaultValue:@"N/A"]];
    [logString appendFormat:@"Service:\t\t%@\n", [service class]];
    [logString appendFormat:@"Public Key:\t%@\n", [service.publicKey zws_defaultValue:@"N/A"]];
    [logString appendFormat:@"Private Key:\t%@\n", [service.privateKey zws_defaultValue:@"N/A"]];
    [logString appendFormat:@"Method Name:\t%@\n", methodName];
    [logString appendFormat:@"Params:\n%@\n\n", response.requestParams];
    [logString appendFormat:@"Content:\n\t%@\n\n", response.contentString];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];
    NSLog(@"%@", logString);
#endif
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ZWSLogger *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.configParams = [[ZWSLoggerConfiguration alloc] init];
    }
    return self;
}

- (void)logWithActionCode:(NSString *)actionCode params:(NSDictionary *)params
{
    NSMutableDictionary *actionDict = [[NSMutableDictionary alloc] init];
    actionDict[@"act"] = actionCode;
    [actionDict addEntriesFromDictionary:params];
    [actionDict addEntriesFromDictionary:[ZWSCommonParamsGenerator commonParamsDictionaryForLog]];
    NSDictionary *logJsonDict = @{self.configParams.sendActionKey:[@[actionDict] zws_jsonString]};
    [[ZWSAPIProxy sharedInstance] callPOSTWithParams:logJsonDict serviceIdentifier:self.configParams.serviceType methodName:self.configParams.sendActionMethod success:nil fail:nil];
}

@end

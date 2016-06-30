//
//  ZWSRequestGenerator.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/5/16.
//
//

#import <Foundation/Foundation.h>

@interface ZWSRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName;

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                             requestParams:(NSDictionary *)requestParams
                                                methodName:(NSString *)methodName;

- (NSURLRequest *)generatePutRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName;

- (NSURLRequest *)generateDeleteRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                               requestParams:(NSDictionary *)requestParams
                                                  methodName:(NSString *)methodName;

@end

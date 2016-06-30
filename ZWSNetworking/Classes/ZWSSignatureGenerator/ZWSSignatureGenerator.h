//
//  ZWSSignatureGenerator.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/28.
//
//

#import <Foundation/Foundation.h>

@interface ZWSSignatureGenerator : NSObject

+ (NSString *)signGetWithSigParams:(NSDictionary *)allParams
                        methodName:(NSString *)methodName
                        apiVersion:(NSString *)apiVersion
                        privateKey:(NSString *)privateKey
                         publicKey:(NSString *)publicKey;

+ (NSString *)signRestfulGetWithAllParams:(NSDictionary *)allParams
                               methodName:(NSString *)methodName
                               apiVersion:(NSString *)apiVersion
                               privateKey:(NSString *)privateKey;

+ (NSString *)signPostWithApiParams:(NSDictionary *)apiParams
                         privateKey:(NSString *)privateKey
                          publicKey:(NSString *)publicKey;

+ (NSString *)signRestfulPOSTWithApiParams:(id)apiParams
                              commonParams:(NSDictionary *)commonParams
                                methodName:(NSString *)methodName
                                apiVersion:(NSString *)apiVersion
                                privateKey:(NSString *)privateKey;

@end

//
//  ZWSSignatureGenerator.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/28.
//
//

#import "ZWSSignatureGenerator.h"
#import "ZWSCommonParamsGenerator.h"
#import "NSDictionary+ZWSNetworking.h"
#import "NSString+ZWSNetworking.h"
#import "NSArray+ZWSNetworking.h"

@implementation ZWSSignatureGenerator

#pragma mark - public methods

+ (NSString *)signGetWithSigParams:(NSDictionary *)allParams
                        methodName:(NSString *)methodName
                        apiVersion:(NSString *)apiVersion
                        privateKey:(NSString *)privateKey
                         publicKey:(NSString *)publicKey
{
    NSString *sigString = [allParams zws_urlParamsStringSignature:YES];
    return [[NSString stringWithFormat:@"%@%@", sigString, privateKey] zws_md5];
}

+ (NSString *)signRestfulGetWithAllParams:(NSDictionary *)allParams
                               methodName:(NSString *)methodName
                               apiVersion:(NSString *)apiVersion
                               privateKey:(NSString *)privateKey
{
    NSString *part1 = [NSString stringWithFormat:@"%@/%@", apiVersion, methodName];
    NSString *part2 = [allParams zws_urlParamsStringSignature:YES];
    NSString *part3 = privateKey;
    
    NSString *beforeSign = [NSString stringWithFormat:@"%@%@%@", part1, part2, part3];
    return [beforeSign zws_md5];
}

+ (NSString *)signPostWithApiParams:(NSDictionary *)apiParams
                         privateKey:(NSString *)privateKey
                          publicKey:(NSString *)publicKey
{
    NSMutableDictionary *sigParams = [NSMutableDictionary dictionaryWithDictionary:apiParams];
    sigParams[@"api_key"] = publicKey;
    NSString *sigString = [sigParams zws_urlParamsStringSignature:YES];
    return [[NSString stringWithFormat:@"%@%@", sigString, privateKey] zws_md5];
}

+ (NSString *)signRestfulPOSTWithApiParams:(id)apiParams
                              commonParams:(NSDictionary *)commonParams
                                methodName:(NSString *)methodName
                                apiVersion:(NSString *)apiVersion
                                privateKey:(NSString *)privateKey
{
    NSString *part1 = [NSString stringWithFormat:@"%@/%@", apiVersion, methodName];
    NSString *part2 = [commonParams zws_urlParamsStringSignature:YES];
    NSString *part3 = nil;
    if ([apiParams isKindOfClass:[NSDictionary class]]) {
        part3 = [(NSDictionary *)apiParams zws_jsonString];
    } else if ([apiParams isKindOfClass:[NSArray class]]) {
        part3 = [(NSArray *)apiParams zws_jsonString];
    } else {
        return @"";
    }
    
    NSString *part4 = privateKey;
    
    NSString *beforeSign = [NSString stringWithFormat:@"%@%@%@%@", part1, part2, part3, part4];
    
    return [beforeSign zws_md5];
}

@end

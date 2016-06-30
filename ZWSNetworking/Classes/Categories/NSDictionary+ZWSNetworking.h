//
//  NSDictionary+ZWSNetwroking.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/5/13.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ZWSNetworking)

- (NSString *)zws_urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)zws_jsonString;
- (NSArray *)zws_transformedUrlParamsArraySignature:(BOOL)isForSignature;

@end

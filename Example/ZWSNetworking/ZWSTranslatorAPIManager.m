//
//  ZWSTranslatorAPIManager.m
//  ZWSNetworking
//
//  Created by LOFT.LIFE.ZHENG on 16/6/30.
//  Copyright © 2016年 zhengweishu. All rights reserved.
//

#import "ZWSTranslatorAPIManager.h"

NSString * const kTranslatorAPIManagerParamsKeyLatitude = @"kTranslatorAPIManagerParamsKeyLatitude";
NSString * const kTranslatorAPIManagerParamsKeyLongitude = @"kTranslatorAPIManagerParamsKeyLongitude";

@interface ZWSTranslatorAPIManager () <ZWSAPIManagerValidator>

@end

@implementation ZWSTranslatorAPIManager

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark - ZWSAPIManager

- (NSString *)methodName
{
    return @"geocode/regeo";
}

- (NSString *)serviceType
{
    return kZWSServiceGDMapV3;
}

- (ZWSAPIManagerRequestType)requestType
{
    return ZWSAPIManagerRequestTypeGet;
}

- (BOOL)shouldCache
{
    return YES;
}

- (NSDictionary *)reformParams:(NSDictionary *)params
{
    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
    resultParams[@"key"] = [[ZWSServiceFactory sharedInstance] serviceWithIdentifier:kZWSServiceGDMapV3].publicKey;
    resultParams[@"location"] = [NSString stringWithFormat:@"%@,%@", params[kTranslatorAPIManagerParamsKeyLongitude], params[kTranslatorAPIManagerParamsKeyLatitude]];
    resultParams[@"output"] = @"json";
    return resultParams;
}

#pragma mark - ZWSAPIManagerValidator

- (BOOL)manager:(ZWSAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return YES;
}

- (BOOL)manager:(ZWSAPIBaseManager *)manager isCorrectWithCallbackData:(NSDictionary *)data
{
    if ([data[@"status"] isEqualToString:@"0"]) {
        return NO;
    }
    
    return YES;
}

@end

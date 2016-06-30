//
//  GDMapService.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/28.
//
//

#import "GDMapService.h"
#import "ZWSAppContext.h"

@implementation GDMapService

#pragma mark - CTServiceProtocal
- (BOOL)isOnline
{
    return [ZWSAppContext sharedInstance].isOnline;
}

- (NSString *)offlineApiBaseUrl
{
    return @"http://restapi.amap.com";
}

- (NSString *)onlineApiBaseUrl
{
    return @"http://restapi.amap.com";
}

- (NSString *)offlineApiVersion
{
    return @"v3";
}

- (NSString *)onlineApiVersion
{
    return @"v3";
}

- (NSString *)onlinePublicKey
{
    return @"384ecc4559ffc3b9ed1f81076c5f8424";
}

- (NSString *)offlinePublicKey
{
    return @"384ecc4559ffc3b9ed1f81076c5f8424";
}

- (NSString *)onlinePrivateKey
{
    return @"";
}

- (NSString *)offlinePrivateKey
{
    return @"";
}

@end

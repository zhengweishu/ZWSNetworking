//
//  UIDevice+IdentifierAddition.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/28.
//
//

#import <UIKit/UIKit.h>

@interface UIDevice (IdentifierAddition)

- (NSString *)zws_uuid;
- (NSString *)zws_udid;
- (NSString *)zws_macaddress;
- (NSString *)zws_macaddressMD5;
- (NSString *)zws_machineType;
- (NSString *)zws_ostype;//显示“ios6，ios5”，只显示大版本号
- (NSString *)zws_createUUID;

@end

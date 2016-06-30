//
//  ZWSService.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/28.
//
//

#import "ZWSService.h"
#import "NSObject+ZWSNetworking.h"

@implementation ZWSService

- (instancetype)init {
    
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(ZWSServiceProtocal)]) {
            self.child = (id<ZWSServiceProtocal>)self;
        }
    }
    return self;
}

#pragma mark - getters and setters
- (NSString *)privateKey
{
    return self.child.isOnline ? self.child.onlinePrivateKey : self.child.offlinePrivateKey;
}

- (NSString *)publicKey
{
    return self.child.isOnline ? self.child.onlinePublicKey : self.child.offlinePublicKey;
}

- (NSString *)apiBaseUrl
{
    return self.child.isOnline ? self.child.onlineApiBaseUrl : self.child.offlineApiBaseUrl;
}

- (NSString *)apiVersion
{
    return self.child.isOnline ? self.child.onlineApiVersion : self.child.offlineApiVersion;
}

@end

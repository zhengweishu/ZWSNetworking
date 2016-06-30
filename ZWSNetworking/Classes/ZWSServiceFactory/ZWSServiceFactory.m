//
//  ZWSServiceFactory.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/27.
//
//

#import "ZWSServiceFactory.h"
#import "GDMapService.h"

// service name list
NSString * const kZWSServiceGDMapV3 = @"kZWSServiceGDMapV3";

@interface ZWSServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation ZWSServiceFactory

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ZWSServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ZWSServiceFactory alloc] init];
    });
    return sharedInstance;
}


#pragma mark - public methods
- (ZWSService<ZWSServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier
{
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

#pragma mark - private methods
- (ZWSService<ZWSServiceProtocal> *)newServiceWithIdentifier:(NSString *)identifier
{
    if ([identifier isEqualToString:kZWSServiceGDMapV3]) {
        return [[GDMapService alloc] init];
    }
    
    return nil;
}

#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

@end

//
//  ZWSCache.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/5/13.
//
//

#import "ZWSCache.h"
#import "NSDictionary+ZWSNetworking.h"
#import "ZWSNetworkingConfiguration.h"

@interface ZWSCache ()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation ZWSCache

#pragma mark - getters and setters
- (NSCache *)cache
{
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = kZWSCacheCountLimit;
    }
    return _cache;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ZWSCache *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ZWSCache alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public method
- (NSData *)fetchCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                      methodName:(NSString *)methodName
                                   requestParams:(NSDictionary *)requestParams
{
    return [self fetchCachedDataWithKey:[self keyWithServiceIdentifier:serviceIdentifier
                                                            methodName:methodName
                                                         requestParams:requestParams]];
}

- (void)saveCacheWithData:(NSData *)cachedData
        serviceIdentifier:(NSString *)serviceIdentifier
               methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams
{
    [self saveCacheWithData:cachedData key:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}

- (void)deleteCacheWithServiceIdentifier:(NSString *)serviceIdentifier
                              methodName:(NSString *)methodName
                           requestParams:(NSDictionary *)requestParams
{
    [self deleteCacheWithKey:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}

- (NSData *)fetchCachedDataWithKey:(NSString *)key
{
    ZWSCacheObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject.isOutdated || cachedObject.isEmpty) {
        return nil;
    } else {
        return cachedObject.content;
    }
}

- (void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key
{
    ZWSCacheObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject == nil) {
        cachedObject = [[ZWSCacheObject alloc] init];
    }
    [cachedObject updateContent:cachedData];
    [self.cache setObject:cachedObject forKey:key];
}

- (void)deleteCacheWithKey:(NSString *)key
{
    [self.cache removeObjectForKey:key];
}

- (void)clean
{
    [self.cache removeAllObjects];
}

- (NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier
                            methodName:(NSString *)methodName
                         requestParams:(NSDictionary *)requestParams
{
    return [NSString stringWithFormat:@"%@%@%@", serviceIdentifier, methodName, [requestParams zws_urlParamsStringSignature:NO]];
}

#pragma mark - private method

@end

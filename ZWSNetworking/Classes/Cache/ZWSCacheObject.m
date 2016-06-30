//
//  ZWSCacheObject.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/5/13.
//
//

#import "ZWSCacheObject.h"
#import "ZWSNetworkingConfiguration.h"

@interface ZWSCacheObject ()

@property (nonatomic, copy, readwrite) NSData *content;
@property (nonatomic, copy, readwrite) NSDate *lastUpdateTime;

@end

@implementation ZWSCacheObject

#pragma mark - getters and setters
- (BOOL)isEmpty
{
    return self.content == nil;
}

- (BOOL)isOutdated
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastUpdateTime];
    return timeInterval > kZWSCacheOutdateTimeSeconds;
}

- (void)setContent:(NSData *)content
{
    _content = [content copy];
    self.lastUpdateTime = [NSDate dateWithTimeIntervalSinceNow:0];
}

#pragma mark - life cycle
- (instancetype)initWithContent:(NSData *)content
{
    self = [super init];
    if (self) {
        self.content = content;
    }
    return self;
}

#pragma mark - public method
- (void)updateContent:(NSData *)content
{
    self.content = content;
}


@end

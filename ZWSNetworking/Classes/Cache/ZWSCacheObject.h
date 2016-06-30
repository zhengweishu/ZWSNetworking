//
//  ZWSCacheObject.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/5/13.
//
//

#import <Foundation/Foundation.h>

@interface ZWSCacheObject : NSObject

@property (nonatomic, copy, readonly) NSData *content;
@property (nonatomic, copy, readonly) NSDate *lastUpdateTime;

@property (nonatomic, assign, readonly) BOOL isOutdated;
@property (nonatomic, assign, readonly) BOOL isEmpty;

- (instancetype)initWithContent:(NSData *)content;
- (void)updateContent:(NSData *)content;

@end

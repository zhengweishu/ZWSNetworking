//
//  NSObject+ZWSNetworking.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/5/13.
//
//

#import "NSObject+ZWSNetworking.h"

@implementation NSObject (ZWSNetworking)

- (id)zws_defaultValue:(id)defaultData
{
    if (![defaultData isKindOfClass:[self class]]) {
        return defaultData;
    }
    
    if ([self zws_isEmptyObject]) {
        return defaultData;
    }
    
    return self;
}

- (BOOL)zws_isEmptyObject
{
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}

@end

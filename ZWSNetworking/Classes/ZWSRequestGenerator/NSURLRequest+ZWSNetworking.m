//
//  NSURLRequest+ZWSNetworking.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/28.
//
//

#import "NSURLRequest+ZWSNetworking.h"
#import <objc/runtime.h>

static void *ZWSNetworkingRequestParams;

@implementation NSURLRequest (ZWSNetworking)

- (void)setRequestParams:(NSDictionary *)requestParams {

    objc_setAssociatedObject(self, &ZWSNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams {

    return objc_getAssociatedObject(self, &ZWSNetworkingRequestParams);
}

@end

//
//  ZWSArticlesAPIManager.m
//  ZWSNetworking
//
//  Created by LOFT.LIFE.ZHENG on 16/7/1.
//  Copyright © 2016年 zhengweishu. All rights reserved.
//

#import "ZWSArticlesAPIManager.h"

@interface ZWSArticlesAPIManager ()

@property (nonatomic, assign) NSInteger nextPageNumber;
@property (nonatomic, assign) NSInteger totalCount;

@end

@implementation ZWSArticlesAPIManager

#pragma mark - life cycle

- (instancetype)init {
    
    self = [super init];
    if (self) {

    }
    return self;
}

#pragma mark - ZWSAPIManager

- (NSString *)serviceType {

    return @"";
}

- (NSString *)methodName {

    return @"";
}

- (ZWSAPIManagerRequestType)requestType {

    return ZWSAPIManagerRequestTypeGet;
}

- (NSDictionary *)reformParams:(NSDictionary *)params {

    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] initWithDictionary:params];
    resultParams[@"nextPage"] = @(self.nextPageNumber);
    
    return resultParams;
}

#pragma mark - inner interceptor

- (BOOL)beforePerformSuccessWithResponse:(ZWSURLResponse *)response {

    self.totalCount = [response.content[@"result"][@"total"] integerValue];
    self.nextPageNumber++;
    
    return YES;
}

- (BOOL)beforePerformFailWithResponse:(ZWSURLResponse *)response {

    if (self.nextPageNumber >0) {
        self.nextPageNumber--;
    }
    
    return YES;
}

#pragma mark - <#Section#>

- (void)loadNextPage {

    if (self.isLoading) {
        return;
    }
    
    NSInteger totalPage = ceil(self.totalCount /15.0f);
    if (totalPage >1 && self.nextPageNumber <= totalPage) {
        [self loadData];
    }
}


@end

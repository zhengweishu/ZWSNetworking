//
//  ZWSArticlesAPIManager.h
//  ZWSNetworking
//
//  Created by LOFT.LIFE.ZHENG on 16/7/1.
//  Copyright © 2016年 zhengweishu. All rights reserved.
//

#import <ZWSNetworking/ZWSNetworking.h>

@interface ZWSArticlesAPIManager : ZWSAPIBaseManager <ZWSAPIManager>

- (void)loadNextPage;

@end

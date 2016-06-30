//
//  ZWSCaseFactory.h
//  ZWSNetworking
//
//  Created by LOFT.LIFE.ZHENG on 16/6/30.
//  Copyright © 2016年 zhengweishu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonHeader.h"

@interface ZWSCaseFactory : NSObject

- (UIViewController *)caseWithType:(CaseType)caseType;

@end

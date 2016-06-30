//
//  ZWSCaseFactory.m
//  ZWSNetworking
//
//  Created by LOFT.LIFE.ZHENG on 16/6/30.
//  Copyright © 2016年 zhengweishu. All rights reserved.
//

#import "ZWSCaseFactory.h"
#import "ZWSCoordinateTranslatorController.h"

@implementation ZWSCaseFactory

- (UIViewController *)caseWithType:(CaseType)caseType
{
    UIViewController *aCase = nil;
    
    if (caseType == CaseTypeCoordinateTranslator) {
        aCase = [[ZWSCoordinateTranslatorController alloc] init];
    }
    
    return aCase;
}

@end

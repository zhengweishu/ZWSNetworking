//
//  ZWSServiceFactory.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/27.
//
//

#import <Foundation/Foundation.h>
#import "ZWSService.h"

@interface ZWSServiceFactory : NSObject

+ (instancetype)sharedInstance;
- (ZWSService<ZWSServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier;

@end

//
//  ZWSUDIDGenerator.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/28.
//
//

#import <Foundation/Foundation.h>

@interface ZWSUDIDGenerator : NSObject

+ (id)sharedInstance;

- (NSString *)UDID;
- (void)saveUDID:(NSString *)udid;

@end

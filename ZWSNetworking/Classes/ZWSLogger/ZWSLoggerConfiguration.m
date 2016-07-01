//
//  ZWSLoggerConfiguration.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/28.
//
//

#import "ZWSLoggerConfiguration.h"
#import "ZWSServiceFactory.h"

@implementation ZWSLoggerConfiguration

- (void)configWithAppType:(ZWSAppType)appType
{
    switch (appType) {
        case ZWSAppTypeAppstore:
            self.appKey = @"xxxxxx";
            self.serviceType = @"xxxxx";
            self.sendLogMethod = @"xxxx";
            self.sendActionMethod = @"xxxxxx";
            self.sendLogKey = @"xxxxx";
            self.sendActionKey = @"xxxx";
            break;
    }
}

@end

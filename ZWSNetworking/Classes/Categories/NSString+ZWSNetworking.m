//
//  NSString+ZWSNetworking.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/6/28.
//
//

#import "NSString+ZWSNetworking.h"
#import "NSObject+ZWSNetworking.h"

#include <CommonCrypto/CommonDigest.h>

@implementation NSString (ZWSNetworking)

- (NSString *)zws_md5
{
    NSData* inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes], (unsigned int)[inputData length], outputData);
    
    NSMutableString* hashStr = [NSMutableString string];
    int i = 0;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
        [hashStr appendFormat:@"%02x", outputData[i]];
    
    return hashStr;
}

@end

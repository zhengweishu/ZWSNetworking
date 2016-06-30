//
//  NSMutableString+ZWSNetworking.m
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/5/13.
//
//

#import "NSMutableString+ZWSNetworking.h"
#import "NSObject+ZWSNetworking.h"

@implementation NSMutableString (ZWSNetworking)

- (void)appendURLRequest:(NSURLRequest *)request
{
    [self appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [self appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [self appendFormat:@"\n\nHTTP Body:\n\t%@", [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] zws_defaultValue:@"\t\t\t\tN/A"]];
}

@end

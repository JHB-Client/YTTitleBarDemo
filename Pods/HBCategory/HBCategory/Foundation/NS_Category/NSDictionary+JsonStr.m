//
//  NSDictionary+JsonStr.m
//  SLFDA
//
//  Created by 季怀斌 on 2017/3/16.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "NSDictionary+JsonStr.h"

@implementation NSDictionary (JsonStr)
- (NSString *)getDictJsonStr {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    NSString *dictStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return dictStr;
}

@end

//
//  UITextField+ForbiddenCopyOrPaste.m
//  SLFDA
//
//  Created by 季怀斌 on 2017/7/10.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "UITextField+ForbiddenCopyOrPaste.h"

@implementation UITextField (ForbiddenCopyOrPaste)
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
@end

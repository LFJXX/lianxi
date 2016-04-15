//
//  AppDelegate+EaseMobDebug.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 15/7/1.
//  Copyright (c) 2015年 dujiepeng. All rights reserved.
//  测试用，开发者不需要使用此类

#import "AppDelegate+EaseMobDebug.h"

#import "EMOptions+PrivateDeploy.h"

#warning 环信内部测试用，开发者不需要使用此类

@implementation AppDelegate (EaseMobDebug)


-(BOOL)isSpecifyServer{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSNumber *specifyServer = [ud objectForKey:@"identifier_enable"];
    if ([specifyServer boolValue]) {
        NSString *apnsCertName = nil;
#if DEBUG
        apnsCertName = @"chatdemoui_dev";
#else
        apnsCertName = @"chatdemoui";
#endif
        NSString *appkey = [ud stringForKey:@"identifier_appkey"];
        if (!appkey)
        {
            appkey = @"easemob-demo#chatdemoui";
            [ud setObject:appkey forKey:@"identifier_appkey"];
        }
        NSString *imServer = [ud stringForKey:@"identifier_imserver"];
        if (!imServer)
        {
            imServer = @"im1.sandbox.easemob.com";
            [ud setObject:imServer forKey:@"identifier_imserver"];
        }
        NSString *imPort = [ud stringForKey:@"identifier_import"];
        if (!imPort)
        {
            imPort = @"443";
            [ud setObject:imPort forKey:@"identifier_import"];
        }
        NSString *restServer = [ud stringForKey:@"identifier_restserver"];
        if (!restServer)
        {
            restServer = @"a1.sdb.easemob.com";
            [ud setObject:restServer forKey:@"identifier_restserver"];
        }
        [ud synchronize];
        
        EMOptions *options = [EMOptions optionsWithAppkey:appkey];
        if (![ud boolForKey:@"enable_dns"])
        {
            options.enableDnsConfig = NO;
            options.chatPort = [[ud stringForKey:@"identifier_import"] intValue];
            options.chatServer = [ud stringForKey:@"identifier_imserver"];
            options.restServer = [ud stringForKey:@"identifier_restserver"];
        }
        //    EMOptions *options = [EMOptions optionsWithAppkey:@"easemob-demo#chatdemoui"];
        options.apnsCertName = @"chatdemoui_dev";
        options.enableConsoleLog = YES;
        
        [[EMClient sharedClient] initializeSDKWithOptions:options];
        return YES;
    }
    
    return NO;
}
@end

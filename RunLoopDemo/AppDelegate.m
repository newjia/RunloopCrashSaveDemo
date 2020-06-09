//
//  AppDelegate.m
//  RunLoopDemo
//
//  Created by 李佳 on 2020/6/9.
//  Copyright © 2020 李佳. All rights reserved.
//

#import "AppDelegate.h"
#import "CrashHandler.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [CrashHandler sharedInstance];
    
    __weak typeof(self) weakSelf = self;
    [[CrashHandler sharedInstance] crash:^{
        [weakSelf showFriendlyTips];
    }];
    return YES;
}

// 本方法可以自行替换
- (void)showFriendlyTips{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"☀️" message:@"亲爱的小朋友，你的App 发生了神秘故障，需要重新修复" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"👌👌" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self resetApp];
    }];
    [alertController addAction:skipAction];

    UINavigationController *navi = [self getRootVC];
    [navi presentViewController:alertController animated:YES completion:nil];
}


// 重置App 的根控制器（可以改成你需要的）
- (void)resetApp{
    NSLog(@"起死回生");

    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *navi = [storyBoard instantiateInitialViewController];
    
    [self keyWindow].rootViewController = navi;
}
// 获取根window
- (UIWindow *)keyWindow{
    UIWindow *window = nil;
    
    if (@available(iOS 13.0, *))
    {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes)
        {
            if (windowScene.activationState == UISceneActivationStateForegroundActive)
            {
                window = windowScene.windows.firstObject;
                break;
            }
        }
    }else{
        window = [UIApplication sharedApplication].keyWindow;
    }
    return window;
}

// 获取根控制器
- (UINavigationController *)getRootVC{
    return (UINavigationController *)[self keyWindow].rootViewController;
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end

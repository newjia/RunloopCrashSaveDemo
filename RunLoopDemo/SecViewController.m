//
//  SecViewController.m
//  RunLoopDemo
//
//  Created by 李佳 on 2020/6/9.
//  Copyright © 2020 李佳. All rights reserved.
//

#import "SecViewController.h"

@interface SecViewController ()

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 崩溃的方法
- (IBAction)crashAction:(id)sender {
    NSArray *array =[NSArray array];
    NSLog(@"%@",[array objectAtIndex:1]);
    
    // 本方法只能使用异常拯救一次，下次执行本方法会直接崩溃
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

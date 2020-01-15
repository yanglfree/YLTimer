//
//  ViewController.m
//  YLTimer
//
//  Created by yl on 2020/1/15.
//  Copyright © 2020 yl. All rights reserved.
//

#import "ViewController.h"
#import "YLTimer.h"

@interface ViewController ()

@property (nonatomic, strong) YLTimer *timer;
@property (nonatomic, strong) NSString *name; //timer的标识

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建定时器任务
    self.name = [YLTimer execTask:^{
        NSLog(@"task exec------%@",[NSThread currentThread]);
    } start:1.0 interval:1.0 repeats:YES async:NO];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //取消任务
    [YLTimer cancelTask:self.name];
}


@end

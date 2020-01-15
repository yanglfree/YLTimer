//
//  YLTimer.m
//  Interview_timer
//
//  Created by yl on 2020/1/14.
//  Copyright © 2020 yl. All rights reserved.
//

#import "YLTimer.h"

static NSMutableDictionary *timers_;
static dispatch_semaphore_t semaphore_;

static const int CONCRETE_COUNT = 3; //最大并发数


@implementation YLTimer

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(CONCRETE_COUNT);
    });
}

+ (NSString *)execTask:(TimerTask)task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async
{
    if (!task || start < 0 || (interval <=0 && repeats == YES)) return nil;
    
    dispatch_queue_t queue = async ? dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL) : dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, start * NSEC_PER_SEC);
    
    //控制并发数
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    NSString *name = [NSString stringWithFormat:@"%zd", timers_.count];
    timers_[name] = timer;
    dispatch_semaphore_signal(semaphore_);
    
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self cancelTask:name];
        }
    });
    dispatch_resume(timer);
    
    return name;
}

/**
 根据timer的名称来取消对应的timer
 */
+ (void)cancelTask:(NSString *)taskName
{
    if ([taskName isEqualToString:@""]) return;
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    
    dispatch_source_t timer = timers_[taskName];
    if (timer){
        dispatch_source_cancel(timers_[taskName]);
        [timers_ removeObjectForKey:taskName];
        NSLog(@"timer cancel-------");
    }
    dispatch_semaphore_signal(semaphore_);
}

@end

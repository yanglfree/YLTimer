//
//  YLTimer.h
//  Interview_timer
//
//  Created by yl on 2020/1/14.
//  Copyright © 2020 yl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^task)(void);

typedef void(^TimerTask)(void);

@interface YLTimer : NSObject

/**
执行定时任务
@param task 任务block
@param start  多少秒后开始执行
@param interval timer 间隔
@param repeats 是否重复执行
@param async 是否同步执行
*/
+ (NSString *)execTask:(TimerTask)task
                 start:(NSTimeInterval)start
              interval:(NSTimeInterval)interval
               repeats:(BOOL)repeats
                 async:(BOOL)async;

/**
 取消任务
 @param taskName 任务标识
 */
+ (void)cancelTask:(NSString *)taskName;

@end

NS_ASSUME_NONNULL_END

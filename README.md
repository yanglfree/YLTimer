# YLTimer
一个封装的易用的Timer定时器

解决循环引用问题，随时开启，随时结束

可以控制是否同步执行

```
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
```


```
/**
 取消任务
 @param taskName 任务标识
 */
+ (void)cancelTask:(NSString *)taskName;

```


使用的时候直接通过类方法调用：
```
    //创建定时器任务
    self.name = [YLTimer execTask:^{
        NSLog(@"task exec------%@",[NSThread currentThread]);
    } start:1.0 interval:1.0 repeats:YES async:NO];
```

保存定时器的标识，随时取消
```
 //取消任务
    [YLTimer cancelTask:self.name];
```

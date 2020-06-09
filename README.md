# RunloopCrashSaveDemo

### 原理

1. App 启动时创建一个捕获异常的单例`CrashHandler`
2. 通过单例创建捕获崩溃，使用的是`NSSetUncaughtExceptionHandler(NSUncaughtExceptionHandler * _Nullable)` 方法
3. 持有异常回调的方法，根据捕获到的异常（分为NSException、Signal 两种），分析捕获的堆栈信息
4. 友好弹出崩溃提示（文案可以定义）
5. 获取当前崩溃堆栈的runloop，本根据它获取所有的runloop，强制运行所有runloop，起到App保活效果

### 注意

捕获方法目前只可以执行一次，下次触发崩溃后，会跳过捕获方法，直接崩溃。

### 使用

1. 将`CrashHandler` 的.h .m 文件拖入你的仓库

2. 程序启动时，配置handler ，我是在Appdelegate进行。参考如下代码

   ```objective-c
       [CrashHandler sharedInstance];
       
       __weak typeof(self) weakSelf = self;
       [[CrashHandler sharedInstance] crash:^{
           [weakSelf showFriendlyTips];
       }];
   ```

3. 在捕获到崩溃后`showFriendlyTips` 方法里，你可以自行提示弹窗

4. 执行重置App 的启动页方法`resetApp`，来跳过崩溃的页面，你也可以自行修改。参考如下：

   ```objective-c
   // 重置App 的根控制器（可以改成你需要的）
   - (void)resetApp{
       NSLog(@"起死回生");
   
       UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
       UINavigationController *navi = [storyBoard instantiateInitialViewController];
       
       [self keyWindow].rootViewController = navi;
   ```

   ### 最后

   Have Fun！最好还是要彻底检查崩溃来源

![](saveme.jpeg)


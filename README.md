# RunloopCrashSaveDemo

### 原理

1. App 启动时创建一个捕获异常的单例`CrashHandler`
2. 通过单例创建捕获崩溃，使用的是`NSSetUncaughtExceptionHandler(NSUncaughtExceptionHandler * _Nullable)` 方法
3. 持有异常回调的方法，根据捕获到的异常（分为NSException、Signal 两种），分析捕获的堆栈信息
4. 获取当前崩溃堆栈的runloop，本根据它获取所有的runloop，强制运行所有runloop，起到App保活效果


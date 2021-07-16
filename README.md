# Emitter

> Emitter: Distributed Publish-Subscribe Platform

Emitter: 事件触发器/EventBus。这个库主要目的是用来解决全局散乱的消息通知逻辑。参考 SwiftEventBus 以及 NodeJS 的事件触发器编写而成。有以下特点。

1. 不同于 SwiftEventBus，Emitter 抛弃了 `NSNotificationCenter` ，重新实现事件分发逻辑
2. Emitter 代码内部维护了串行队列，可以减少多线程问题的发生。
3. 在监听事件时，也可以指定事件触发时的队列，未指定时，会自动在主队列上执行事件
4. 在内部会自动移除不活跃的监听者，使用者不必关注监听者的内存释放问题
5. 提供了一系列功能强大的移除监听方法事件。

## License

Emitter is available under the MIT license. See the LICENSE file for more info.

trigger HelloWorldTriggr on Account (before insert) {
System.debug('hello world');
}
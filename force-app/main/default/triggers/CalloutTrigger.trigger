trigger CalloutTrigger on Account (after insert) {
    CalloutClass.makeCallout();
}
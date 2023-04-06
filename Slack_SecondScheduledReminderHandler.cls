global class Slack_SecondScheduledReminderHandler implements Schedulable  {

    global void execute(SchedulableContext sc) {
            Slack_ReminderHandler.sendSecondReminder();
        }
}

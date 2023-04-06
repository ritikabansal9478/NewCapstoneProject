global class Slack_ScheduledReminderHandler implements Schedulable {

           
    global void execute(SchedulableContext sc) {
            Slack_ReminderHandler.sendReminder();
        } 
    
    
        // global static void scheduleNow() { 
    
            // datetime thisTime = system.now().addSeconds(15);
            // integer minute = thisTime.minute(); 
            // integer second = thisTime.second(); 
            // integer hour = thisTime.hour(); 
            // integer year = thisTime.year(); 
            // integer month = thisTime.month(); 
            // integer day = thisTime.day(); 
        
            // String timeStamp = second + ' ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ? ' + year; 
            // string jobName = 'Slack Reminder Automation Schedule'; 
        
            // Slack_ScheduledReminderHandler p = new Slack_ScheduledReminderHandler(); 
            // system.schedule(jobName, timeStamp , p); 
    
        // }
        
}
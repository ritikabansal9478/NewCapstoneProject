public class Slack_ReminderHandler {

    @future(callout=true)
    public static void sendReminder(){
        List<User> x = [SELECT Id, Slack_User_Id__c, Email, StaffingStatus__c FROM User WHERE StaffingStatus__c =: 'On Bench'];
        Slack.ViewReference view = Slack.View.deckreminder.get();
        Util.inFutureContext = true;
        Slack_SendReminder.sendMessageToUsers(x, view);
        Util.inFutureContext = false;
    }


    @future(callout=true)
    public static void sendSecondReminder(){
                                                        
        List<User> listOfUserOnBench = [SELECT Id, Slack_User_Id__c, Email, StaffingStatus__c 
                                        FROM User 
                                        WHERE StaffingStatus__c = 'On Bench' AND (Id IN (SELECT User__c
                                                                                        FROM On_Deck_Survey_Result__c
                                                                                        WHERE CreatedDate < =  LAST_N_DAYS:6))];


         System.debug(listOfUserOnBench);                                                                               
        //Slack.ViewReference view = Slack.View.deckreminder.get();
        //Util.inFutureContext = true;
        //Slack_SendReminder.sendMessageToUsers(listOfUserOnBench, view);
        //Util.inFutureContext = false;

    }
}
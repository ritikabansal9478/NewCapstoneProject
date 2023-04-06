public class SlackUpdateClass {

    public static void userQuery(){
    List<User> list = [SELECT Id, StaffingStatus__c
                            FROM User       
                            WHERE StaffingStatus__c =: 'On Bench'];

    System.debug(list);
}
}

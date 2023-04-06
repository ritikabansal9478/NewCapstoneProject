public with sharing class iniController {
    
    @AuraEnabled(cacheable=true)
    public static List<Inn__c> getInitiatives(){
        try {
            return [
                SELECT Id, Name, Description__c, Link__c, Priority__c, Type__c, Time_Requirement__c, Create_Date__c
                FROM Inn__c 
                ORDER BY Priority__c
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
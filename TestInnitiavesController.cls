@isTest
private class TestInnitiavesController {

    private static Inn__c generateInnitiative(String InnitiativeName) {
        Inn__c testInnitiave = new Inn__c();
        testInnitiave.Name = InnitiativeName;
        return testInnitiave;
    }

    @TestSetup
    static void createTimesheetData(){
        Inn__c testInnitivativeData = generateInnitiative('Unit Test Innitiative');
        insert testInnitivativeData;
    }


    @isTest
    static void testInnitiativeCreated() {

        List<Inn__c> testInnitiavesDataInList = [SELECT Type__c FROM Inn__c];

        Test.startTest();

        testInnitiavesDataInList[0].Type__c = 'Training';
        update testInnitiavesDataInList[0];

        Test.stopTest();

        List<Inn__c> updatedInnitiatives = [SELECT COUNT FROM Inn__c];

        System.assertEquals(1, testInnitiavesDataInList[0].COUNT,
                                'There should be atleast 1 Training Innitiative');


    }
}
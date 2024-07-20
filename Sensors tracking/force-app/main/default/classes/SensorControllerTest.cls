@isTest
private class SensorControllerTest {
    @testSetup
    static void setup() {
        // Use TestFactory to create test data
        Sensor__c sensor = TestFactory.createSensor('Sensor1');
        TestFactory.createSensorEvent(sensor, 1, 2, 3);
    }

    @isTest
    static void testGetSensors() {
        List<Sensor__c> sensors = [SELECT Id, Name, Max_Vectors_Length__c, CreatedDate FROM Sensor__c];

        Test.startTest();
        List<Sensor__c> result = SensorController.getSensors();
        Test.stopTest();

        System.assertEquals(sensors, result, 'The returned result should be the same as the mocked one');
    }

    @isTest
    static void testGetSensorEvents() {
        Sensor__c sensor = [SELECT Id FROM Sensor__c LIMIT 1];

        Test.startTest();
        List<Sensor_Event__c> testEvents = SensorController.getSensorEvents(sensor.Id);
        Test.stopTest();

        System.assertEquals(1, testEvents.size(), 'Should have retrieved 1 events');
    }

    @isTest
    static void testUpdateSensorEvents() {
        Sensor_Event__c event = [SELECT Id, x__c, y__c, z__c FROM Sensor_Event__c LIMIT 1];
        
        event.x__c = 11;
        event.y__c = 22;
        event.z__c = 33;

        Test.startTest();
        SensorController.updateSensorEvents(new List<Sensor_Event__c>{event});
        Test.stopTest();

        Sensor_Event__c updatedEvent = [SELECT Id, x__c, y__c, z__c FROM Sensor_Event__c WHERE Id = :event.Id];
        System.assertEquals(11, updatedEvent.x__c, 'x__c should be 11');
        System.assertEquals(22, updatedEvent.y__c, 'y__c should be 22');
        System.assertEquals(33, updatedEvent.z__c, 'z__c should be 33');
    }

    @isTest
    static void testUpdateSensorEventsNegative() {
        //Sensor_Event__c invalidEvent = new Sensor_Event__c(Id = 'invalidId', x__c = 11, y__c = 22, z__c = 33);

        Test.startTest();
        try {
            // Try to update the invalid sensor event
            SensorController.updateSensorEvents(null);
            System.assert(false, 'Expected an AuraHandledException to be thrown');
        } catch (AuraHandledException e) {
            System.assert(true, 'Expected an AuraHandledException to be thrown');
        }
        Test.stopTest();
    }
}
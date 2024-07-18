@IsTest
public class SensorServiceTest {
    public static List<SensorService.Sensor> testData;

    @TestSetup
    static void loadTestData() {
        // Insert existing sensor to test the removal of existing sensors
        Sensor__c existingSensor = TestFactory.generateSobjectSensor('Sensor1');
        insert existingSensor;

        // Prepare test data
        /*SensorService.Sensor sensor1 = TestFactory.generateSensor('Sensor1');
        sensor1.vectors = new List<SensorService.SensorEvent>{
            TestFactory.generateSensorEvent(22, 17, 197),
            TestFactory.generateSensorEvent(23, 45, 14)
        };

        // Prepare test data
        SensorService.Sensor sensor2 = TestFactory.generateSensor('Sensor2');
        sensor2.vectors = new List<SensorService.SensorEvent>{
            TestFactory.generateSensorEvent(23, 11, 127),
            TestFactory.generateSensorEvent(24, 15, 15)
        };

        testData = new List<SensorService.Sensor>{sensor1, sensor2};*/

        //TestFactory.setTestData(sensorList);
    }

    /*@IsTest
    static void testAddServiceSuccess() {
        // Retrieve test data
        //List<SensorService.Sensor> sensors = TestFactory.getTestData();
        SensorService.Sensor sensor1 = TestFactory.generateSensor('Sensor1');
        sensor1.vectors = new List<SensorService.SensorEvent>{
            TestFactory.generateSensorEvent(22, 17, 197),
            TestFactory.generateSensorEvent(23, 45, 14)
        };

        // Prepare test data
        SensorService.Sensor sensor2 = TestFactory.generateSensor('Sensor2');
        sensor2.vectors = new List<SensorService.SensorEvent>{
            TestFactory.generateSensorEvent(23, 11, 127),
            TestFactory.generateSensorEvent(24, 15, 15)
        };

        SensorService.Sensor sensor2 = new SensorService.Sensor();
        sensor2.sensorid = 'Sensor2';
        sensor2.vectors = new List<SensorService.SensorEvent>{
            new SensorService.SensorEvent(23, 11, 127),
            new SensorService.SensorEvent(24, 15, 15)
        };
        List<SensorService.Sensor> sensors = new List<SensorService.Sensor>{sensor2};
        // Perform the method call
        Test.startTest();
        SensorService.addSensor(sensors);
        Test.stopTest();

        // Verify the inserted records
        List<Sensor__c> insertedSensors = [SELECT Name FROM Sensor__c WHERE Name IN ('Sensor1', 'Sensor2')];
        System.assertEquals(1, insertedSensors.size());

        List<Sensor_Event__c> insertedEvents = [SELECT Sensor__c, x__c, y__c, z__c FROM Sensor_Event__c];
        System.assertEquals(2, insertedEvents.size());
    }*/

    /*@IsTest
    static void testAddServiceWithExistingSensor() {
        // Retrieve test data
        List<SensorService.Sensor> sensors = TestFactory.getTestData();

        // Perform the method call
        Test.startTest();
        SensorService.addSensor(sensors);
        Test.stopTest();

        // Verify the inserted records
        List<Sensor__c> insertedSensors = [SELECT Name FROM Sensor__c WHERE Name = 'Sensor2'];
        System.assertEquals(1, insertedSensors.size());

        List<Sensor_Event__c> insertedEvents = [SELECT Sensor__c, x__c, y__c, z__c FROM Sensor_Event__c];
        System.assertEquals(2, insertedEvents.size());
    }

    @IsTest
    static void testAddServiceWithException() {
        // Retrieve test data
        List<SensorService.Sensor> sensors = TestFactory.getTestData();

        // Introduce an error in the data to cause an exception
        sensors[1].sensorid = null;  // Missing sensorid for the second sensor

        // Perform the method call
        Test.startTest();
        try {
            SensorService.addSensor(sensors);
            System.assert(false, 'Expected an exception to be thrown');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('An error occurred:'), 'Expected an error message containing "An error occurred:"');
        }
        Test.stopTest();
    }*/
}

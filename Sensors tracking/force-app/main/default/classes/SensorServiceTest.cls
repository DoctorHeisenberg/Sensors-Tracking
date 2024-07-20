@IsTest
public class SensorServiceTest {
    @IsTest
    static void testAddSensor() {
        Sensor__c sensor = new Sensor__c(Name = 'Sensor1');
        insert sensor;

        List<SensorService.Sensor> sensors = new List<SensorService.Sensor>();
        
        SensorService.Sensor sensor1 = new SensorService.Sensor();
        sensor1.sensorid = 'Sensor1';
        sensor1.vectors = new List<SensorService.SensorEvent>{
            new SensorService.SensorEvent(1.0, 2.0, 3.0)
        };
        sensors.add(sensor1);

        SensorService.Sensor sensor2 = new SensorService.Sensor();
        sensor2.sensorid = 'Sensor2';
        sensor2.vectors = new List<SensorService.SensorEvent>{
            new SensorService.SensorEvent(7.0, 8.0, 9.0),
            new SensorService.SensorEvent(4.0, 5.0, 6.0)
        };
        sensors.add(sensor2);

        Test.startTest();
        RestResponse res = new RestResponse();
        RestContext.response = res;
        SensorService.addSensor(sensors);
        Test.stopTest();
        
        // Verify the response
        System.assertEquals(200, res.statusCode, 'Wrong responce code');
        System.assertEquals('Records successfully inserted.', res.responseBody.toString(), 'Wrong responce message');
        
        // Verify sensors were inserted
        List<Sensor__c> insertedSensors = [SELECT Name FROM Sensor__c WHERE Name IN ('Sensor1', 'Sensor2')];
        System.assertEquals(2, insertedSensors.size(), 'Wrong inserted sensors count');
        
        // Verify sensor events were inserted
        List<Sensor_Event__c> insertedEvents = [SELECT Sensor__c, x__c, y__c, z__c FROM Sensor_Event__c];
        System.assertEquals(2, insertedEvents.size(), 'Wrong inserted events count');
    }

    @IsTest
    static void testAddServiceWithException() {

        Test.startTest();
        RestResponse res = new RestResponse();
        RestContext.response = res;
        SensorService.addSensor(null);
        Test.stopTest();

        // Verify the response
        System.assertEquals(500, res.statusCode, 'Wrong responce code');
        System.assert(res.responseBody.toString().contains('An error occurred:'), 'Wrong responce message');
    }
}

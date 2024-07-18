@isTest
public class TestFactory {
    public static List<SensorService.Sensor> testData;
    public static Sensor__c generateSobjectSensor(String name) {
        Sensor__c sensor = new Sensor__c(Name = name);
        return sensor;
    }
    public static SensorService.Sensor generateSensor(String name) {
        SensorService.Sensor sensor = new SensorService.Sensor();
        sensor.sensorid = name;
        return sensor;
    }
    public static SensorService.SensorEvent generateSensorEvent(
        Integer x, 
        Integer y, 
        Integer z
    ) {
        SensorService.SensorEvent event = new SensorService.SensorEvent(x, y, z);
        return event;
    }
    public static void setTestData(List<SensorService.Sensor> data) {
        testData = data;
    }
    public static List<SensorService.Sensor> getTestData() {
        return testData;
    }
}
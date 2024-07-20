@isTest
public class TestFactory {
    public static Sensor__c createSensor(String name) {
        Sensor__c sensor = new Sensor__c(Name = name);
        insert sensor;
        return sensor;
    }

    public static Sensor_Event__c createSensorEvent(Sensor__c sensor, Decimal x, Decimal y, Decimal z) {
        Sensor_Event__c event = new Sensor_Event__c(Sensor__c = sensor.Id, x__c = x, y__c = y, z__c = z);
        insert event;
        return event;
    }
}
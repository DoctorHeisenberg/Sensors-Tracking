public class SensorServiceHelper {
    //Maps SensorService.Sensor records to Sensor__c SObject
    public static List<Sensor__c> prepareSensors(List<SensorService.Sensor> sensors) {
        List<Sensor__c> sensorsToInsert = new List<Sensor__c>();
        
        for (SensorService.Sensor sensor : sensors) {
            Sensor__c newSensor = new Sensor__c(
                Name = sensor.sensorid
            );
            sensorsToInsert.add(newSensor);
        }
        
        return sensorsToInsert;
    }

    //Maps SensorService.SensorEvent records to Sensor_Event__c SObject
    public static List<Sensor_Event__c> prepareSensorEvents(
        List<SensorService.Sensor> sensors, 
        List<Sensor__c> insertedSensors
    ) {
        List<Sensor_Event__c> sensorEventsToInsert = new List<Sensor_Event__c>();

        for (Integer i = 0; i < sensors.size(); i++) {
            SensorService.Sensor sensor = sensors[i];
            Sensor__c insertedSensor = insertedSensors[i];
            
            for (SensorService.SensorEvent event : sensor.vectors) {
                sensorEventsToInsert.add(new Sensor_Event__c(
                    Sensor__c = insertedSensor.Id,
                    x__c = event.x,
                    y__c = event.y,
                    z__c = event.z
                ));
            }
        }

        return sensorEventsToInsert;
    }

    //Removes existing Sensor__c records from List
    public static void removeExistingSensors(List<SensorService.Sensor> sensors) {
        Set<String> sensorIds = new Set<String>();
        for (SensorService.Sensor sensor : sensors) {
            if (sensor.sensorid != null) {
                sensorIds.add(sensor.sensorid);
            }
        }

        Set<String> existingSensorNames = new Set<String>();
        for (Sensor__c existingSensor : [SELECT Name FROM Sensor__c WHERE Name IN :sensorIds]) {
            existingSensorNames.add(existingSensor.Name);
        }

        for (Integer i = sensors.size() - 1; i >= 0; i--) {
            if (existingSensorNames.contains(sensors[i].sensorid)) {
                sensors.remove(i);
            }
        }
    }
}

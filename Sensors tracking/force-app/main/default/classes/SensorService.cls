@RestResource(urlMapping='/Sensor/*')
global with sharing class SensorService {
    @HttpPost
    global static void addSensor(List<Sensor> sensors) {
        RestResponse response = RestContext.response;
        
        try {
            // Remove existing sensors from the input list
            SensorServiceHelper.removeExistingSensors(sensors);
            
            List<Sensor__c> sensorsToInsert = SensorServiceHelper.prepareSensors(sensors);
    
            // Insert new sensors
            if (!sensorsToInsert.isEmpty()) {
                insert sensorsToInsert;
                
                List<Sensor_Event__c> sensorEventsToInsert = SensorServiceHelper.prepareSensorEvents(sensors, sensorsToInsert);
                
                // Insert sensor events
                if (!sensorEventsToInsert.isEmpty()) {
                    insert sensorEventsToInsert;
                }
            }
            
            response.statusCode = 200; // Success
            response.responseBody = Blob.valueOf('Records successfully inserted.');
        } catch (Exception e) {
            response.statusCode = 500; // Internal Server Error
            response.responseBody = Blob.valueOf('An error occurred: ' + e.getMessage());
        }
    }

    global class Sensor {
        public String sensorid;
        public List<SensorEvent> vectors;
    }

    global class SensorEvent {
        public Decimal x;
        public Decimal y;
        public Decimal z;

        public SensorEvent(Decimal x, Decimal y, Decimal z) {
            this.x = x;
            this.y = y;
            this.z = z;
        }
    }
}

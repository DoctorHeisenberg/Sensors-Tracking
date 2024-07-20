public with sharing class SensorController {
    
    @AuraEnabled(cacheable=true)
    public static List<Sensor__c> getSensors() {
        try {
            return [SELECT Id, Name, Max_Vectors_Length__c, CreatedDate FROM Sensor__c];
        } catch (Exception e) {
            throw new AuraHandledException('Error retrieving sensors: ' + e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Sensor_Event__c> getSensorEvents(Id sensorId) {
        try {
            return [SELECT Id, Name, x__c, y__c, z__c, Modulus_Vector_Length__c 
                FROM Sensor_Event__c WHERE Sensor__c = :sensorId];
        } catch (Exception e) {
            throw new AuraHandledException('Error retrieving sensor events: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void updateSensorEvents(List<Sensor_Event__c> sensorEvents) {
        try {
            update sensorEvents;
        } catch (Exception e) {
            throw new AuraHandledException('Error updating sensor events: ' + e.getMessage());
        }
    }
}

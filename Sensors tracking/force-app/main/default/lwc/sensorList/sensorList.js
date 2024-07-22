import { LightningElement, wire, track } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import SENSOR_SELECTED_CHANNEL from '@salesforce/messageChannel/sensorMessageChannel__c';
import getSensors from '@salesforce/apex/SensorController.getSensors';

const COLUMNS = [
    {
        type: 'button',
        typeAttributes: {
            label: 'Events',
            name: 'view_events',
            variant: 'brand'
        },
        initialWidth: 90
    },
    { label: 'Sensor Name', fieldName: 'Name' },
    { label: 'Max Vectors Length', fieldName: 'Max_Vectors_Length__c' },
    { label: 'Created Date', fieldName: 'CreatedDate' },
];

export default class SensorList extends LightningElement {
    @track sensors;
    @track error;
    columns = COLUMNS;

    @wire(getSensors)
    wiredSensors({ error, data }) {
        if (data) {
            this.sensors = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.sensors = undefined;
        }
    }

    @wire(MessageContext)
    messageContext;

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        if (actionName === 'view_events') {
            const payload = { sensorId: row.Id };
            publish(this.messageContext, SENSOR_SELECTED_CHANNEL, payload);
        }
    }
}
import { LightningElement, wire, track } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import SENSOR_SELECTED_CHANNEL from '@salesforce/messageChannel/sensorMessageChannel__c';
import getSensorEvents from '@salesforce/apex/SensorController.getSensorEvents';
import updateSensorEvents from '@salesforce/apex/SensorController.updateSensorEvents';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    { label: 'Event Name', fieldName: 'Name' },
    { label: 'X', fieldName: 'x__c', type: 'number', editable: true },
    { label: 'Y', fieldName: 'y__c', type: 'number', editable: true },
    { label: 'Z', fieldName: 'z__c', type: 'number', editable: true },
    { label: 'Modulus vector length', fieldName: 'Modulus_Vector_Length__c', type: 'number' }
];

export default class SensorEventList extends LightningElement {
    @track sensorId;
    @track events;
    @track error;
    @track draftValues = [];
    columns = COLUMNS;

    wiredSensorEvents;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                SENSOR_SELECTED_CHANNEL,
                (message) => this.handleMessage(message)
            );
        }
    }

    handleMessage(message) {
        this.sensorId = message.sensorId;
    }

    @wire(getSensorEvents, { sensorId: '$sensorId' })
    wiredGetSensorEvents(result) {
        this.wiredSensorEvents = result;
        const { error, data } = result;
        if (data) {
            this.events = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.events = undefined;
        }
    }

    handleSave(event) {
        const updatedFields = event.detail.draftValues;

        // Clear all draft values
        this.draftValues = [];

        updateSensorEvents({ sensorEvents: updatedFields })
            .then(() => {
                this.showToast('Success', 'Sensor events updated successfully', 'success');
                this.draftValues = [];
                // Refresh the table
                return refreshApex(this.wiredSensorEvents);
            })
            .catch(error => {
                this.showToast('Error updating records', error.body.message, 'error');
            });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}

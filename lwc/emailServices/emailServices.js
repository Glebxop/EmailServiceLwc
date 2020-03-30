/**
 * Created by Master on 15.11.2019.
 */

import { LightningElement } from 'lwc';
import sendMessageCtrl from '@salesforce/apex/EmailServicesLwcController.sendMessage'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class HelloWorld extends LightningElement {
    textOfM;
    subjectOfM;
    emailTo ='Right@email.com';
    hardkodEmail = 'emailformeeting@20q04aq3nmfbkwgait1vckf158n8e3hdk0hwksp7lytp4bqdbs.9d-usjuau.cs76.apex.sandbox.salesforce.com'

    sendMessage() {
        let errorMessage='Error: ';
        if (!this.textOfM) {
            errorMessage += 'text is empty;';
        }
        if (!this.subjectOfM){errorMessage += 'subject is empty;'}
        if(errorMessage!=='Error: '){
            this.showToast(errorMessage,'error');
        } else {
        sendMessageCtrl({mailText : this.textOfM, mailSubject : this.subjectOfM, emailAdress:this.hardkodEmail})
        .then((result)=> {
            if(result ==='ok'){
            this.showToast('Message was send', 'success');
            }
        })
        .catch(error => {
            this.showToast( error.body.message,'error' );
        });}}


    changeSubject(event) {
        this.subjectOfM = event.target.value;
    }

    changeText(event) {
        this.textOfM = event.target.value;
    }
    showToast(param,variant) {
        const evt = new ShowToastEvent({
            title: param,
            message:param,
            variant: variant,
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }




}

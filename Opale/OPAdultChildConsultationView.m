//
//  OPAdultChildConsultationView.m
//  Opale
//
//  Created by Camille Maurice on 28/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPMainWindow.h"
#import "OPInvoicePanel.h"
#import "OPAdultChildConsultationView.h"
#import "OPPatient.h"
#import "OPConsultation.h"
#import "OPInvoice.h"

@implementation OPAdultChildConsultationView

@synthesize invoicePanel, consultation, consultationDate, textTests, textTreatments, textAdvises, textMotives;

-(void)loadConsultation:(OPConsultation *)nConsultation{
    
    consultation = nConsultation;
    
    [consultationDate setDateValue:consultation.date];
    
    if(consultation.tests){
        [textTests setString:[[NSString alloc] initWithString:consultation.tests]];
    }
    else{
        [textTests setString:@""];
    }
    
    if(consultation.treatments){
        [textTreatments setString:[[NSString alloc] initWithString:consultation.treatments]];
    }
    else{
        [textTreatments setString:@""];
    }
    
    if(consultation.advises){
        [textAdvises setString:[[NSString alloc] initWithString:consultation.advises]];
    }
    else{
        [textAdvises setString:@""];
    }
    
    [invoicePanel setConsultation:consultation];
    [[invoicePanel payer] setStringValue:[NSString stringWithFormat:@"%@ %@", consultation.patient.firstName, consultation.patient.lastName]];
}

#pragma mark - Actions

-(IBAction)saveConsultation:(id)sender{
    
    consultation.date = [consultationDate dateValue];
    consultation.tests = [[NSString alloc] initWithString:[textTests string]];
    consultation.treatments = [[NSString alloc] initWithString:[textTreatments string]];
    consultation.advises = [[NSString alloc] initWithString:[textAdvises string]];
    
    [self saveAction];
}

-(IBAction)showInvoicePanel:(id)sender{
    [NSApp beginSheet:invoicePanel modalForWindow:parent modalDelegate:self didEndSelector:nil contextInfo:nil];
}

-(IBAction)closeInvoicePanel:(id)sender{
    [NSApp endSheet:invoicePanel];
    [invoicePanel orderOut:sender];
}

@end

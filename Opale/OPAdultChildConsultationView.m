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

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)loadConsultation:(OPConsultation *)nConsultation{
    
    consultation = nConsultation;
    
    [consultationDate setDateValue:consultation.date];
    
    [OPView initTextView:textMotives withString:consultation.motives];
    [OPView initTextView:textTests withString:consultation.tests];
    [OPView initTextView:textTreatments withString:consultation.treatments];
    [OPView initTextView:textAdvises withString:consultation.advises];
    
    [invoicePanel setConsultation:consultation];
    [[invoicePanel payer] setStringValue:[NSString stringWithFormat:@"%@ %@", consultation.patient.firstName, consultation.patient.lastName]];
}

#pragma mark - Actions

-(void)applyModifications{
    consultation.date = [consultationDate dateValue];
    consultation.motives = [[NSString alloc] initWithString:[textMotives string]];
    consultation.tests = [[NSString alloc] initWithString:[textTests string]];
    consultation.treatments = [[NSString alloc] initWithString:[textTreatments string]];
    consultation.advises = [[NSString alloc] initWithString:[textAdvises string]];
}

-(IBAction)saveConsultation:(id)sender{
    [self applyModifications];
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

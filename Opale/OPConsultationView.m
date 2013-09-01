//
//  OPAdultChildConsultationView.m
//  Opale
//
//  Created by Camille Maurice on 28/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPMainWindow.h"
#import "OPInvoicePanel.h"
#import "OPConsultationView.h"
#import "OPPatient.h"
#import "OPConsultation.h"
#import "OPInvoice.h"

@implementation OPConsultationView

@synthesize modified, invoicePanel, consultation, consultationDate, textTests, textTreatments, textAdvises, textMotives, invoiceFlag;

-(void)awakeFromNib{
    [super awakeFromNib];
    
    modified = NO;
    
    [textMotives setDelegate:self];
    [textTests setDelegate:self];
    [textTreatments setDelegate:self];
    [textAdvises setDelegate:self];
}

-(void)loadConsultation:(OPConsultation *)nConsultation{
    
    consultation = nConsultation;
    
    modified = NO;
    
    [consultationDate setDateValue:consultation.date];
    
    [OPView initTextView:textMotives withString:consultation.motives];
    [OPView initTextView:textTests withString:consultation.tests];
    [OPView initTextView:textTreatments withString:consultation.treatments];
    [OPView initTextView:textAdvises withString:consultation.advises];
    
    [invoicePanel setConsultation:consultation];
    [[invoicePanel payer] setStringValue:[NSString stringWithFormat:@"%@ %@", consultation.patient.firstName, consultation.patient.lastName]];
    
    [self refreshInvoiceFlag];
}

#pragma mark - Actions
-(void)textDidChange:(NSNotification *)notification{
    modified = YES;
}

-(void)applyModifications{
    consultation.date = [consultationDate dateValue];
    consultation.motives = [[NSString alloc] initWithString:[textMotives string]];
    consultation.tests = [[NSString alloc] initWithString:[textTests string]];
    consultation.treatments = [[NSString alloc] initWithString:[textTreatments string]];
    consultation.advises = [[NSString alloc] initWithString:[textAdvises string]];
}

-(IBAction)saveConsultation:(id)sender{
    modified = NO;
    [self applyModifications];
    [self saveAction];
}

-(BOOL)quitView{
    if(modified){
        NSAlert *alert = [NSAlert alertWithMessageText:@"Sauvegarder ?" defaultButton:@"Oui" alternateButton:@"Non" otherButton:nil informativeTextWithFormat:@"La consultation a été modifiée. Sauvegarder ?"];
        [alert setAlertStyle:NSCriticalAlertStyle];
        
        if([alert runModal] == NSAlertDefaultReturn){
            [self saveConsultation:self];
        }
    }
    
    return YES;
}

-(IBAction)returnToPatient:(id)sender{
    if([self quitView]){
        [parent showPatientViewFor:consultation.patient];
    }
}

-(IBAction)showInvoicePanel:(id)sender{
    [NSApp beginSheet:invoicePanel modalForWindow:parent modalDelegate:self didEndSelector:nil contextInfo:nil];
}

-(IBAction)closeInvoicePanel:(id)sender{
    [NSApp endSheet:invoicePanel];
    [invoicePanel orderOut:sender];
    
    [self refreshInvoiceFlag];
}

-(void)refreshInvoiceFlag{
    if([consultation invoice]){
        [invoiceFlag setImage:[NSImage imageNamed:@"valid"]];
        [invoiceFlag setToolTip:@"Déjà facturé"];
    }
    else{
        [invoiceFlag setImage:[NSImage imageNamed:@"warning"]];
        [invoiceFlag setToolTip:@"Non facturé"];
    }
}

@end

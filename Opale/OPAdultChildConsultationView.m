//
//  OPAdultChildConsultationView.m
//  Opale
//
//  Created by Camille Maurice on 28/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPAdultChildConsultationView.h"
#import "OPPatient.h"
#import "OPConsultation.h"
#import "OPMainWindow.h"

@implementation OPAdultChildConsultationView

@synthesize consultation, consultationDate, textTests, textTreatments, textAdvises;


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
}

-(IBAction)saveConsultation:(id)sender{
    
    consultation.date = [consultationDate dateValue];
    consultation.tests = [[NSString alloc] initWithString:[textTests string]];
    consultation.treatments = [[NSString alloc] initWithString:[textTreatments string]];
    consultation.advises = [[NSString alloc] initWithString:[textAdvises string]];
    
    [self saveAction];
}

@end

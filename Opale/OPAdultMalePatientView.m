//
//  OPAdultMalePatientView.m
//  Opale
//
//  Created by Camille Maurice on 25/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPAdultMalePatientView.h"

#import "OPPatient.h"
#import "OPConsultation.h"
#import "OPMainWindow.h"
#import "OPAppDelegate.h"

@implementation OPAdultMalePatientView

@synthesize cellAgeGeneral, cellAgeHealth, cellJob, cellFamilyStatus, cellExtraActivity, cellChildren;

-(void)loadPatient:(OPPatient*)patientToLoad{
    [super loadPatient:patientToLoad];
    
    //General tab : additionals
    [OPView initFormCell:cellJob withString:patient.job];
    [OPView initFormCell:cellFamilyStatus withString:patient.familyStatus];
    [OPView initFormCell:cellExtraActivity withString:patient.extraActivity];
    [OPView initFormCell:cellChildren withString:patient.children];
    
    [self updateAgeFields];
}

-(void)updateAgeFields{
    NSDate* today = [NSDate date];
    
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:patient.birthday  toDate:today  options:0];
    
    
    NSString* ageString = [[NSString alloc] initWithFormat:@"%li ans, %li mois", breakdownInfo.year, breakdownInfo.month];
    
    [cellAgeGeneral setStringValue:ageString];
    [cellAgeHealth setStringValue:ageString];
}

-(void)applyModifications{
    [super applyModifications];
    
    patient.job = [[NSString alloc] initWithString:[cellJob stringValue]];
    patient.familyStatus = [[NSString alloc] initWithString:[cellFamilyStatus stringValue]];
    patient.extraActivity = [[NSString alloc] initWithString:[cellExtraActivity stringValue]];
    patient.children = [[NSString alloc] initWithString:[cellChildren stringValue]];
}

@end

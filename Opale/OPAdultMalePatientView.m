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

@synthesize cellAge, cellJob, cellFamilyStatus, cellExtraActivity, cellChildren, cellLaterality, cellAftercare, cellRiskFactor;

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self addEditableObject:cellJob];
    [self addEditableObject:cellFamilyStatus];
    [self addEditableObject:cellExtraActivity];
    [self addEditableObject:cellChildren];
    [self addEditableObject:cellLaterality];
    [self addEditableObject:cellAftercare];
    [self addEditableObject:cellRiskFactor];
}

-(void)loadPatient:(OPPatient*)patientToLoad{
    [super loadPatient:patientToLoad];
    
    //General tab : additionals
    [OPView initFormCell:cellJob withString:patient.job];
    [OPView initFormCell:cellFamilyStatus withString:patient.familyStatus];
    [OPView initFormCell:cellExtraActivity withString:patient.extraActivity];
    [OPView initFormCell:cellChildren withString:patient.children];
    [OPView initFormCell:cellAftercare withString:patient.afterCare];
    [OPView initFormCell:cellLaterality withString:patient.laterality];
    [OPView initFormCell:cellRiskFactor withString:patient.riskFactor];
    
    [self updateAge:self];
}

-(IBAction)updateAge:(id)sender{
    NSDate* today = [NSDate date];
    
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:patient.birthday  toDate:today  options:0];
    
    
    NSString* ageString = [[NSString alloc] initWithFormat:@"%li ans, %li mois", breakdownInfo.year, breakdownInfo.month];
    
    [cellAge setStringValue:ageString];
}

-(void)applyModifications{
    [super applyModifications];
    
    patient.job = [[NSString alloc] initWithString:[cellJob stringValue]];
    patient.familyStatus = [[NSString alloc] initWithString:[cellFamilyStatus stringValue]];
    patient.extraActivity = [[NSString alloc] initWithString:[cellExtraActivity stringValue]];
    patient.children = [[NSString alloc] initWithString:[cellChildren stringValue]];
    patient.afterCare = [[NSString alloc] initWithString:[cellAftercare stringValue]];
    patient.laterality = [[NSString alloc] initWithString:[cellLaterality stringValue]];
    patient.riskFactor = [[NSString alloc] initWithString:[cellRiskFactor stringValue]];
}

@end

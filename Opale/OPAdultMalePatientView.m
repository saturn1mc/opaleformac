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

@synthesize cellAgeGeneral, cellAgeHealth;

-(void)loadPatient:(OPPatient*)patientToLoad{
    [super loadPatient:patientToLoad];
    
    NSDate* today = [NSDate date];
    
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:patient.birthday  toDate:today  options:0];

    
    NSString* ageString = [[NSString alloc] initWithFormat:@"%li ans, %li mois", breakdownInfo.year, breakdownInfo.month];
    
    [cellAgeGeneral setStringValue:ageString];
    [cellAgeHealth setStringValue:ageString];
}

@end

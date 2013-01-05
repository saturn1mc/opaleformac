//
//  OPBabyPatientView.m
//  Opale
//
//  Created by Camille on 26/10/12.
//
//

#import "OPBabyPatientView.h"
#import "OPPatient.h"
#import "OPHeightGraphView.h"
#import "OPWeightGraphView.h"
#import "OPHCGraphView.h"

@implementation OPBabyPatientView

@synthesize cellCorrectedAge, termWeeks, termDays, cellBirthPlace, cellBirthWeight, cellBirtHeight, cellBirtHeadCircumference, cellParity, cellFatherJob, cellMotherJob, cellCareMode, cellAfterCare,pregnancyAndBirthSphere, feedingAndStoolSphere, sleepSphere, otherSphere, heightGraphView, weightGraphView, hcGraphView;

-(void)loadPatient:(OPPatient *)patientToLoad{
    [super loadPatient:patientToLoad];
    
    //General tab : Additionals
    [OPView initTextField:termWeeks withString:[patient.termWeeks stringValue]];
    [OPView initTextField:termDays withString:[patient.termDays stringValue]];
    [OPView initFormCell:cellBirthPlace withString:patient.birthPlace];
    [OPView initFormCell:cellBirthWeight withString:[patient.birthWeight stringValue]];
    [OPView initFormCell:cellBirtHeight withString:[patient.birthHeight stringValue]];
    [OPView initFormCell:cellBirtHeadCircumference withString:[patient.birthHC stringValue]];
    [OPView initFormCell:cellParity withString:patient.parity];
    [OPView initFormCell:cellFatherJob withString:patient.fatherJob];
    [OPView initFormCell:cellMotherJob withString:patient.motherJob];
    [OPView initFormCell:cellCareMode withString:patient.careMode];
    [OPView initFormCell:cellAfterCare withString:patient.afterCare];
    
    //Spheres tab : Additionals
    [OPView initTextView:pregnancyAndBirthSphere withString:patient.pregnancyAndBirthSphere];
    [OPView initTextView:feedingAndStoolSphere withString:patient.feedingAndStoolSphere];
    [OPView initTextView:sleepSphere withString:patient.sleepSphere];
    [OPView initTextView:otherSphere withString:patient.otherSphere];
    
    [self updateCorrectedAge:self];
    
    weightGraphView.patient = patient;
    heightGraphView.patient = patient;
    hcGraphView.patient = patient;
    
    [self updateGraphs:self];
}

-(IBAction)updateCorrectedAge:(id)sender{
    NSDate* today = [NSDate date];
    
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSWeekCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:patient.birthday  toDate:today  options:0];
    
    long correction = 0;
    long ageInDays = (breakdownInfo.week * 7) + breakdownInfo.day;
    long termInDays = ([[termWeeks stringValue ] integerValue] * 7) + [[termDays stringValue] integerValue];
    
    if(termInDays > 0){
        long theoriticalTerm = 41 * 7;
        correction = MAX(0, theoriticalTerm - termInDays);
        ageInDays -= correction;
    }
    
    NSString* ageString = [[NSString alloc] initWithFormat:@"%li sem, %li jours", (ageInDays/7), (ageInDays%7)];
    
    [cellCorrectedAge setStringValue:ageString];
}


-(IBAction)updateGraphs:(id)sender{
    [weightGraphView.graph reloadData];
    [heightGraphView.graph reloadData];
    [hcGraphView.graph reloadData];
}

-(void)applyModifications{
    [super applyModifications];
    
    patient.termWeeks = [[NSNumber alloc] initWithInt:[[termWeeks stringValue] integerValue]];
    patient.termDays = [[NSNumber alloc] initWithInt:[[termDays stringValue] integerValue]];
    patient.birthPlace = [[NSString alloc] initWithString:[cellBirthPlace stringValue]];
    patient.birthWeight = [[NSNumber alloc] initWithInt:[[cellBirthWeight stringValue] integerValue]];
    patient.birthHeight = [[NSNumber alloc] initWithInt:[[cellBirtHeight stringValue] integerValue]];
    patient.birthHC = [[NSNumber alloc] initWithInt:[[cellBirtHeadCircumference stringValue] integerValue]];
    patient.parity = [[NSString alloc] initWithString:[cellParity stringValue]];
    patient.fatherJob = [[NSString alloc] initWithString:[cellFatherJob stringValue]];
    patient.motherJob = [[NSString alloc] initWithString:[cellMotherJob stringValue]];
    patient.careMode = [[NSString alloc] initWithString:[cellCareMode stringValue]];
    patient.afterCare = [[NSString alloc] initWithString:[cellAfterCare stringValue]];
    patient.pregnancyAndBirthSphere = [[NSString alloc] initWithString:[pregnancyAndBirthSphere string]];
    patient.feedingAndStoolSphere = [[NSString alloc] initWithString:[feedingAndStoolSphere string]];
    patient.sleepSphere = [[NSString alloc] initWithString:[sleepSphere string]];
    patient.otherSphere = [[NSString alloc] initWithString:[otherSphere string]];
}

@end

//
//  OPChildPatientView.m
//  Opale
//
//  Created by Camille on 02/09/13.
//
//

#import "OPChildPatientView.h"
#import "OPPatient.h"

@implementation OPChildPatientView

@synthesize cellAge, cellParity, cellExtraActivity, cellLaterality, cellAftercare, cellRiskFactor, cellHeight, cellWeight;

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self addEditableObject:cellParity];
    [self addEditableObject:cellExtraActivity];
    [self addEditableObject:cellLaterality];
    [self addEditableObject:cellAftercare];
    [self addEditableObject:cellRiskFactor];
    [self addEditableObject:cellHeight];
    [self addEditableObject:cellWeight];
}

-(void)loadPatient:(OPPatient*)patientToLoad{
    [super loadPatient:patientToLoad];
    
    //General tab : additionals
    [OPView initFormCell:cellParity withString:patient.parity];
    [OPView initFormCell:cellExtraActivity withString:patient.extraActivity];
    [OPView initFormCell:cellAftercare withString:patient.afterCare];
    [OPView initFormCell:cellLaterality withString:patient.laterality];
    [OPView initFormCell:cellRiskFactor withString:patient.riskFactor];
    [OPView initFormCell:cellHeight withString:[patient.height stringValue]];
    [OPView initFormCell:cellWeight withString:[patient.weight stringValue]];
    
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
    
    patient.parity = [[NSString alloc] initWithString:[cellParity stringValue]];
    patient.extraActivity = [[NSString alloc] initWithString:[cellExtraActivity stringValue]];
    patient.afterCare = [[NSString alloc] initWithString:[cellAftercare stringValue]];
    patient.laterality = [[NSString alloc] initWithString:[cellLaterality stringValue]];
    patient.riskFactor = [[NSString alloc] initWithString:[cellRiskFactor stringValue]];
    patient.height = [NSNumber numberWithInteger:[cellHeight integerValue]];
    patient.weight = [NSNumber numberWithInteger:[cellWeight integerValue]];
}

@end

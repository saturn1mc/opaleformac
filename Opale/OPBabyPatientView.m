//
//  OPBabyPatientView.m
//  Opale
//
//  Created by Camille on 26/10/12.
//
//

#import "OPMainWindow.h"
#import "OPBabyPatientView.h"
#import "OPPatient.h"
#import "OPHeightGraphView.h"
#import "OPWeightGraphView.h"
#import "OPHCGraphView.h"
#import "OPPatient.h"
#import "OPMeasure.h"

@implementation OPBabyPatientView

@synthesize cellCorrectedAge, termWeeks, termDays, cellBirthPlace, cellBirthWeight, cellBirtHeight, cellBirtHeadCircumference, cellParity, cellFatherJob, cellMotherJob, cellCareMode, cellAfterCare,pregnancyAndBirthSphere, feedingAndStoolSphere, sleepSphere, otherSphere, measuresTable, colMeasureDate, colHeight, colWeight, colCP, heightGraphView, weightGraphView, hcGraphView;

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self addEditableObject:termWeeks];
    [self addEditableObject:termDays];
    [self addEditableObject:cellBirthPlace];
    [self addEditableObject:urinarySphere];
    [self addEditableObject:cellBirthWeight];
    [self addEditableObject:cellBirtHeight];
    [self addEditableObject:cellBirtHeadCircumference];
    [self addEditableObject:cellParity];
    [self addEditableObject:cellFatherJob];
    [self addEditableObject:cellMotherJob];
    [self addEditableObject:cellCareMode];
    [self addEditableObject:cellAfterCare];
    
    sortedMeasures = [[NSMutableArray alloc] init];
}

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
    
    [self sortMeasures];
    [heightGraphView loadPatient:patient];
    [weightGraphView loadPatient:patient];
    [hcGraphView loadPatient:patient];
    
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
    [weightGraphView update];
    [heightGraphView update];
    [hcGraphView update];
}

-(IBAction)addRow:(id)sender{
    OPMeasure* nMeasure = [NSEntityDescription insertNewObjectForEntityForName:@"Measure" inManagedObjectContext:[self managedObjectContext]];
    
    nMeasure.patient = patient;
    nMeasure.date = [NSDate date];
    nMeasure.height = 0;
    nMeasure.weight = 0;
    nMeasure.cranianPerimeter = 0;
    
    [self saveAction];
    [self sortMeasures];
}

-(IBAction)removeRow:(id)sender{
    //TODO
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

#pragma mark - Tables management

-(void)sortMeasures{
    NSArray* measures = [patient.measures allObjects];
    
    sortedMeasures = [measures sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        OPMeasure* measure1 = (OPMeasure*) obj1;
        OPMeasure* measure2 = (OPMeasure*) obj2;
        
        return [measure1.date compare:measure2.date];
    }];
    
    [measuresTable reloadData];
    [self updateGraphs:self];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger count = [super numberOfRowsInTableView:tableView];
    
    if(tableView == measuresTable){
        if (sortedMeasures){
            count = [sortedMeasures count];
        }
    }
    
    return count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSString* value = [super tableView:tableView objectValueForTableColumn:tableColumn row:row];
    
    if(tableView == measuresTable){
        
        OPMeasure* measure = (OPMeasure*) [sortedMeasures objectAtIndex:row];
        
        if(tableColumn == colMeasureDate){
            return measure.date;
        }
        else if (tableColumn == colHeight){
            return measure.height;
        }
        else if (tableColumn == colWeight){
            return measure.weight;
        }
        else if (tableColumn == colCP){
            return measure.cranianPerimeter;
        }
    }
    
    return value;
}

-(void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{    
    if(tableView == measuresTable){
        modified = YES;
        OPMeasure* measure = (OPMeasure*) [sortedMeasures objectAtIndex:row];
        
        if(tableColumn == colMeasureDate){
            measure.date = (NSDate*)object;
        }
        else if (tableColumn == colHeight){
            measure.height = [NSNumber numberWithFloat:[object floatValue]];
        }
        else if (tableColumn == colWeight){
            measure.weight = [NSNumber numberWithFloat:[object floatValue]];
        }
        else if (tableColumn == colCP){
            measure.cranianPerimeter = [NSNumber numberWithFloat:[object floatValue]];
        }
        
        [self saveAction];
        [self sortMeasures];
    }
}

@end

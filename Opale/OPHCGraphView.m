//
//  OPWeightGraphView.m
//  Opale
//
//  Created by Camille on 26/10/12.
//
//

#import "OPHCGraphView.h"
#import "OPPatient.h"
#import "OPConsultation.h"

@implementation OPHCGraphView

-(void)awakeFromNib{
    [super awakeFromNib];
    title = @"Périmètre crânien";
    [self loadReferenceData:@"avg_hc"];
}

-(NSNumber*)birthNumberForPlot:(CPTPlot*)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    switch(fieldEnum){
        case CPTScatterPlotFieldX:
        {
            return [NSDecimalNumber zero];
        }
        case CPTScatterPlotFieldY:
        {
            if(patient.birthHC){
                return [NSDecimalNumber numberWithInteger:[patient.birthHC integerValue]];
            }
            else{
                return [NSDecimalNumber zero];
            }
        }
            
        default:
            return [NSDecimalNumber zero];
    }
}

-(NSNumber*)patientNumberForPlot:(CPTPlot*)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    
    OPConsultation* consultation = (OPConsultation*)[sortedConsultations objectAtIndex:index - 1];
    
    switch(fieldEnum){
        case CPTScatterPlotFieldX:
        {
            NSCalendar *sysCalendar = [NSCalendar currentCalendar];
            unsigned int unitFlags = NSDayCalendarUnit;
            
            NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:patient.birthday  toDate:consultation.date options:0];
            
            return [NSDecimalNumber numberWithDouble:((double)breakdownInfo.day / 30.0)];
        }
        case CPTScatterPlotFieldY:
        {
            if(consultation.headCircumference){
                return [NSDecimalNumber numberWithInteger:[consultation.headCircumference integerValue]];
            }
            else{
                return [NSDecimalNumber zero];
            }
        }
            
        default:
            return [NSDecimalNumber zero];
    }
    
}

@end
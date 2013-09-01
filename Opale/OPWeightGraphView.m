//
//  OPWeightGraphView.m
//  Opale
//
//  Created by Camille on 26/10/12.
//
//

#import "OPWeightGraphView.h"
#import "OPPatient.h"
#import "OPMeasure.h"

@implementation OPWeightGraphView

-(void)awakeFromNib{
    [super awakeFromNib];
    title = @"Poids";
    [self loadReferenceData:@"avg_weight"];
}

-(void)initIncrements{
    majorIncrement = 1000;
    minorIncrement = 500;
}

-(NSNumber*)birthNumberForPlot:(CPTPlot*)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    switch(fieldEnum){
        case CPTScatterPlotFieldX:
        {
            return [NSDecimalNumber zero];
        }
        case CPTScatterPlotFieldY:
        {
            if(patient.birthWeight){
                return [NSDecimalNumber numberWithFloat:[patient.birthWeight floatValue]];
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
    
    OPMeasure* measure = (OPMeasure*)[sortedMeasures objectAtIndex:index - 1];
    
    switch(fieldEnum){
        case CPTScatterPlotFieldX:
        {
            NSCalendar *sysCalendar = [NSCalendar currentCalendar];
            unsigned int unitFlags = NSDayCalendarUnit;
            
            NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:patient.birthday  toDate:measure.date options:0];
            
            return [NSDecimalNumber numberWithDouble:((double)breakdownInfo.day / 30.0)];
        }
        case CPTScatterPlotFieldY:
        {
            if(measure.weight){
                return measure.weight;
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

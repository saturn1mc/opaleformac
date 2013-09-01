//
//  OPWeightGraphView.m
//  Opale
//
//  Created by Camille on 26/10/12.
//
//

#import "OPHCGraphView.h"
#import "OPPatient.h"
#import "OPMeasure.h"

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
                return [NSDecimalNumber numberWithFloat:[patient.birthHC floatValue]];
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
            if(measure.cranianPerimeter){
                return measure.cranianPerimeter;
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
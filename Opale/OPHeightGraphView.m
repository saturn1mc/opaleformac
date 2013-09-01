//
//  OPHeightGraphView.m
//  Opale
//
//  Created by Camille on 06/10/12.
//
//

#import "OPHeightGraphView.h"
#import "OPPatient.h"
#import "OPMeasure.h"

@implementation OPHeightGraphView

- (void)awakeFromNib{
    [super awakeFromNib];
    title = @"Taille";
    [self loadReferenceData:@"avg_height"];
}

-(NSNumber*)birthNumberForPlot:(CPTPlot*)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    switch(fieldEnum){
        case CPTScatterPlotFieldX:
        {
            return [NSDecimalNumber zero];
        }
        case CPTScatterPlotFieldY:
        {
            if(patient.birthHeight){
                return [NSDecimalNumber numberWithFloat:[patient.birthHeight floatValue]];
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
            if(measure.height){
                return [NSDecimalNumber numberWithFloat:[measure.height floatValue]];
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

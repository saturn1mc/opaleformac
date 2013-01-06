//
//  OPHeightGraphView.m
//  Opale
//
//  Created by Camille on 06/10/12.
//
//

#import "OPHeightGraphView.h"
#import "OPPatient.h"
#import "OPConsultation.h"

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
                return [NSDecimalNumber numberWithInteger:[patient.birthHeight integerValue]];
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
            if(consultation.height){
                return [NSDecimalNumber numberWithInteger:[consultation.height integerValue]];
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

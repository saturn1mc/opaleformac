//
//  OPWeightGraphView.m
//  Opale
//
//  Created by Camille on 26/10/12.
//
//

#import "OPHCGraphView.h"

@implementation OPHCGraphView

-(void)awakeFromNib{
    [super awakeFromNib];
    title = @"Périmètre crânien";
    [self loadReferenceData:@"avg_hc"];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    
    if([plot.identifier isEqual:patientPlotId]){
        if(fieldEnum == CPTScatterPlotFieldX){
            return [NSDecimalNumber numberWithFloat:0];
        }
        else{
            return [NSDecimalNumber numberWithFloat:0];
        }
        
    }
    else{ //Reference plots
        switch(fieldEnum){
            case CPTScatterPlotFieldX:
            {
                NSMutableDictionary* data = [plotData objectAtIndex:index];
                NSString* strValue = [data objectForKey:[plotNames objectAtIndex:0]];
                
                if(strValue){
                    return [NSDecimalNumber numberWithFloat:[strValue floatValue]];
                }
                
                break;
            }
                
            case CPTScatterPlotFieldY:
            {
                NSMutableDictionary* data = [plotData objectAtIndex:index];
                NSString* strValue = [data objectForKey:plot.identifier];
                
                if(strValue){
                    return [NSDecimalNumber numberWithFloat:[strValue floatValue]];
                }
                
                break;
            }
                
            default:
                return [NSDecimalNumber zero];
                break;
        }
    }
    
    return [NSDecimalNumber zero];
}

@end
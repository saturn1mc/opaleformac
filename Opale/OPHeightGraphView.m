//
//  OPHeightGraphView.m
//  Opale
//
//  Created by Camille on 06/10/12.
//
//

#import "OPHeightGraphView.h"

@implementation OPHeightGraphView

- (void)awakeFromNib{
    [super awakeFromNib];
    title = @"Taille";
    [self loadReferenceData:@"avg_height"];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    
    if([plot.identifier isEqual:patientPlotId]){
        
        //TODO use patient history
        
        if(fieldEnum == CPTScatterPlotFieldX){
            switch (index){
               return [NSDecimalNumber numberWithFloat:0];            }
        }
        else{
            switch (index){
                return [NSDecimalNumber numberWithFloat:0];
            }
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

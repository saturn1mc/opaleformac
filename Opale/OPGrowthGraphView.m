//
//  OPGrowthGraphView.m
//  Opale
//
//  Created by Camille on 06/10/12.
//
//

#import "OPGrowthGraphView.h"
#import "OPView.h"
#import "CorePlot/CorePlot.h"

@implementation OPGrowthGraphView
@synthesize title, sourceFile, plotNames, plotData, graph, minX, minY, maxX, maxY;

- (void)awakeFromNib{
    sourceFile = @"avg_height";
    graph	 = nil;
	plotNames = nil;
    plotData = nil;
    title = nil;
    
    minX = 0;
    minY = 0;
    maxX = 0;
    maxY = 0;
    
    [self loadDataFromSource];
    [self initGraph];
}


-(void)loadDataFromSource
{
    
    plotData = [[NSMutableArray alloc] init];
    
    NSString* fileStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:sourceFile ofType:@"csv"] encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* lines = [fileStr componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    int i = 0;
    
    for (NSString* line in lines) {
        NSArray* columns = [line componentsSeparatedByString:@";"];
        
        if(i == 0){ //Header line
            plotNames = [[NSMutableArray alloc] init];
            
            for(NSString* cell in columns){
                [plotNames addObject:cell];
            }
        }
        else{
            NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
            int j = 0;
            
            for(NSString* cell in columns){
                [data setObject:cell forKey:[plotNames objectAtIndex:j]];
                
                if (j == 0){ //x axis value
                    
                    maxX = MAX(maxX, [cell floatValue]);
                }
                else{ //other values
                    maxY = MAX(maxY, [cell floatValue]);
                }
                
                j++;
            }
            
            [plotData addObject:data];
        }
        
        i++;
    }
}

-(void)initGraph
{
    graph = [[CPTXYGraph alloc] initWithFrame:self.frame];
    self.hostedGraph = graph;
    
    CPTXYPlotSpace* plotSpace = (CPTXYPlotSpace*) graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(minX) length:CPTDecimalFromFloat(maxX)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(minY) length:CPTDecimalFromFloat(maxY)];
    
    CPTScatterPlot* plot = [[CPTScatterPlot alloc] init];
    [plot setDataSource:self];
    
    [graph addPlot:plot];
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
	return plotData.count;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{    
    NSMutableDictionary* data = [plotData objectAtIndex:index];
    
    if(fieldEnum == CPTScatterPlotFieldX){
        NSString* strValue = (NSString*)[data valueForKey:[plotNames objectAtIndex:0]];
        NSLog(@"Point %li : x=%f", index, [strValue floatValue]);
        return [NSNumber numberWithFloat:[strValue floatValue]];
    }else{
        NSString* strValue = (NSString*)[data valueForKey:[plotNames objectAtIndex:1]];
        NSLog(@"Point %li : y=%f", index, [strValue floatValue]);
        return [NSNumber numberWithFloat:[strValue floatValue]];
    }
}


@end

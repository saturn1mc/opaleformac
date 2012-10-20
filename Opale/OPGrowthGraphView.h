//
//  OPGrowthGraphView.h
//  Opale
//
//  Created by Camille on 06/10/12.
//
//

#import "CorePlot/CorePlot.h"

@interface OPGrowthGraphView : CPTGraphHostingView <CPTPlotSpaceDelegate, CPTPlotDataSource>{
    NSString* title;

    NSString* sourceFile;
    NSMutableArray* plotNames;
	NSMutableArray* plotData;
    
    CPTXYGraph* graph;
    
    float minX;
    float minY;
    float maxX;
    float maxY;
}

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* sourceFile;
@property (nonatomic, retain) NSMutableArray* plotNames;
@property (nonatomic, retain) NSArray* plotData;
@property (nonatomic, retain) CPTXYGraph* graph;
@property (nonatomic) float minX;
@property (nonatomic) float minY;
@property (nonatomic) float maxX;
@property (nonatomic) float maxY;


-(void)loadDataFromSource;
-(void)initGraph;
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot;
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index;

@end

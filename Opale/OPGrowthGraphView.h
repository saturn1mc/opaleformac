//
//  OPGraphTest.h
//  Opale
//
//  Created by Camille on 06/10/12.
//
//

#import "CorePlot/CorePlot.h"

@interface OPGrowthGraphView : CPTGraphHostingView <CPTPlotSpaceDelegate, CPTPlotDataSource>{
    NSString* title;
    CPTGraph *graph;
	NSArray *plotData;
}

-(void)generateData;
-(void)renderInLayer:(CPTGraphHostingView *)layerHostingView;
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot;
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index;

@end

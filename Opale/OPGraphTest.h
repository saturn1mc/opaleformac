//
//  OPGraphTest.h
//  Opale
//
//  Created by Camille on 06/10/12.
//
//

#import "OPView.h"
#import "CorePlot/CorePlot.h"

@interface OPGraphTest : OPView <CPTPlotSpaceDelegate, CPTPlotDataSource>{
    NSString* title;
    CPTGraph *graph;
	NSArray *plotData;
}

@end

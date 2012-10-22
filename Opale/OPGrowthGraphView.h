//
//  OPGrowthGraphView.h
//  Opale
//
//  Created by Camille on 06/10/12.
//
//

#import "CorePlot/CorePlot.h"

@class OPPatient;

@interface OPGrowthGraphView : CPTGraphHostingView <CPTPlotSpaceDelegate, CPTPlotDataSource>{
    OPPatient* patient;
    
    NSString* title;

    NSString* sourceFile;
    NSMutableArray* plotNames;
	NSMutableArray* plotData;
    NSMutableArray* plotColors;
    NSMutableArray* plotLineStyles;
    
    CPTXYGraph* graph;
    
    float xMin;
    float yMin;
    float xMax;
    float yMax;
}

@property (nonatomic, retain) OPPatient* patient;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* sourceFile;
@property (nonatomic, retain) NSMutableArray* plotNames;
@property (nonatomic, retain) NSMutableArray* plotData;
@property (nonatomic, retain) NSMutableArray* plotColors;
@property (nonatomic, retain) NSMutableArray* plotLineStyles;
@property (nonatomic, retain) CPTXYGraph* graph;
@property (nonatomic) float xMin;
@property (nonatomic) float yMin;
@property (nonatomic) float xMax;
@property (nonatomic) float yMax;


-(void)loadReferenceData;
-(void)initReferencePlots;
-(void)initPatientPlots;
-(void)initGraph;
-(void)initAxis;
-(void)initLegend;
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot;
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index;

@end

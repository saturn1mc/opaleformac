//
//  OPGraphView.h
//  Opale
//
//  Created by Camille on 05/01/13.
//
//

#import <CorePlot/CorePlot.h>

@class OPPatient;

@interface OPGraphView : CPTGraphHostingView <CPTPlotSpaceDelegate, CPTPlotDataSource>{
    OPPatient* patient;
    NSArray* sortedMeasures;
    CPTScatterPlot* patientPlot;
    
    NSString* title;
    
    NSMutableArray* plotNames;
	NSMutableArray* plotData;
    NSMutableArray* plotColors;
    NSMutableArray* plotLineStyles;
    
    CPTXYGraph* graph;
    
    float xMin;
    float yMin;
    float xMax;
    float yMax;
    
    NSString* patientPlotId;
    NSString* defaultFont;
    NSString* titleFont;
    NSInteger majorIncrement;
    NSInteger minorIncrement;
}

@property (nonatomic, retain) OPPatient* patient;
@property (nonatomic, retain) NSArray* sortedMeasures;
@property (nonatomic, retain) CPTScatterPlot* patientPlot;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSMutableArray* plotNames;
@property (nonatomic, retain) NSMutableArray* plotData;
@property (nonatomic, retain) NSMutableArray* plotColors;
@property (nonatomic, retain) NSMutableArray* plotLineStyles;
@property (nonatomic, retain) CPTXYGraph* graph;
@property (nonatomic) float xMin;
@property (nonatomic) float yMin;
@property (nonatomic) float xMax;
@property (nonatomic) float yMax;
@property (nonatomic, retain) NSString* patientPlotId;
@property (nonatomic, retain) NSString* defaultFont;
@property (nonatomic, retain) NSString* titleFont;
@property (nonatomic) NSInteger majorIncrement;
@property (nonatomic) NSInteger minorIncrement;

-(void)loadPatient:(OPPatient*)patientToLoad;
-(void)update;
-(void)sortMeasures;
-(void)loadReferenceData:(NSString*)sourceFile;
-(void)initIncrements;
-(void)initReferencePlots;
-(void)initPatientPlots;
-(void)initGraph;
-(void)initAxis;
-(void)initLegend;
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot;
-(NSNumber*)birthNumberForPlot:(CPTPlot*)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index;
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index;
-(NSNumber*)patientNumberForPlot:(CPTPlot*)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index;
-(NSNumber*)referenceNumberForPlot:(CPTPlot*)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index;

@end
//
//  OPWeightGraphView.m
//  Opale
//
//  Created by Camille on 26/10/12.
//
//

#import "OPWeightGraphView.h"
#import "OPView.h"
#import "CorePlot/CorePlot.h"
#import "OPPatient.h"

static const NSString* patientPlotId = @"Patient";
static NSString* defaultFont = @"Helvetica";
static NSString* titleFont = @"Helvetica-Bold";

@implementation OPWeightGraphView
@synthesize patient, title, sourceFile, plotNames, plotData, plotColors, plotLineStyles, graph, xMin, yMin, xMax, yMax;

- (void)awakeFromNib{
    title = nil;
    sourceFile = @"avg_weight";
    graph	 = nil;
	plotNames = nil;
    plotData = nil;
    
    plotColors = [NSMutableArray arrayWithObjects:[CPTColor purpleColor], [CPTColor blueColor], [CPTColor blueColor], [CPTColor purpleColor], nil];
    
    
    NSArray* plainPattern = [[NSArray alloc] init];
    
    NSArray* dashedPattern = [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:2],[NSDecimalNumber numberWithInt:3], nil];
    
    plotLineStyles = [NSMutableArray arrayWithObjects:plainPattern, dashedPattern, dashedPattern, plainPattern, nil];
    
    xMin = FLT_MAX;
    yMin = FLT_MAX;
    xMax = FLT_MIN;
    yMax = FLT_MIN;
    
    [self loadReferenceData];
    
    [self initGraph];
    [self initReferencePlots];
    [self initPatientPlots];
    [self initAxis];
    [self initLegend];
}


-(void)loadReferenceData{
    
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
                
                if (j == 0){ //Key value (x axis value)
                    xMin = MIN(xMin, [cell floatValue]);
                    xMax = MAX(xMax, [cell floatValue]);
                }
                else{ //Other values (y axis value)
                    yMin = MIN(yMin, [cell floatValue]);
                    yMax = MAX(yMax, [cell floatValue]);
                }
                
                j++;
            }
            
            [plotData addObject:data];
        }
        
        i++;
    }
}

-(void)initGraph{
    graph = [[CPTXYGraph alloc] initWithFrame:self.bounds];
    [graph applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];
    self.hostedGraph = graph;
    
    title = @"Poids";
    graph.title = title;
    
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor blackColor];
    titleStyle.fontName = titleFont;
    titleStyle.fontSize = 16.0f;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
    
    CPTXYPlotSpace* plotSpace = (CPTXYPlotSpace*) graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xMin) length:CPTDecimalFromFloat(xMax)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(yMax)];
}

-(void)initReferencePlots{
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    NSMutableArray* plots = [[NSMutableArray alloc] init];
    
    for(NSString* pName in plotNames){
        
        NSUInteger index = [plotNames indexOfObject:pName];
        
        if(index > 0){
            CPTScatterPlot *linePlot = [[CPTScatterPlot alloc] init];
            linePlot.identifier = pName;
            linePlot.cachePrecision = CPTPlotCachePrecisionDouble;
            linePlot.interpolation = CPTScatterPlotInterpolationLinear;
            
            linePlot.dataSource = self;
            linePlot.delegate = self;
            
            CPTMutableLineStyle *lineStyle = [linePlot.dataLineStyle mutableCopy];
            lineStyle.lineWidth = 1.5f;
            lineStyle.lineColor = [plotColors objectAtIndex:(index-1)];
            lineStyle.dashPattern = [plotLineStyles objectAtIndex:(index-1)];
            linePlot.dataLineStyle = lineStyle;
            
            [graph addPlot:linePlot toPlotSpace:plotSpace];
            [plots addObject:linePlot];
        }
    }
    
    [plotSpace scaleToFitPlots:plots];
    
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    plotSpace.xRange = xRange;
    
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    
    plotSpace.yRange = yRange;
}

-(void)initPatientPlots{
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    CPTScatterPlot *linePlot = [[CPTScatterPlot alloc] init];
    linePlot.identifier = patientPlotId; //TODO switch with patient name
    linePlot.cachePrecision = CPTPlotCachePrecisionDouble;
    linePlot.interpolation = CPTScatterPlotInterpolationLinear;
    
    linePlot.dataSource = self;
    linePlot.delegate = self;
    
    CPTMutableLineStyle *lineStyle = [linePlot.dataLineStyle mutableCopy];
    lineStyle.lineWidth = 2.0f;
    lineStyle.lineColor = [CPTColor redColor];
    linePlot.dataLineStyle = lineStyle;
    
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor redColor];
    
    CPTPlotSymbol *symbol = [CPTPlotSymbol trianglePlotSymbol];
    symbol.fill = [CPTFill fillWithColor:[CPTColor redColor]];
    symbol.lineStyle = symbolLineStyle;
    symbol.size = CGSizeMake(10.0f, 10.0f);
    linePlot.plotSymbol = symbol;
    
    [graph addPlot:linePlot toPlotSpace:plotSpace];
}

-(void)initAxis{
    //Line styles
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor blackColor];
    axisTitleStyle.fontName = titleFont;
    axisTitleStyle.fontSize = 12.0f;
    
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [CPTColor blackColor];
    
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor blackColor];
    axisTextStyle.fontName = defaultFont;
    axisTextStyle.fontSize = 9.0f;
    
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 3.0f;
    
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    gridLineStyle.lineColor = [CPTColor grayColor];
    gridLineStyle.lineWidth = 0.5f;
    gridLineStyle.dashPattern = [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:2],[NSDecimalNumber numberWithInt:3], nil];
    
    //X Axis
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) graph.axisSet;
    
    CPTXYAxis *x = axisSet.xAxis;
    x.title = @"Age en mois";
    x.titleTextStyle = axisTitleStyle;
    x.titleOffset = -25.0f;
    x.axisLineStyle = axisLineStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.labelTextStyle = axisTextStyle;
    x.majorTickLineStyle = tickLineStyle;
    x.minorTickLineStyle = tickLineStyle;
    x.majorTickLength = 4.0f;
    x.minorTickLength = 2.0f;
    x.tickDirection = CPTSignPositive;
    x.orthogonalCoordinateDecimal = CPTDecimalFromFloat(yMin);
    
    CGFloat xCount = [plotData count];
    NSMutableSet *xLabels = [NSMutableSet setWithCapacity:xCount];
    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:xCount];
    
    for (NSMutableDictionary* data  in plotData) {
        NSString* strValue = [data objectForKey:[plotNames objectAtIndex:0]];
        
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:strValue  textStyle:x.labelTextStyle];
        
        CGFloat location = [strValue floatValue];
        label.tickLocation = CPTDecimalFromCGFloat(location);
        label.offset = -15.0f;
        
        if (label) {
            [xLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }
    x.axisLabels = xLabels;
    x.majorTickLocations = xLocations;
    
    //Y Axis
    CPTXYAxis *y = axisSet.yAxis;
    y.title = @"Taille en cm";
    y.titleTextStyle = axisTitleStyle;
    y.titleOffset = -35.0f;
    y.axisLineStyle = axisLineStyle;
    
    y.majorGridLineStyle = gridLineStyle;
    y.minorGridLineStyle = gridLineStyle;
    
    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    y.labelTextStyle = axisTextStyle;
    y.labelOffset = 16.0f;
    y.majorTickLineStyle = tickLineStyle;
    y.minorTickLineStyle = tickLineStyle;
    y.majorTickLength = 4.0f;
    y.minorTickLength = 2.0f;
    y.tickDirection = CPTSignPositive;
    
    NSInteger majorIncrement = 1000;
    NSInteger minorIncrement = 500;
    
    NSMutableSet *yLabels = [NSMutableSet set];
    NSMutableSet *yMajorLocations = [NSMutableSet set];
    NSMutableSet *yMinorLocations = [NSMutableSet set];
    
    for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement) {
        NSUInteger mod = j % majorIncrement;
        if (mod == 0) {
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%li", j] textStyle:y.labelTextStyle];
            NSDecimal location = CPTDecimalFromInteger(j);
            label.tickLocation = location;
            label.offset = -y.majorTickLength - y.labelOffset;
            if (label) {
                [yLabels addObject:label];
            }
            [yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
        } else {
            [yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
        }
    }
    
    y.axisLabels = yLabels;
    y.majorTickLocations = yMajorLocations;
    y.minorTickLocations = yMinorLocations;
}

-(void)initLegend{
    
    CPTMutableTextStyle* legendTextStyle = [CPTMutableTextStyle textStyle];
    legendTextStyle.color = [CPTColor blackColor];
    legendTextStyle.fontName = defaultFont;
    legendTextStyle.fontSize = 8.0;
    
    CPTMutableLineStyle *legendLineStyle = [CPTMutableLineStyle lineStyle];
    legendLineStyle.lineWidth = 1.0f;
    legendLineStyle.lineColor = [CPTColor grayColor];
    
    
    graph.legend = [CPTLegend legendWithGraph:graph];
    graph.legend.textStyle = legendTextStyle;
    graph.legend.fill = [CPTFill fillWithColor:[CPTColor whiteColor]];
    graph.legend.borderLineStyle = legendLineStyle;
    graph.legend.cornerRadius = 5.0f;
    graph.legend.swatchSize = CGSizeMake(15.0f, 15.0f);
    graph.legendAnchor = CPTRectAnchorTopLeft;
    graph.legendDisplacement = CGPointMake(100.0f, -50.0f);
}

#pragma mark - Delegate methods
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index {
    static CPTMutableTextStyle* labelTextStyle = nil;
    
    if (!labelTextStyle) {
        labelTextStyle= [[CPTMutableTextStyle alloc] init];
        labelTextStyle.color = [CPTColor blackColor];
        labelTextStyle.fontName = defaultFont;
        labelTextStyle.fontSize = 10.0;
    }
    
    if([plot.identifier isEqual:patientPlotId]){
        //TODO
        return nil;
    }
    else{
        if(index == ([plotData count] - 1)){ //Labelling only last point
            return [[CPTTextLayer alloc] initWithText:(NSString*)plot.identifier style:labelTextStyle];
        }
        else{
            return nil;
        }
    }
}

#pragma mark - Data source methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    if([plot.identifier isEqual:patientPlotId]){
        //TODO count patient growth points
        return 0;
    }
    else{
        return plotData.count;
    }
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    
    if([plot.identifier isEqual:patientPlotId]){
        
        //TODO use patient history
        
        if(fieldEnum == CPTScatterPlotFieldX){
            switch (index){
                case 0:
                    return [NSDecimalNumber numberWithFloat:0];
                case 1:
                    return [NSDecimalNumber numberWithFloat:10];
                case 2:
                    return [NSDecimalNumber numberWithFloat:20];
                default:
                    return [NSDecimalNumber numberWithFloat:0];
            }
        }
        else{
            switch (index){
                case 0:
                    return [NSDecimalNumber numberWithFloat:48];
                case 1:
                    return [NSDecimalNumber numberWithFloat:75];
                case 2:
                    return [NSDecimalNumber numberWithFloat:80];
                default:
                    return [NSDecimalNumber numberWithFloat:0];
            }
        }
        
    }
    else{ //Reference plots
        if(fieldEnum == CPTScatterPlotFieldX){
            NSMutableDictionary* data = [plotData objectAtIndex:index];
            NSString* strValue = [data objectForKey:[plotNames objectAtIndex:0]];
            
            if(strValue){
                return [NSDecimalNumber numberWithFloat:[strValue floatValue]];
            }
        }
        else if(fieldEnum == CPTScatterPlotFieldY){
            NSMutableDictionary* data = [plotData objectAtIndex:index];
            NSString* strValue = [data objectForKey:plot.identifier];
            
            if(strValue){
                return [NSDecimalNumber numberWithFloat:[strValue floatValue]];
            }
        }
    }
    
    return [NSDecimalNumber zero];
}

@end
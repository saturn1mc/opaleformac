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
#import "OPPatient.h"

@implementation OPGrowthGraphView
@synthesize patient, title, sourceFile, plotNames, plotData, graph, xMin, yMin, xMax, yMax;

- (void)awakeFromNib{
    sourceFile = @"avg_height";
    graph	 = nil;
	plotNames = nil;
    plotData = nil;
    title = nil;
    
    xMin = FLT_MAX;
    yMin = FLT_MAX;
    xMax = FLT_MIN;
    yMax = FLT_MIN;
    
    [self loadReferenceData];
    
    [self initGraph];
    [self initReferencePlots];
    [self initPatientPlots];
    [self initAxis];
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
    
    title = @"Courbes de croissance";
    graph.title = title;
    
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica-Bold";
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
        if([plotNames indexOfObject:pName] > 0){
            CPTScatterPlot *linePlot = [[CPTScatterPlot alloc] init];
            linePlot.identifier = pName;
            linePlot.cachePrecision = CPTPlotCachePrecisionDouble;
            linePlot.interpolation = CPTScatterPlotInterpolationLinear;
            
            linePlot.dataSource = self;
            linePlot.delegate = self;
            
            CPTMutableLineStyle *lineStyle = [linePlot.dataLineStyle mutableCopy];
            lineStyle.lineWidth = 1.5;
            lineStyle.lineColor = [CPTColor redColor];
            linePlot.dataLineStyle = lineStyle;
            
            CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
            symbolLineStyle.lineColor = [CPTColor redColor];
            
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
    linePlot.identifier = @"Patient"; //TODO switch with patient name
    linePlot.cachePrecision = CPTPlotCachePrecisionDouble;
    linePlot.interpolation = CPTScatterPlotInterpolationLinear;
    
    linePlot.dataSource = self;
    linePlot.delegate = self;
    
    CPTMutableLineStyle *lineStyle = [linePlot.dataLineStyle mutableCopy];
    lineStyle.lineWidth = 2.0f;
    lineStyle.lineColor = [CPTColor greenColor];
    linePlot.dataLineStyle = lineStyle;
    
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor greenColor];
    
    CPTPlotSymbol *symbol = [CPTPlotSymbol trianglePlotSymbol];
    symbol.fill = [CPTFill fillWithColor:[CPTColor greenColor]];
    symbol.lineStyle = symbolLineStyle;
    symbol.size = CGSizeMake(10.0f, 10.0f);
    linePlot.plotSymbol = symbol;
    
    [graph addPlot:linePlot toPlotSpace:plotSpace];
}

-(void)initAxis{
    //Line styles
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor blackColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 12.0f;
    
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [CPTColor blackColor];
    
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor blackColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 9.0f;
    
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 3.0f;
    
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    gridLineStyle.lineColor = [CPTColor grayColor];
    gridLineStyle.lineWidth = 0.5f;
    
    //X Axis
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) graph.axisSet;
    
    CPTXYAxis *x = axisSet.xAxis;
    x.title = @"Age en mois";
    x.titleTextStyle = axisTitleStyle;
    x.titleOffset = -20.0f;
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
    
    NSInteger majorIncrement = 10;
    NSInteger minorIncrement = 2;
    
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

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    if([plot.identifier isEqual:@"Patient"]){
        //TODO count patient growth points
        return 3;
    }
    else{
        return plotData.count;
    }
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    
    if([plot.identifier isEqual:@"Patient"]){
        
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
                    return [NSDecimalNumber numberWithFloat:70];
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

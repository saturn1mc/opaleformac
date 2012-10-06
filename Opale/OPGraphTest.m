//
//  OPGraphTest.m
//  Opale
//
//  Created by Camille on 06/10/12.
//
//

#import "OPGraphTest.h"
#import "OPView.h"
#import "CorePlot/CorePlot.h"

static const NSTimeInterval oneDay = 24 * 60 * 60;

@implementation OPGraphTest

- (void)awakeFromNib{
		graph	 = nil;
		plotData = nil;
        title = @"Test title";
}

-(void)generateData
{
	if ( !plotData ) {
		NSMutableArray *newData = [NSMutableArray array];
		for ( NSUInteger i = 0; i < 8; i++ ) {
			NSTimeInterval x = oneDay * i;
			double rOpen	 = 3.0 * rand() / (double)RAND_MAX + 1.0;
			double rClose	 = (rand() / (double)RAND_MAX - 0.5) * 0.125 + rOpen;
			double rHigh	 = MAX( rOpen, MAX(rClose, (rand() / (double)RAND_MAX - 0.5) * 0.5 + rOpen) );
			double rLow		 = MIN( rOpen, MIN(rClose, (rand() / (double)RAND_MAX - 0.5) * 0.5 + rOpen) );
            
			[newData addObject:
			 [NSDictionary dictionaryWithObjectsAndKeys:
			  [NSDecimalNumber numberWithDouble:x], [NSNumber numberWithInt:CPTTradingRangePlotFieldX],
			  [NSDecimalNumber numberWithDouble:rOpen], [NSNumber numberWithInt:CPTTradingRangePlotFieldOpen],
			  [NSDecimalNumber numberWithDouble:rHigh], [NSNumber numberWithInt:CPTTradingRangePlotFieldHigh],
			  [NSDecimalNumber numberWithDouble:rLow], [NSNumber numberWithInt:CPTTradingRangePlotFieldLow],
			  [NSDecimalNumber numberWithDouble:rClose], [NSNumber numberWithInt:CPTTradingRangePlotFieldClose],
			  nil]];
		}
        
		plotData = newData;
	}
}

-(void)renderInLayer:(CPTGraphHostingView *)layerHostingView withTheme:(CPTTheme *)theme
{
	// If you make sure your dates are calculated at noon, you shouldn't have to
	// worry about daylight savings. If you use midnight, you will have to adjust
	// for daylight savings time.
	NSDate *refDate = [NSDate dateWithTimeIntervalSinceReferenceDate:oneDay / 2.0];

	CGRect bounds = NSRectToCGRect(layerHostingView.bounds);
    
	graph = [(CPTXYGraph *)[CPTXYGraph alloc] initWithFrame:bounds];
	layerHostingView.hostedGraph = graph;
    [graph applyTheme:[CPTTheme themeNamed:kCPTStocksTheme]];
    
	graph.title = title;
	CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
	textStyle.color				   = [CPTColor grayColor];
	textStyle.fontName			   = @"Helvetica-Bold";
	textStyle.fontSize			   = round(bounds.size.height / (CGFloat)20.0);
	graph.titleTextStyle		   = textStyle;
	graph.titleDisplacement		   = CGPointMake( 0.0f, round(bounds.size.height / (CGFloat)18.0) ); // Ensure that title displacement falls on an integral pixel
	graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    graph.title = title;
	textStyle = [CPTMutableTextStyle textStyle];
	textStyle.color				   = [CPTColor grayColor];
	textStyle.fontName			   = @"Helvetica-Bold";
	textStyle.fontSize			   = round(bounds.size.height / (CGFloat)20.0);
	graph.titleTextStyle		   = textStyle;
	graph.titleDisplacement		   = CGPointMake( 0.0f, round(bounds.size.height / (CGFloat)18.0) ); // Ensure that title displacement falls on an integral pixel
	graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
	CGFloat boundsPadding = round(bounds.size.width / (CGFloat)20.0); // Ensure that padding falls on an integral pixel
    
	graph.paddingLeft = boundsPadding;
    
	if ( graph.titleDisplacement.y > 0.0 ) {
		graph.paddingTop = graph.titleDisplacement.y * 2;
	}
	else {
		graph.paddingTop = boundsPadding;
	}
    
	graph.paddingRight	= boundsPadding;
	graph.paddingBottom = boundsPadding;
    
    boundsPadding = round(bounds.size.width / (CGFloat)20.0); // Ensure that padding falls on an integral pixel
    
	graph.paddingLeft = boundsPadding;
    
	if ( graph.titleDisplacement.y > 0.0 ) {
		graph.paddingTop = graph.titleDisplacement.y * 2;
	}
	else {
		graph.paddingTop = boundsPadding;
	}
    
	graph.paddingRight	= boundsPadding;
	graph.paddingBottom = boundsPadding;
    
	CPTMutableLineStyle *borderLineStyle = [CPTMutableLineStyle lineStyle];
	borderLineStyle.lineColor			= [CPTColor whiteColor];
	borderLineStyle.lineWidth			= 2.0f;
	graph.plotAreaFrame.borderLineStyle = borderLineStyle;
	graph.plotAreaFrame.paddingTop		= 10.0;
	graph.plotAreaFrame.paddingRight	= 10.0;
	graph.plotAreaFrame.paddingBottom	= 30.0;
	graph.plotAreaFrame.paddingLeft		= 35.0;
    
	// Axes
	CPTXYAxisSet *xyAxisSet = (id)graph.axisSet;
	CPTXYAxis *xAxis		= xyAxisSet.xAxis;
	xAxis.majorIntervalLength	= CPTDecimalFromDouble(oneDay);
	xAxis.minorTicksPerInterval = 0;
    
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateStyle = kCFDateFormatterShortStyle;
	CPTTimeFormatter *timeFormatter = [[CPTTimeFormatter alloc] initWithDateFormatter:dateFormatter];
	timeFormatter.referenceDate = refDate;
	xAxis.labelFormatter		= timeFormatter;
    
	CPTLineCap *lineCap = [[CPTLineCap alloc] init];
	lineCap.lineStyle	 = xAxis.axisLineStyle;
	lineCap.lineCapType	 = CPTLineCapTypeSweptArrow;
	lineCap.size		 = CGSizeMake(12.0, 15.0);
	lineCap.fill		 = [CPTFill fillWithColor:xAxis.axisLineStyle.lineColor];
	xAxis.axisLineCapMax = lineCap;
    
	CPTXYAxis *yAxis = xyAxisSet.yAxis;
	yAxis.orthogonalCoordinateDecimal = CPTDecimalFromDouble(-0.5 * oneDay);
    
	// Line plot with gradient fill
	CPTScatterPlot *dataSourceLinePlot = [(CPTScatterPlot *)[CPTScatterPlot alloc] initWithFrame:graph.bounds];
	dataSourceLinePlot.identifier	 = @"Data Source Plot";
	dataSourceLinePlot.title		 = @"Close Values";
	dataSourceLinePlot.dataLineStyle = nil;
	dataSourceLinePlot.dataSource	 = self;
	[graph addPlot:dataSourceLinePlot];
    
	CPTColor *areaColor		  = [CPTColor colorWithComponentRed:1.0 green:1.0 blue:1.0 alpha:0.6];
	CPTGradient *areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
	areaGradient.angle = -90.0f;
	CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient];
	dataSourceLinePlot.areaFill		 = areaGradientFill;
	dataSourceLinePlot.areaBaseValue = CPTDecimalFromDouble(0.0);
    
	areaColor						  = [CPTColor colorWithComponentRed:0.0 green:1.0 blue:0.0 alpha:0.6];
	areaGradient					  = [CPTGradient gradientWithBeginningColor:[CPTColor clearColor] endingColor:areaColor];
	areaGradient.angle				  = -90.0f;
	areaGradientFill				  = [CPTFill fillWithGradient:areaGradient];
	dataSourceLinePlot.areaFill2	  = areaGradientFill;
	dataSourceLinePlot.areaBaseValue2 = CPTDecimalFromDouble(5.0);
    
	CPTMutableShadow *whiteShadow = [CPTMutableShadow shadow];
	whiteShadow.shadowOffset	 = CGSizeMake(2.0, -2.0);
	whiteShadow.shadowBlurRadius = 4.0;
	whiteShadow.shadowColor		 = [CPTColor whiteColor];
    
	// OHLC plot
	CPTMutableLineStyle *whiteLineStyle = [CPTMutableLineStyle lineStyle];
	whiteLineStyle.lineColor = [CPTColor whiteColor];
	whiteLineStyle.lineWidth = 2.0;
	CPTTradingRangePlot *ohlcPlot = [(CPTTradingRangePlot *)[CPTTradingRangePlot alloc] initWithFrame:graph.bounds];
	ohlcPlot.identifier = @"OHLC";
	ohlcPlot.lineStyle	= whiteLineStyle;
	CPTMutableTextStyle *whiteTextStyle = [CPTMutableTextStyle textStyle];
	whiteTextStyle.color	 = [CPTColor whiteColor];
	whiteTextStyle.fontSize	 = 12.0;
	ohlcPlot.labelTextStyle	 = whiteTextStyle;
	ohlcPlot.labelOffset	 = 0.0;
	ohlcPlot.barCornerRadius = 3.0;
	ohlcPlot.barWidth		 = 15.0;
	ohlcPlot.increaseFill	 = [CPTFill fillWithColor:[CPTColor greenColor]];
	ohlcPlot.decreaseFill	 = [CPTFill fillWithColor:[CPTColor redColor]];
	ohlcPlot.dataSource		 = self;
	ohlcPlot.plotStyle		 = CPTTradingRangePlotStyleCandleStick;
	ohlcPlot.shadow			 = whiteShadow;
	ohlcPlot.labelShadow	 = whiteShadow;
	[graph addPlot:ohlcPlot];
    
	// Add legend
	graph.legend					= [CPTLegend legendWithGraph:graph];
	graph.legend.textStyle			= xAxis.titleTextStyle;
	graph.legend.fill				= graph.plotAreaFrame.fill;
	graph.legend.borderLineStyle	= graph.plotAreaFrame.borderLineStyle;
	graph.legend.cornerRadius		= 5.0;
	graph.legend.swatchSize			= CGSizeMake(25.0, 25.0);
	graph.legend.swatchCornerRadius = 5.0;
	graph.legendAnchor				= CPTRectAnchorBottom;
	graph.legendDisplacement		= CGPointMake(0.0, 90.0);
    
	// Set plot ranges
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
	plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(-0.5 * oneDay) length:CPTDecimalFromDouble(oneDay * plotData.count)];
	plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromInteger(0) length:CPTDecimalFromInteger(4)];
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
	return plotData.count;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
	NSDecimalNumber *num = [NSDecimalNumber zero];
    
	if ( [plot.identifier isEqual:@"Data Source Plot"] ) {
		switch ( fieldEnum ) {
			case CPTScatterPlotFieldX:
				num = [[plotData objectAtIndex:index] objectForKey:[NSNumber numberWithUnsignedInt:CPTTradingRangePlotFieldX]];
				break;
                
			case CPTScatterPlotFieldY:
				num = [[plotData objectAtIndex:index] objectForKey:[NSNumber numberWithUnsignedInt:CPTTradingRangePlotFieldClose]];
				break;
                
			default:
				break;
		}
	}
	else {
		num = [[plotData objectAtIndex:index] objectForKey:[NSNumber numberWithUnsignedInteger:fieldEnum]];
	}
	return num;
}


@end

//
//  OPDayView.m
//  Opale
//
//  Created by Camille on 17/01/13.
//
//

#import "OPDayView.h"

@implementation OPDayView

static int startHour = 8;
static CGFloat headerHeight = 25;
static int availableSlots = 52;

@synthesize header;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        header = [[NSTextField alloc] initWithFrame:NSMakeRect(0, frame.size.height - headerHeight, frame.size.width, headerHeight)];
        
        [header setEditable:NO];
        [header setAlignment:NSCenterTextAlignment];
        [header setTextColor:[NSColor whiteColor]];
        [header setBackgroundColor:[NSColor headerColor]];
        
        [self addSubview:header];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGFloat slotsHeight = (dirtyRect.size.height - headerHeight) / (CGFloat)availableSlots;
    CGFloat y = dirtyRect.size.height - headerHeight - slotsHeight;
    
    for(int i = 0; i < availableSlots; i++){
        NSRect slot = NSMakeRect(0, y, dirtyRect.size.width, slotsHeight);
        
        if(i%2){
            [[NSColor colorWithSRGBRed:0.3 green:0.6 blue:1.0 alpha:0.05] set];
        }
        else{
            [[NSColor whiteColor] set];
        }
        
        if(!(i%4)){
            NSTextField* hourField = [[NSTextField alloc] initWithFrame:slot];
            [hourField setStringValue:[NSString stringWithFormat:@"%i:00", startHour + (i/4)]];
            [hourField setFont:[NSFont fontWithName:@"Helvetica" size:7.0]];
            [hourField setTextColor:[NSColor colorWithSRGBRed:0.3 green:0.6 blue:1.0 alpha:1.0]];
            [hourField setEditable:NO];
            [hourField setDrawsBackground:NO];
            [hourField setBordered:NO];
            
            [self addSubview:hourField];
        }
        
        NSRectFill(slot);
        
        y-= slotsHeight;
    }
    
    y = dirtyRect.size.height - headerHeight;
    
    
    for(int i = 0; i < availableSlots; i++){
        NSBezierPath* line = [NSBezierPath bezierPath];
        
        if(i%4){
            CGFloat dash[2];
            dash[0] = 4.0;
            dash[1] = 6.0;
            [line setLineDash:dash count:2 phase:0];
            [line setLineWidth:1.0];
        }
        else{
            [line setLineWidth:2.0];
        }
        
        [[NSColor colorWithSRGBRed:0.3 green:0.6 blue:1.0 alpha:1.0] set];
        [line moveToPoint:NSMakePoint(0, y)];
        [line lineToPoint:NSMakePoint(dirtyRect.size.width, y)];
        [line stroke];
        y-= slotsHeight;
    }

    [[NSColor whiteColor] set];
    [NSBezierPath setDefaultLineWidth:1.5];
    [NSBezierPath strokeRect:dirtyRect];
}

@end

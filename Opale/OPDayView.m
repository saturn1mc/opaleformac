//
//  OPDayView.m
//  Opale
//
//  Created by Camille on 17/01/13.
//
//

#import "OPDayView.h"
#import "OPAppointment.h"
#import "OPAppointmentView.h"

@implementation OPDayView

static int startHour = 8;
static int slotsDurationInMinutes = 15;
static CGFloat headerHeight = 25;
static int availableSlots = 52;

@dynamic currentDay, appointmentViews;
@synthesize dateFormatter, header;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //Header initialization
        header = [[NSTextField alloc] initWithFrame:NSMakeRect(0, frame.size.height - headerHeight, frame.size.width, headerHeight)];
        
        [header setEditable:NO];
        [header setAlignment:NSCenterTextAlignment];
        [header setTextColor:[NSColor whiteColor]];
        [header setBackgroundColor:[NSColor headerColor]];
        
        [self addSubview:header];
        
        //Date formatter initialization
        NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"EEEE dd"];
        [dateFormatter setLocale:frLocale];
        
        //Hour labels initialization
        CGFloat slotsHeight = (frame.size.height - headerHeight) / (CGFloat)availableSlots;
        CGFloat y = frame.size.height - headerHeight - slotsHeight;
        int hourFieldsCount = availableSlots / 4;
        
        for(int i = 0; i < hourFieldsCount; i++){
            NSRect slot = NSMakeRect(0, y, frame.size.width, slotsHeight);
            
            NSTextField* hourField = [[NSTextField alloc] initWithFrame:slot];
            [hourField setStringValue:[NSString stringWithFormat:@"%i:00", startHour + i]];
            [hourField setFont:[NSFont fontWithName:@"Helvetica" size:7.0]];
            [hourField setTextColor:[NSColor colorWithSRGBRed:0.3 green:0.6 blue:1.0 alpha:1.0]];
            [hourField setEditable:NO];
            [hourField setDrawsBackground:NO];
            [hourField setBordered:NO];
            
            [self addSubview:hourField];
            
            y-= (slotsHeight * 4);
        }
        
        appointmentViews = [[NSMutableArray alloc] init];
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

-(void)setCurrentDay:(NSDate *)nDay{
    currentDay = nDay;
    
    NSString* dateStr = [dateFormatter stringFromDate:currentDay];
    [header setStringValue:[[[dateStr substringToIndex:1] uppercaseString] stringByAppendingString:[dateStr substringFromIndex:1]]];
}

-(NSDate*)getCurrentDay{
    return currentDay;
}

-(void)setAppointmentViews:(NSMutableArray *)nAppointments{
    //Removing previous views
    for(OPAppointmentView* appView in appointmentViews){
        [appView removeFromSuperview];
    }
    
    [appointmentViews removeAllObjects];
    
    //Adding new views
    CGFloat slotsHeight = (self.frame.size.height - headerHeight) / (CGFloat)availableSlots;
    
    for(OPAppointment* appointment in nAppointments){
        
        NSDateComponents* startComponents = [[NSCalendar currentCalendar] components: NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[appointment start]];
        
        NSDateComponents* endComponents = [[NSCalendar currentCalendar] components: NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[appointment end]];
        
        
        NSInteger startHourInMinutes = ((startComponents.hour - startHour) * 60) + startComponents.minute;
        NSInteger endHourInMinutes = ((endComponents.hour - startHour) * 60) + endComponents.minute;
        
        NSInteger startSlotIndex = (startHourInMinutes - (startHour * 60)) / slotsDurationInMinutes;
        NSInteger durationSlots = endHourInMinutes - startHourInMinutes;
        
        CGFloat y = (self.frame.size.height - headerHeight) - (startSlotIndex * slotsHeight);
        CGFloat h = durationSlots * slotsHeight;
        
        OPAppointmentView* nAppView = [[OPAppointmentView alloc] initWithFrame:NSMakeRect(0, y, self.frame.size.width, h)];
        [nAppView setAppointment:appointment];
        
        [self addSubview:nAppView];
        [appointmentViews addObject:nAppView];
    }
}

-(NSMutableArray*)getAppointmentViews{
    return appointmentViews;
}

@end
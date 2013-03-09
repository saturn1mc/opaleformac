//
//  OPAppointmentView.m
//  Opale
//
//  Created by Camille on 16/01/13.
//
//

#import "OPAppointmentView.h"
#import "OPCalendarView.h"
#import "OPPatient.h"
#import "OPDayView.h"
#import "OPAppointment.h"

@implementation OPAppointmentView

static const int textHeight = 15;

@dynamic appointment;
@synthesize hovered, dayView, patientField, hoursField, dateFormatter;

-(id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    
    if(self){
        [self addTrackingArea:[[NSTrackingArea alloc] initWithRect:[self bounds]
                                                           options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveInKeyWindow)
                                                             owner:self userInfo:nil]];
        
        patientField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0,frameRect.size.width, textHeight)];
        [patientField setEditable:NO];
        [patientField setBordered:NO];
        [patientField setDrawsBackground:NO];
        [patientField setFont:[NSFont fontWithName:@"Helvetica-Bold" size:10.0]];
        [patientField setTextColor:[NSColor whiteColor]];
        
        hoursField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, textHeight,frameRect.size.width, textHeight)];
        [hoursField setEditable:NO];
        [hoursField setBordered:NO];
        [hoursField setDrawsBackground:NO];
        [hoursField setFont:[NSFont fontWithName:@"Helvetica" size:8.0]];
        [hoursField setTextColor:[NSColor whiteColor]];
        
        [self addSubview:patientField];
        [self addSubview:hoursField];
        
        NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"HH:mm"];
        [dateFormatter setLocale:frLocale];
    }
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect{
    [[NSColor colorWithSRGBRed:0 green:0 blue:1.0 alpha:0.8] set];
    NSRectFill(dirtyRect);
}

-(BOOL)acceptsFirstResponder {
    return YES;
}

-(BOOL)acceptsFirstMouse:(NSEvent *)theEvent{
    return YES;
}

-(void)setAppointment:(OPAppointment *)nAppointment{
    appointment = nAppointment;
    
    if(appointment.patient){
        [patientField setStringValue:[NSString stringWithFormat:@"%@ %@", appointment.patient.lastName, appointment.patient.firstName]];
    }
    
    if(appointment.start && appointment.end){
        [hoursField setStringValue:[NSString stringWithFormat:@"%@ - %@", [dateFormatter stringFromDate:appointment.start], [dateFormatter stringFromDate:appointment.end]]];
    }
}

-(OPAppointment*)getAppointment{
    return appointment;
}

-(void)mouseDown:(NSEvent *)theEvent{
    if(hovered){
        [[dayView calendarView] editAppointment:self];
    }
    else{
        [super mouseDown:theEvent];
    }
}

-(void)mouseEntered:(NSEvent *)theEvent{
    hovered = YES;
    
    [[[dayView calendarView] createAppointmentButton] setHidden:YES];
    [dayView setInhibited:YES];
    
    CALayer* highlightLayer = [CALayer layer];
    [highlightLayer setBackgroundColor:CGColorCreateGenericRGB(1.0, 0.0, 0.0, 0.8)];
    [self setWantsLayer:YES];
    [[self animator] setLayer:highlightLayer];
}

-(void)mouseExited:(NSEvent *)theEvent{
    hovered = NO;
    
    [dayView setInhibited:NO];
    
    CALayer* highlightLayer = [CALayer layer];
    [highlightLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 1.0, 0.8)];
    [self setWantsLayer:YES];
    [[self animator] setLayer:highlightLayer];
}

@end

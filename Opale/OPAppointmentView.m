//
//  OPAppointmentView.m
//  Opale
//
//  Created by Camille on 16/01/13.
//
//

#import "OPAppointmentView.h"
#import "OPAppointment.h"
#import "OPPatient.h"

@implementation OPAppointmentView

@dynamic appointment;
@synthesize patientField, hoursField, dateFormatter;

-(id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    
    if(self){
        patientField = [[NSTextField alloc] init];
        [patientField setEditable:NO];
        [patientField setBordered:NO];
        [patientField setDrawsBackground:NO];
        [patientField setFont:[NSFont fontWithName:@"Helvetica-Bold" size:10.0]];
        
        hoursField = [[NSTextField alloc] init];
        [hoursField setEditable:NO];
        [hoursField setBordered:NO];
        [hoursField setDrawsBackground:NO];
        [hoursField setFont:[NSFont fontWithName:@"Helvetica" size:8.0]];
        
        [self addSubview:patientField];
        [self addSubview:hoursField];
        
        NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"hh:mm"];
        [dateFormatter setLocale:frLocale];
    }
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect{
    [[NSColor blueColor] set];
    NSRectFill(dirtyRect);
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

@end

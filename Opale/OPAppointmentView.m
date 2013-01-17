//
//  OPAppointmentView.m
//  Opale
//
//  Created by Camille on 16/01/13.
//
//

#import "OPAppointmentView.h"
#import "OPAppointment.h"

@implementation OPAppointmentView

@dynamic appointment;
@synthesize button, patientField, hoursField;

-(id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    
    return self;
}

-(void)setAppointment:(OPAppointment *)nAppointment{
    appointment = nAppointment;
    
    //TODO load labels
}

-(OPAppointment*)getAppointment{
    return appointment;
}

@end

//
//  OPAppointmentView.h
//  Opale
//
//  Created by Camille on 16/01/13.
//
//

#import "OPView.h"

@class OPAppointment;

@interface OPAppointmentView : OPView{
    OPAppointment* appointment;
    
    IBOutlet NSButton* button;
    IBOutlet NSTextField* patientField;
    IBOutlet NSTextField* hoursField;
}

@property (nonatomic, retain) OPAppointment* appointment;

@property (nonatomic, retain) IBOutlet NSButton* button;
@property (nonatomic, retain) IBOutlet NSTextField* patientField;
@property (nonatomic, retain) IBOutlet NSTextField* hoursField;

-(void)setAppointment:(OPAppointment *)nAppointment;
-(OPAppointment*)getAppointment;

@end

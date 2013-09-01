//
//  OPAppointmentView.h
//  Opale
//
//  Created by Camille on 16/01/13.
//
//

#import "OPView.h"

@class OPAppointment, OPDayView, OPTrackingArea;

@interface OPAppointmentView : OPView{
    BOOL hovered;
    
    OPDayView* dayView;
    OPAppointment* appointment;
    OPTrackingArea* correspondingArea;
    
    NSTextField* patientField;
    NSTextField* hoursField;
    NSDateFormatter* dateFormatter;
}

@property (atomic) BOOL hovered;

@property (nonatomic, retain) OPDayView* dayView;
@property (nonatomic, retain) OPAppointment* appointment;
@property (nonatomic, retain) OPTrackingArea* correspondingArea;

@property (nonatomic, retain) NSTextField* patientField;
@property (nonatomic, retain) NSTextField* hoursField;
@property (nonatomic, retain) NSDateFormatter* dateFormatter;

-(void)setAppointment:(OPAppointment *)nAppointment;
-(OPAppointment*)getAppointment;

@end

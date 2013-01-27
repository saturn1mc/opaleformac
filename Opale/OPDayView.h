//
//  OPDayView.h
//  Opale
//
//  Created by Camille on 17/01/13.
//
//

#import "OPView.h"

@class OPCalendarView, OPAppointmentView, OPTrackingArea;

@interface OPDayView : OPView{
    OPCalendarView* calendarView;
    
    NSDate* currentDay;
    NSDateFormatter* dateFormatter;
    NSTextField* header;
    
    NSMutableArray* appointmentViews;
    
    NSButton* createAppointmentButton;
    OPTrackingArea* activeTracker;
    NSMutableArray* enteredTrackers;
}

@property (nonatomic, retain) OPCalendarView* calendarView;

@property (nonatomic, retain) NSDate* currentDay;
@property (nonatomic, retain) NSDateFormatter* dateFormatter;
@property (nonatomic, retain) NSTextField* header;
@property (nonatomic, retain) NSMutableArray* appointmentViews;

@property (nonatomic, retain) NSButton* createAppointmentButton;
@property (nonatomic, retain) OPTrackingArea* activeTracker;
@property (nonatomic, retain) NSMutableArray* enteredTrackers;

-(void)setCurrentDay:(NSDate *)nDay;
-(NSDate*)getCurrentDay;

-(void)setAppointmentViews:(NSMutableArray *)nAppointments;
-(NSMutableArray*)getAppointmentViews;

-(void)editAppointment:(OPAppointmentView*)appView;
-(IBAction)createAppointment:(id)sender;

@end

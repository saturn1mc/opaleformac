//
//  OPCalendarView.h
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPView.h"

@class OPWeekAppointmentsView, OPDayAppointmentsView, OPEditAppointmentView;

@interface OPCalendarView : OPView{
    IBOutlet NSDatePicker* datePicker;
    IBOutlet NSButton* todayButton;
    IBOutlet NSTextField* monthYearLabel;
    IBOutlet NSSegmentedControl* viewSwitcher;
    
    IBOutlet NSView* calendarView;
    OPView* currentView;
    NSMutableArray* currentWeek;
    IBOutlet OPWeekAppointmentsView* weekView;
    NSDate* currentDay;
    IBOutlet OPDayAppointmentsView* dayView;
    
    IBOutlet OPEditAppointmentView* editAppointmentView;
}

@property (nonatomic, retain) IBOutlet NSDatePicker* datePicker;
@property (nonatomic, retain) IBOutlet NSButton* todayButton;
@property (nonatomic, retain) IBOutlet NSTextField* monthYearLabel;
@property (nonatomic, retain) IBOutlet NSSegmentedControl* viewSwitcher;
@property (nonatomic, retain) IBOutlet NSView* calendarView;
@property (nonatomic, retain) OPView* currentView;
@property (nonatomic, retain) NSMutableArray* currentWeek;
@property (nonatomic, retain) IBOutlet OPWeekAppointmentsView* weekView;
@property (nonatomic, retain) NSDate* currentDay;
@property (nonatomic, retain) IBOutlet OPDayAppointmentsView* dayView;
@property (nonatomic, retain) IBOutlet OPEditAppointmentView* editAppointmentView;

-(void)refreshView;
-(IBAction)returnToday:(id)sender;
-(void)reloadCurrentDayWith:(NSDateComponents*) newComponents;
-(void)reloadCurrentWeekWith:(NSDateComponents*) newComponents;
-(IBAction)changeSelection:(id)sender;
-(IBAction)showDayView:(id)sender;
-(IBAction)showWeekView:(id)sender;
-(void)changeView:(OPView*)newView;

@end

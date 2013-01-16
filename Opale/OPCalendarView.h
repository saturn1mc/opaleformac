//
//  OPCalendarView.h
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPView.h"

@class OPWeekView, OPDayView;

@interface OPCalendarView : OPView{
    
    IBOutlet NSDatePicker* datePicker;
    IBOutlet NSView* calendarView;
    OPView* currentView;
    NSMutableArray* currentWeek;
    IBOutlet OPWeekView* weekView;
    NSDate* currentDay;
    IBOutlet OPDayView* dayView;
}

@property (nonatomic, retain) IBOutlet NSDatePicker* datePicker;
@property (nonatomic, retain) IBOutlet NSView* calendarView;
@property (nonatomic, retain) OPView* currentView;
@property (nonatomic, retain) NSMutableArray* currentWeek;
@property (nonatomic, retain) IBOutlet OPWeekView* weekView;
@property (nonatomic, retain) NSDate* currentDay;
@property (nonatomic, retain) IBOutlet OPDayView* dayView;

-(IBAction)changeSelection:(id)sender;
-(IBAction)showDayView:(id)sender;
-(IBAction)showWeekView:(id)sender;
-(void)changeView:(OPView*)newView;

@end

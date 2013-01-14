//
//  OPCalendarView.m
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPCalendarView.h"

#import <OmniAppKit/OACalendarView.h>

@implementation OPCalendarView

@synthesize calendarView;

-(void)awakeFromNib{
    [calendarView setCalendar:[NSCalendar currentCalendar]];
    [calendarView setShowsDaysForOtherMonths:YES];
    [calendarView setVisibleMonth:[NSDate date]];
    [calendarView setSelectionType:OACalendarViewSelectByDay];
    [calendarView updateHighlightMask];
    [calendarView setFirstDayOfWeek:1];
}

-(void)viewWillDraw{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate *today = [NSDate date];
    NSDateComponents *dateComponents =  [calendar components:NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    today = [calendar dateFromComponents:dateComponents];

    [calendarView setSelectedDay:today];
}

@end

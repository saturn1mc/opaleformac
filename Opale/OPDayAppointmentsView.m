//
//  OPDayAppointmentsView.m
//  Opale
//
//  Created by Camille on 15/01/13.
//
//

#import "OPDayAppointmentsView.h"
#import "OPCalendarView.h"
#import "OPDayView.h"

@implementation OPDayAppointmentsView

@dynamic currentDay;
@synthesize calendarView, dayView, contentView, scrollView;

-(void)awakeFromNib{
    [self prepareView];
}

-(void)prepareView{
    CGFloat top = contentView.frame.size.height;
    CGFloat y = 0;
    CGFloat x = 0;
    
    dayView = [[OPDayView alloc] initWithFrame:NSMakeRect(x, y, contentView.frame.size.width, contentView.frame.size.height)];
    [dayView setParent:[self parent]];
    [dayView setCalendarView:calendarView];
    
    [contentView addSubview:dayView];
    
    [[scrollView documentView] scrollPoint:NSMakePoint(0, top)];
}

-(void)setCurrentDay:(NSDate *)nDay{
    currentDay = nDay;
    [dayView setCurrentDay:nDay];
}

-(NSDate*)getCurrentDay{
    return currentDay;
}

-(void)loadAppointments:(NSMutableArray*)dayAppointments{
    [dayView setAppointmentViews:dayAppointments];
}

@end

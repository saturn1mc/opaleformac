//
//  OPCalendarView.m
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPCalendarView.h"
#import "OPWeekAppointmentsView.h"
#import "OPDayAppointmentsView.h"

@implementation OPCalendarView

@synthesize datePicker, todayButton, viewSwitcher, calendarView, currentView, currentWeek, weekView, currentDay, dayView;

-(void)awakeFromNib{
    currentDay = 0;
    currentWeek = [[NSMutableArray alloc] init];
    transition = [CATransition animation];
    [datePicker setDateValue:[NSDate date]];
    [self changeSelection:self];
    [calendarView setAnimations:[NSDictionary dictionaryWithObject:transition forKey:@"subviews"]];
    [calendarView setWantsLayer:YES];
}

-(void)resetView{
    [datePicker setDateValue:[NSDate date]];
    [self changeView:weekView];
}

-(IBAction)changeSelection:(id)sender{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* oldComponents = [calendar components: NSWeekdayCalendarUnit | NSWeekOfYearCalendarUnit | NSYearCalendarUnit fromDate:currentDay];
    
    NSDateComponents* newComponents = [calendar components: NSWeekdayCalendarUnit | NSWeekOfYearCalendarUnit | NSYearCalendarUnit fromDate:[datePicker dateValue]];
    
    if((newComponents.year != oldComponents.year) || (newComponents.weekOfYear != oldComponents.weekOfYear)){
        
        [currentWeek removeAllObjects];
        
        for(int i = 0; i < 6; i++){
            NSDateComponents* components = [[NSDateComponents alloc] init];
            [components setWeekday:(i+2)];
            [components setWeekOfYear:[newComponents weekOfYear]];
            [components setYear:[newComponents year]];
            
            [currentWeek addObject:[calendar dateFromComponents:components]];
        }
        
        [weekView setCurrentWeek:currentWeek];
    }
    
    currentDay = [calendar dateFromComponents:newComponents];
}

-(IBAction)showDayView:(id)sender{
    [transition setType:kCATransitionPush];
    [transition setSubtype:kCATransitionFromRight];
    [dayView setCurrentDay:currentDay];
    [self changeView:dayView];
}

-(IBAction)showWeekView:(id)sender{
    [transition setType:kCATransitionPush];
    [transition setSubtype:kCATransitionFromLeft];
    [weekView setCurrentWeek:currentWeek];
    [self changeView:weekView];
}

-(void)changeView:(OPView *)newView{
    if(currentView != newView){
        [newView resetView];
        
        if(!currentView){
            [calendarView.animator addSubview:newView];
        }
        else{
            [calendarView.animator replaceSubview:currentView with:newView];
        }
        
        currentView = newView;
    }
}

@end

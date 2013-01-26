//
//  OPCalendarView.m
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPCalendarView.h"
#import "OPMainWindow.h"
#import "OPAppDelegate.h"
#import "OPWeekAppointmentsView.h"
#import "OPDayAppointmentsView.h"
#import "OPEditAppointmentView.h"

@implementation OPCalendarView

static int displayedDays = 6;

@synthesize datePicker, todayButton, monthYearLabel, viewSwitcher, calendarView, currentView, currentWeek, weekView, currentDay, dayView, editAppointmentView;

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
    [self refreshView];
}

-(void)refreshView{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* newComponents = [calendar components: NSWeekdayCalendarUnit | NSWeekOfYearCalendarUnit | NSYearCalendarUnit fromDate:[datePicker dateValue]];
    
    [self reloadCurrentWeekWith:newComponents];
    [self reloadCurrentDayWith:newComponents];
    
    [self changeView:weekView];
}

-(IBAction)returnToday:(id)sender{
    [datePicker setDateValue:[NSDate date]];
    [self changeSelection:self];
}

-(NSMutableArray*)getAppointmentsFor:(NSDate*)day{
    
    //Preparing request
    NSMutableArray* foundAppointments = [[NSMutableArray alloc] init];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* dayStartComponents = [calendar components: NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:day];
    [dayStartComponents setHour:0];
    [dayStartComponents setMinute:0];
    
    NSDateComponents* dayEndComponents = [calendar components: NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:day];
    [dayEndComponents setHour:23];
    [dayEndComponents setMinute:59];
    
    //Execute request
    OPAppDelegate* appDelegate = (OPAppDelegate*)parent.delegate;
    NSManagedObjectContext *moc = [appDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Appointment" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(start >= %@) AND (start <= %@)", [calendar dateFromComponents:dayStartComponents], [calendar dateFromComponents:dayEndComponents]]];
    
    NSError *error = nil;
    NSArray* results = [moc executeFetchRequest:request error:&error];
    if(results){
        [foundAppointments addObjectsFromArray:results];
    }
    
    return foundAppointments;
}

-(void)reloadCurrentDayWith:(NSDateComponents*) newComponents{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    currentDay = [calendar dateFromComponents:newComponents];
    [dayView loadAppointments:[self getAppointmentsFor:currentDay]];
    [dayView setCurrentDay:currentDay];
}

-(void)reloadCurrentWeekWith:(NSDateComponents*) newComponents{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSMutableArray* appListArray = [[NSMutableArray alloc] init];
    [currentWeek removeAllObjects];
    
    //Loading days in week and appointments
    for(int i = 0; i < displayedDays; i++){
        NSDateComponents* components = [[NSDateComponents alloc] init];
        [components setWeekday:(i+2)];
        [components setWeekOfYear:[newComponents weekOfYear]];
        [components setYear:[newComponents year]];
        
        NSDate* dayDate = [calendar dateFromComponents:components];
        [appListArray addObject:[self getAppointmentsFor:dayDate]];
        
        [currentWeek addObject:dayDate];
    }
    
    for(int i = 0; i < displayedDays; i++){
        [weekView loadAppointments:[appListArray objectAtIndex:i] forDay:i];
    }
    
    [weekView setCurrentWeek:currentWeek];
}

-(IBAction)changeSelection:(id)sender{
    if(sender == viewSwitcher){
        switch (viewSwitcher.selectedSegment){
            case 0:{ //Day
                [self showDayView:self];
                break;
            }
            
            case 1:{ //Week
                [self showWeekView:self];
                break;
            }
        }
    }
    else{
        NSCalendar* calendar = [NSCalendar currentCalendar];
        
        NSDateComponents* oldComponents = [calendar components: NSWeekdayCalendarUnit | NSWeekOfYearCalendarUnit | NSYearCalendarUnit fromDate:currentDay];
        
        NSDateComponents* newComponents = [calendar components: NSWeekdayCalendarUnit | NSWeekOfYearCalendarUnit | NSYearCalendarUnit fromDate:[datePicker dateValue]];
        
        if((newComponents.year != oldComponents.year) || (newComponents.weekOfYear != oldComponents.weekOfYear)){
            
            [self reloadCurrentWeekWith:newComponents];
        }
        
        [self reloadCurrentDayWith:newComponents];
        
        NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:frLocale];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterFullStyle];
        [dateFormatter setDateFormat:@"MMMM yyyy"];
        
        NSString* dateStr = [dateFormatter stringFromDate:[datePicker dateValue]];
        [monthYearLabel setStringValue:[[[dateStr substringToIndex:1] uppercaseString] stringByAppendingString:[dateStr substringFromIndex:1]]];
    }
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

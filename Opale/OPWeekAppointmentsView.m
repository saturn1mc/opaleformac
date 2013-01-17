
//
//  OPWeekAppointmentsView.m
//  Opale
//
//  Created by Camille on 15/01/13.
//
//

#import "OPWeekAppointmentsView.h"
#import "OPAppointmentView.h"

@implementation OPWeekAppointmentsView

@dynamic currentWeek;
@synthesize scrollView, contentView;

-(void)awakeFromNib{
    NSTextField* test = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 1400, 100, 100)];
    [test setStringValue:@"TEST"];
    [contentView addSubview:test];
    
    NSTextField* test2 = [[NSTextField alloc] initWithFrame:NSMakeRect(200, 1400, 100, 100)];
    [test2 setStringValue:@"TEST2"];
    [contentView addSubview:test2];
    
    NSTextField* test3 = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
    [test3 setStringValue:@"TEST3"];
    [contentView addSubview:test3];
    
    [[scrollView documentView] scrollPoint:NSMakePoint(0, 1500)];
}

-(void)setCurrentWeek:(NSMutableArray *)nWeek{
    currentWeek = nWeek;
    
    NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:frLocale];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"EEEE dd"];
    
//    [[colMonday headerCell] setTitle:[dateFormatter stringFromDate:[currentWeek objectAtIndex:0]]];
//    [[colTuesday headerCell] setTitle:[dateFormatter stringFromDate:[currentWeek objectAtIndex:1]]];
//    [[colWednesday headerCell] setTitle:[dateFormatter stringFromDate:[currentWeek objectAtIndex:2]]];
//    [[colThursday headerCell] setTitle:[dateFormatter stringFromDate:[currentWeek objectAtIndex:3]]];
//    [[colFriday headerCell] setTitle:[dateFormatter stringFromDate:[currentWeek objectAtIndex:4]]];
//    [[colSaturday headerCell] setTitle:[dateFormatter stringFromDate:[currentWeek objectAtIndex:5]]];
    
}

-(NSMutableArray*)getCurrentWeek{
    return currentWeek;
}

@end

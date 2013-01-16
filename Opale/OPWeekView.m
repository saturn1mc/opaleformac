//
//  OPWeekView.m
//  Opale
//
//  Created by Camille on 15/01/13.
//
//

#import "OPWeekView.h"

@implementation OPWeekView

@dynamic currentWeek;
@synthesize weekTable, colHour, colMonday, colTuesday, colWednesday, colThursday, colFriday, colSaturday;

-(void)setCurrentWeek:(NSMutableArray *)nWeek{
    currentWeek = nWeek;
    
    NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:frLocale];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"EEEE dd"];
    
    [[colMonday headerCell] setTitle:[dateFormatter stringFromDate:[currentWeek objectAtIndex:0]]];
    [[colTuesday headerCell] setTitle:[dateFormatter stringFromDate:[currentWeek objectAtIndex:1]]];
    [[colWednesday headerCell] setTitle:[dateFormatter stringFromDate:[currentWeek objectAtIndex:2]]];
    [[colThursday headerCell] setTitle:[dateFormatter stringFromDate:[currentWeek objectAtIndex:3]]];
    [[colFriday headerCell] setTitle:[dateFormatter stringFromDate:[currentWeek objectAtIndex:4]]];
    [[colSaturday headerCell] setTitle:[dateFormatter stringFromDate:[currentWeek objectAtIndex:5]]];
    
    [weekTable reloadData];
}

-(NSMutableArray*)getCurrentWeek{
    return currentWeek;
}

@end

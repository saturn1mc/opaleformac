//
//  OPDayView.m
//  Opale
//
//  Created by Camille on 15/01/13.
//
//

#import "OPDayView.h"

@implementation OPDayView

@dynamic currentDay;
@synthesize colHour, colDay;

-(void)setCurrentDay:(NSDate *)nDay{
    currentDay = nDay;
    
    NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dddd dd MM"];
    [dateFormatter setLocale:frLocale];
    
    [[colDay headerCell] setTitle:[dateFormatter stringFromDate:currentDay]];
}

-(NSDate*)getCurrentDay{
    return currentDay;
}

@end

//
//  OPDayAppointmentsView.m
//  Opale
//
//  Created by Camille on 15/01/13.
//
//

#import "OPDayAppointmentsView.h"
#import "OPDayView.h"

@implementation OPDayAppointmentsView

@dynamic currentDay;
@synthesize dayView, contentView;

-(void)awakeFromNib{
    dayView = [[OPDayView alloc] initWithFrame:contentView.frame];
    [contentView addSubview:dayView];
}

-(void)setCurrentDay:(NSDate *)nDay{
    currentDay = nDay;
    
    NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"EEEE dd"];
    [dateFormatter setLocale:frLocale];
    
    NSString* dateStr = [dateFormatter stringFromDate:currentDay];
    [[dayView header] setStringValue:[[[dateStr substringToIndex:1] uppercaseString] stringByAppendingString:[dateStr substringFromIndex:1]]];
}

-(NSDate*)getCurrentDay{
    return currentDay;
}

@end

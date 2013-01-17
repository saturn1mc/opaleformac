
//
//  OPWeekAppointmentsView.m
//  Opale
//
//  Created by Camille on 15/01/13.
//
//

#import "OPWeekAppointmentsView.h"
#import "OPDayView.h"
#import "OPAppointmentView.h"

@implementation OPWeekAppointmentsView

static CGFloat daysAppearing    = 6;
static CGFloat dayColumnWidth   = 102;

@dynamic currentWeek;
@synthesize displayedDays, scrollView, contentView;

-(void)awakeFromNib{
    displayedDays = [[NSMutableArray alloc] init];
    [self prepareView];
}

-(void)prepareView{
    CGFloat top = contentView.frame.size.height;
    CGFloat y = 0;
    CGFloat x = 0;
    
    for(int i = 0; i < daysAppearing; i++){
        
        OPDayView* day = [[OPDayView alloc] initWithFrame:NSMakeRect(x, y, dayColumnWidth, contentView.frame.size.height)];
        
        [contentView addSubview:day];
        [displayedDays addObject:day];
        
        x += dayColumnWidth;
    }
    
    [[scrollView documentView] scrollPoint:NSMakePoint(0, top)];
}

-(void)setCurrentWeek:(NSMutableArray *)nWeek{
    currentWeek = nWeek;
    
    NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:frLocale];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"EEEE dd"];
    
    for(int i = 0; i < daysAppearing; i++){
        OPDayView* dayView = (OPDayView*)[displayedDays objectAtIndex:i];
        
        NSString* dateStr = [dateFormatter stringFromDate:[currentWeek objectAtIndex:i]];
        [[dayView header] setStringValue:[[[dateStr substringToIndex:1] uppercaseString] stringByAppendingString:[dateStr substringFromIndex:1]]];
    }
}

-(NSMutableArray*)getCurrentWeek{
    return currentWeek;
}

@end

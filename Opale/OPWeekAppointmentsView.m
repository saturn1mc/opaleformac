
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
    
    for(int i = 0; i < daysAppearing; i++){
        [(OPDayView*)[displayedDays objectAtIndex:i] setCurrentDay:[currentWeek objectAtIndex:i]];
    }
}

-(NSMutableArray*)getCurrentWeek{
    return currentWeek;
}

-(void)loadAppointments:(NSMutableArray*)dayAppointments forDay:(int)day{
    [(OPDayView*)[displayedDays objectAtIndex:day] setAppointmentViews:dayAppointments];
}

@end

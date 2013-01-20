//
//  OPWeekAppointmentsView.h
//  Opale
//
//  Created by Camille on 15/01/13.
//
//

#import "OPView.h"

@class OPAppointmentView;

@interface OPWeekAppointmentsView : OPView{
    NSMutableArray* currentWeek;
    NSMutableArray* displayedDays;
    
    IBOutlet NSScrollView* scrollView;
    IBOutlet NSView* contentView;
}

@property (nonatomic, retain) NSMutableArray* currentWeek;
@property (nonatomic, retain) NSMutableArray* displayedDays;

@property (nonatomic, retain) IBOutlet NSScrollView* scrollView;
@property (nonatomic, retain) IBOutlet NSView* contentView;

-(void)prepareView;
-(void)setCurrentWeek:(NSMutableArray *)nWeek;
-(NSMutableArray*)getCurrentWeek;

-(void)loadAppointments:(NSMutableArray*)dayAppointments forDay:(int)day;

@end

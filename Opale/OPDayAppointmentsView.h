//
//  OPDayAppointmentsView.h
//  Opale
//
//  Created by Camille on 15/01/13.
//
//

#import "OPView.h"

@class OPDayView;

@interface OPDayAppointmentsView : OPView{
    NSDate* currentDay;
    OPDayView* dayView;
    
    IBOutlet NSView* contentView;
    IBOutlet NSScrollView* scrollView;
}

@property (nonatomic, retain) NSDate* currentDay;
@property (nonatomic, retain) OPDayView* dayView;

@property (nonatomic, retain) IBOutlet NSScrollView* scrollView;
@property (nonatomic, retain) IBOutlet NSView* contentView;

-(void)prepareView;
-(void)setCurrentDay:(NSDate *)nDay;
-(NSDate*)getCurrentDay;

-(void)loadAppointments:(NSMutableArray*)dayAppointments;

@end

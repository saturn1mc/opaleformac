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
}

@property (nonatomic, retain) NSDate* currentDay;

@property (nonatomic, retain) OPDayView* dayView;
@property (nonatomic, retain) IBOutlet NSView* contentView;

-(void)setCurrentDay:(NSDate *)nDay;
-(NSDate*)getCurrentDay;

@end

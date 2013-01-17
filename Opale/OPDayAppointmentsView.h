//
//  OPDayAppointmentsView.h
//  Opale
//
//  Created by Camille on 15/01/13.
//
//

#import "OPView.h"

@interface OPDayAppointmentsView : OPView{
    NSDate* currentDay;
    IBOutlet NSView* contentView;
}

@property (nonatomic, retain) NSDate* currentDay;
@property (nonatomic, retain) IBOutlet NSView* contentView;

-(void)setCurrentDay:(NSDate *)nDay;
-(NSDate*)getCurrentDay;

@end

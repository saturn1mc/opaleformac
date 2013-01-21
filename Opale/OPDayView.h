//
//  OPDayView.h
//  Opale
//
//  Created by Camille on 17/01/13.
//
//

#import <Cocoa/Cocoa.h>

@interface OPDayView : NSView{
    NSDate* currentDay;
    NSDateFormatter* dateFormatter;
    NSTextField* header;
    
    NSMutableArray* appointmentViews;
}

@property (nonatomic, retain) NSDate* currentDay;
@property (nonatomic, retain) NSDateFormatter* dateFormatter;
@property (nonatomic, retain) NSTextField* header;
@property (nonatomic, retain) NSMutableArray* appointmentViews;

-(void)setCurrentDay:(NSDate *)nDay;
-(NSDate*)getCurrentDay;

-(void)setAppointmentViews:(NSMutableArray *)nAppointments;
-(NSMutableArray*)getAppointmentViews;

@end
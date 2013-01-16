//
//  OPDayView.h
//  Opale
//
//  Created by Camille on 15/01/13.
//
//

#import "OPView.h"

@interface OPDayView : OPView <NSTableViewDelegate, NSTableViewDataSource>{
    NSDate* currentDay;
    IBOutlet NSTableColumn* colHour;
    IBOutlet NSTableColumn* colDay;
}

@property (nonatomic, retain) NSDate* currentDay;
@property (nonatomic, retain) IBOutlet NSTableColumn* colHour;
@property (nonatomic, retain) IBOutlet NSTableColumn* colDay;

-(void)setCurrentDay:(NSDate *)nDay;
-(NSDate*)getCurrentDay;

@end

//
//  OPWeekView.h
//  Opale
//
//  Created by Camille on 15/01/13.
//
//

#import "OPView.h"

@interface OPWeekView : OPView <NSTableViewDelegate, NSTableViewDataSource>{
    NSMutableArray* currentWeek;
    
    IBOutlet NSTableView* weekTable;
    IBOutlet NSTableColumn* colHour;
    IBOutlet NSTableColumn* colMonday;
    IBOutlet NSTableColumn* colTuesday;
    IBOutlet NSTableColumn* colWednesday;
    IBOutlet NSTableColumn* colThursday;
    IBOutlet NSTableColumn* colFriday;
    IBOutlet NSTableColumn* colSaturday;
}

@property (nonatomic, retain) NSMutableArray* currentWeek;
@property (nonatomic, retain) IBOutlet NSTableView* weekTable;
@property (nonatomic, retain) IBOutlet NSTableColumn* colHour;
@property (nonatomic, retain) IBOutlet NSTableColumn* colMonday;
@property (nonatomic, retain) IBOutlet NSTableColumn* colTuesday;
@property (nonatomic, retain) IBOutlet NSTableColumn* colWednesday;
@property (nonatomic, retain) IBOutlet NSTableColumn* colThursday;
@property (nonatomic, retain) IBOutlet NSTableColumn* colFriday;
@property (nonatomic, retain) IBOutlet NSTableColumn* colSaturday;

-(void)setCurrentWeek:(NSMutableArray *)nWeek;
-(NSMutableArray*)getCurrentWeek;

@end

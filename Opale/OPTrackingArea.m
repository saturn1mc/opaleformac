//
//  OPTrackingArea.m
//  Opale
//
//  Created by Camille on 27/01/13.
//
//

#import "OPTrackingArea.h"

@implementation OPTrackingArea

@synthesize correspondingSlot;


-(id)initWithRect:(NSRect)rect options:(NSTrackingAreaOptions)options owner:(id)owner userInfo:(NSDictionary *)userInfo{
    
    self = [super initWithRect:rect options:options owner:owner userInfo:userInfo];
    
    
    if(self){
        correspondingSlot = [[NSDateComponents alloc] init];
    }
    
    return self;
}

- (void)setHour:(int)hour andMinutes:(int)minutes{
    [correspondingSlot setHour:hour];
    [correspondingSlot setMinute:minutes];
}

@end

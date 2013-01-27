//
//  OPTrackingArea.h
//  Opale
//
//  Created by Camille on 27/01/13.
//
//

#import <Cocoa/Cocoa.h>

@interface OPTrackingArea : NSTrackingArea{
    NSDateComponents* correspondingSlot;
}

@property (nonatomic, retain) NSDateComponents* correspondingSlot;

- (void)setHour:(int)hour andMinutes:(int)minutes;

@end

//
//  OPCalendarView.h
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPView.h"

@class OACalendarView;

@interface OPCalendarView : OPView{
    IBOutlet OACalendarView* calendarView;
}

@property (nonatomic, retain) IBOutlet OACalendarView* calendarView;

@end

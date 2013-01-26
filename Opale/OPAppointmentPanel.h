//
//  OPAppointmentPanel.h
//  Opale
//
//  Created by Camille on 26/01/13.
//
//

#import <Cocoa/Cocoa.h>

@class OPEditAppointmentView;

@interface OPAppointmentPanel : NSPanel{
    IBOutlet OPEditAppointmentView* editAppointmentView;
}

@property (nonatomic, retain) IBOutlet OPEditAppointmentView* editAppointmentView;

@end

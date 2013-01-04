//
//  OPAdultFemalePatientView.h
//  Opale
//
//  Created by Camille Maurice on 16/07/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPAdultMalePatientView.h"

@interface OPAdultFemalePatientView : OPAdultMalePatientView{
    IBOutlet NSTextView* gynecologicalHistory;
    IBOutlet NSTextView* gynecologicalSphere;
}

@property (nonatomic, retain) IBOutlet NSTextView* gynecologicalHistory;
@property (nonatomic, retain) IBOutlet NSTextView* gynecologicalSphere;

@end

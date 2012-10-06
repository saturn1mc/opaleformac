//
//  OPAdultMalePatientView.h
//  Opale
//
//  Created by Camille Maurice on 25/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPView.h"
#import "OPExistingPatientView.h"

@class OPPatient;

@interface OPAdultMalePatientView : OPExistingPatientView{
    //TODO : additionnal fields ?
    IBOutlet NSFormCell* cellAgeGeneral;
    IBOutlet NSFormCell* cellAgeHealth;
}

@property (nonatomic, retain) IBOutlet NSFormCell*  cellAgeGeneral;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellAgeHealth;

@end

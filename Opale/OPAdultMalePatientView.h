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
    IBOutlet NSFormCell* cellAgeGeneral;
    IBOutlet NSFormCell* cellAgeHealth;
    
    //General tab : Additionals
    IBOutlet NSFormCell* cellJob;
    IBOutlet NSFormCell* cellFamilyStatus;
    IBOutlet NSFormCell* cellExtraActivity;
    IBOutlet NSFormCell* cellChildren;
}

@property (nonatomic, retain) IBOutlet NSFormCell*  cellAgeGeneral;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellAgeHealth;

@property (nonatomic, retain) IBOutlet NSFormCell* cellJob;
@property (nonatomic, retain) IBOutlet NSFormCell* cellFamilyStatus;
@property (nonatomic, retain) IBOutlet NSFormCell* cellExtraActivity;
@property (nonatomic, retain) IBOutlet NSFormCell* cellChildren;

-(void)updateAgeFields;

@end

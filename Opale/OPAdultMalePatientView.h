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
    IBOutlet NSFormCell* cellAge;
    
    //General tab : Additionals
    IBOutlet NSFormCell* cellJob;
    IBOutlet NSFormCell* cellFamilyStatus;
    IBOutlet NSFormCell* cellExtraActivity;
    IBOutlet NSFormCell* cellChildren;
    IBOutlet NSFormCell* cellLaterality;
    IBOutlet NSFormCell* cellAftercare;
    IBOutlet NSFormCell* cellRiskFactor;
}

@property (nonatomic, retain) IBOutlet NSFormCell*  cellAge;

@property (nonatomic, retain) IBOutlet NSFormCell* cellJob;
@property (nonatomic, retain) IBOutlet NSFormCell* cellFamilyStatus;
@property (nonatomic, retain) IBOutlet NSFormCell* cellExtraActivity;
@property (nonatomic, retain) IBOutlet NSFormCell* cellChildren;
@property (nonatomic, retain) IBOutlet NSFormCell* cellLaterality;
@property (nonatomic, retain) IBOutlet NSFormCell* cellAftercare;
@property (nonatomic, retain) IBOutlet NSFormCell* cellRiskFactor;

-(IBAction)updateAge:(id)sender;

@end

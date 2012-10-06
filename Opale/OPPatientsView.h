//
//  OPPatientsView.h
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPView.h"

@class OPPatientSearchView, OPNewPatientView;

@interface OPPatientsView : OPView{
    IBOutlet OPPatientSearchView* searchView;
    IBOutlet OPNewPatientView* nPatientView;
}

@property (nonatomic, retain) IBOutlet OPPatientSearchView* searchView;
@property (nonatomic, retain) IBOutlet OPNewPatientView* nPatientView;

-(IBAction)openSearchView:(id)sender;
-(IBAction)openNewPatientForm:(id)sender;

@end

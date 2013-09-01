//
//  OPPatientsView.m
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPPatientsView.h"
#import "OPMainWindow.h"
#import "OPPatientSearchView.h"
#import "OPNewPatientView.h"

@implementation OPPatientsView

@synthesize searchView, nPatientView;

-(IBAction)openSearchView:(id)sender{
    [searchView resetView];
    [parent pushSubview:searchView];
}

-(IBAction)openNewPatientForm:(id)sender{
    [nPatientView resetView];
    [parent pushSubview:nPatientView];
}


@end

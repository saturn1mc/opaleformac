//
//  OPProfessionalsView.m
//  Opale
//
//  Created by Camille on 29/06/13.
//
//

#import "OPProfessionalsView.h"
#import "OPMainWindow.h"
#import "OPNewProfessionalView.h"
#import "OPProfessionalSearchView.h"

@implementation OPProfessionalsView

@synthesize searchView, nProfessionalView;

-(IBAction)openSearchView:(id)sender{
    [parent pushSubview:searchView];
}

-(IBAction)openNewProfessionalForm:(id)sender{
    [parent pushSubview:nProfessionalView];
}

@end

//
//  OPProfessionalsView.h
//  Opale
//
//  Created by Camille on 29/06/13.
//
//

#import "OPView.h"

@class  OPProfessionalSearchView, OPNewProfessionalView;

@interface OPProfessionalsView : OPView{
    IBOutlet OPProfessionalSearchView* searchView;
    IBOutlet OPNewProfessionalView* nProfessionalView;
}

@property (nonatomic, retain) IBOutlet OPProfessionalSearchView* searchView;
@property (nonatomic, retain) IBOutlet OPNewProfessionalView* nProfessionalView;

-(IBAction)openSearchView:(id)sender;
-(IBAction)openNewProfessionalForm:(id)sender;

@end

//
//  OPChildPatientView.h
//  Opale
//
//  Created by Camille on 02/09/13.
//
//

#import "OPExistingPatientView.h"

@interface OPChildPatientView : OPExistingPatientView{
    IBOutlet NSFormCell* cellAge;
    
    //General tab : Additionals
    IBOutlet NSFormCell* cellParity;
    IBOutlet NSFormCell* cellExtraActivity;
    IBOutlet NSFormCell* cellLaterality;
    IBOutlet NSFormCell* cellAftercare;
    IBOutlet NSFormCell* cellRiskFactor;
    IBOutlet NSFormCell* cellHeight;
    IBOutlet NSFormCell* cellWeight;
}

@property (nonatomic, retain) IBOutlet NSFormCell*  cellAge;

@property (nonatomic, retain) IBOutlet NSFormCell* cellParity;
@property (nonatomic, retain) IBOutlet NSFormCell* cellExtraActivity;
@property (nonatomic, retain) IBOutlet NSFormCell* cellLaterality;
@property (nonatomic, retain) IBOutlet NSFormCell* cellAftercare;
@property (nonatomic, retain) IBOutlet NSFormCell* cellRiskFactor;
@property (nonatomic, retain) IBOutlet NSFormCell* cellHeight;
@property (nonatomic, retain) IBOutlet NSFormCell* cellWeight;

-(IBAction)updateAge:(id)sender;

@end

//
//  OPBabyConsultationView.h
//  Opale
//
//  Created by Camille on 06/01/13.
//
//

#import "OPAdultChildConsultationView.h"

@interface OPBabyConsultationView : OPAdultChildConsultationView{    
    IBOutlet NSFormCell* cellHeight;
    IBOutlet NSFormCell* cellWeight;
    IBOutlet NSFormCell* cellHC;
}

@property (nonatomic, retain) IBOutlet NSFormCell* cellHeight;
@property (nonatomic, retain) IBOutlet NSFormCell* cellWeight;
@property (nonatomic, retain) IBOutlet NSFormCell* cellHC;

@end

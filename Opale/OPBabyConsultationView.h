//
//  OPBabyConsultationView.h
//  Opale
//
//  Created by Camille on 06/01/13.
//
//

#import "OPAdultChildConsultationView.h"

@class OPBabyPatientView;

@interface OPBabyConsultationView : OPAdultChildConsultationView{
    IBOutlet OPBabyPatientView* babyPatientView;
    
    IBOutlet NSFormCell* cellHeight;
    IBOutlet NSFormCell* cellWeight;
    IBOutlet NSFormCell* cellHC;
}

@property (nonatomic, retain) IBOutlet OPBabyPatientView* babyPatientView;

@property (nonatomic, retain) IBOutlet NSFormCell* cellHeight;
@property (nonatomic, retain) IBOutlet NSFormCell* cellWeight;
@property (nonatomic, retain) IBOutlet NSFormCell* cellHC;

@end

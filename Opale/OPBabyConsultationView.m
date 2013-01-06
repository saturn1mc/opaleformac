//
//  OPBabyConsultationView.m
//  Opale
//
//  Created by Camille on 06/01/13.
//
//

#import "OPBabyConsultationView.h"
#import "OPBabyPatientView.h"
#import "OPConsultation.h"

@implementation OPBabyConsultationView

@synthesize babyPatientView, cellHeight, cellWeight, cellHC;

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)loadConsultation:(OPConsultation *)nConsultation{
    [super loadConsultation:nConsultation];
    
    [OPView initFormCell:cellHeight withString:[consultation.height stringValue]];
    [OPView initFormCell:cellWeight withString:[consultation.weight stringValue]];
    [OPView initFormCell:cellHC withString:[consultation.headCircumference stringValue]];
}

-(void)applyModifications{
    [super applyModifications];
    
    consultation.height = [[NSNumber alloc] initWithInt:[[cellHeight stringValue] integerValue]];
    consultation.weight = [[NSNumber alloc] initWithInt:[[cellWeight stringValue] integerValue]];
    consultation.headCircumference = [[NSNumber alloc] initWithInt:[[cellHC stringValue] integerValue]];
}

-(void)saveConsultation:(id)sender{
    [super saveConsultation:self];
    [babyPatientView updateGraphs:self];
}

@end

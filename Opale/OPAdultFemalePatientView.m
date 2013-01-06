//
//  OPAdultFemalePatientView.m
//  Opale
//
//  Created by Camille Maurice on 16/07/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPAdultFemalePatientView.h"
#import "OPPatient.h"

@implementation OPAdultFemalePatientView

@synthesize gynecologicalHistory, gynecologicalSphere;

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self addEditableObject:gynecologicalHistory];
    [self addEditableObject:gynecologicalSphere];
}

-(void)loadPatient:(OPPatient *)patientToLoad{
    [super loadPatient:patientToLoad];
    
    [OPView initTextView:gynecologicalHistory withString:patient.gynecologicalHistory];
    [OPView initTextView:gynecologicalSphere withString:patient.gynecologicalSphere];
}

-(void)applyModifications{
    [super applyModifications];
    
    patient.gynecologicalHistory = [[NSString alloc] initWithString:[gynecologicalHistory string]];
    patient.gynecologicalSphere = [[NSString alloc] initWithString:[gynecologicalSphere string]];
}

@end

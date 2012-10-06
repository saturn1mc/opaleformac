//
//  OPAdultChildConsultationView.h
//  Opale
//
//  Created by Camille Maurice on 28/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPView.h"

@class OPConsultation;

@interface OPAdultChildConsultationView : OPView{
    OPConsultation* consultation;
    
    IBOutlet NSDatePicker*  consultationDate;
    IBOutlet NSTextView*    textTests;
    IBOutlet NSTextView*    textTreatments;
    IBOutlet NSTextView*    textAdvises;
}

@property (nonatomic, retain) OPConsultation* consultation;

@property (nonatomic, retain) IBOutlet NSDatePicker*  consultationDate;
@property (nonatomic, retain) IBOutlet NSTextView*    textTests;
@property (nonatomic, retain) IBOutlet NSTextView*    textTreatments;
@property (nonatomic, retain) IBOutlet NSTextView*    textAdvises;

-(void)loadConsultation:(OPConsultation *)nConsultation;
-(IBAction)saveConsultation:(id)sender;

@end

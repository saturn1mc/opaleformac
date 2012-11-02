//
//  OPAdultChildConsultationView.h
//  Opale
//
//  Created by Camille Maurice on 28/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPView.h"

@class OPConsultation;

@interface OPAdultChildConsultationView : OPView <NSTableViewDelegate, NSTableViewDataSource>{
    OPConsultation* consultation;
    
    IBOutlet NSDatePicker*  consultationDate;
    IBOutlet NSTextView*    textTests;
    IBOutlet NSTextView*    textTreatments;
    IBOutlet NSTextView*    textAdvises;
    
    IBOutlet NSTableView* lettersTable;
    IBOutlet NSTableColumn* colLetterName;
    IBOutlet NSTableColumn* colLetterFilePath;
}

@property (nonatomic, retain) OPConsultation* consultation;

@property (nonatomic, retain) IBOutlet NSDatePicker*  consultationDate;
@property (nonatomic, retain) IBOutlet NSTextView*    textTests;
@property (nonatomic, retain) IBOutlet NSTextView*    textTreatments;
@property (nonatomic, retain) IBOutlet NSTextView*    textAdvises;

@property (nonatomic, retain) IBOutlet IBOutlet NSTableView* lettersTable;
@property (nonatomic, retain) IBOutlet NSTableColumn* colLetterName;
@property (nonatomic, retain) IBOutlet NSTableColumn* colLetterFilePath;

-(void)loadConsultation:(OPConsultation *)nConsultation;
-(IBAction)saveConsultation:(id)sender;
-(IBAction)createNewLetter:(id)sender;

@end

//
//  OPAdultChildConsultationView.h
//  Opale
//
//  Created by Camille Maurice on 28/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPView.h"

@class OPInvoicePanel, OPConsultation;

@interface OPConsultationView : OPView<NSTextViewDelegate>{
    OPConsultation* consultation;
    IBOutlet OPInvoicePanel* invoicePanel;
    
    BOOL modified;
    
    IBOutlet NSDatePicker* consultationDate;
    IBOutlet NSTextView* textMotives;
    IBOutlet NSTextView* textTests;
    IBOutlet NSTextView* textTreatments;
    IBOutlet NSTextView* textAdvises;
    
    IBOutlet NSButton* invoiceFlag;
    
}


@property (nonatomic, retain) OPConsultation* consultation;
@property (nonatomic, retain) OPInvoicePanel* invoicePanel;

@property (nonatomic) BOOL modified;

@property (nonatomic, retain) IBOutlet NSDatePicker*  consultationDate;
@property (nonatomic, retain) IBOutlet NSTextView*    textMotives;
@property (nonatomic, retain) IBOutlet NSTextView*    textTests;
@property (nonatomic, retain) IBOutlet NSTextView*    textTreatments;
@property (nonatomic, retain) IBOutlet NSTextView*    textAdvises;

@property (nonatomic, retain) IBOutlet NSButton* invoiceFlag;

-(void)loadConsultation:(OPConsultation *)nConsultation;
-(void)applyModifications;

-(IBAction)saveConsultation:(id)sender;

-(IBAction)showInvoicePanel:(id)sender;
-(IBAction)closeInvoicePanel:(id)sender;

-(IBAction)returnToPatient:(id)sender;

-(void)refreshInvoiceFlag;

@end

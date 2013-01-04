//
//  OPAdultChildConsultationView.h
//  Opale
//
//  Created by Camille Maurice on 28/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPView.h"

@class OPInvoicePanel, OPConsultation;

@interface OPAdultChildConsultationView : OPView{
    OPConsultation* consultation;
    
    IBOutlet NSDatePicker* consultationDate;
    IBOutlet NSTextView* textMotives;
    IBOutlet NSTextView* textTests;
    IBOutlet NSTextView* textTreatments;
    IBOutlet NSTextView* textAdvises;
    
    IBOutlet OPInvoicePanel* invoicePanel;
}

@property (nonatomic, retain) OPInvoicePanel* invoicePanel;
@property (nonatomic, retain) OPConsultation* consultation;

@property (nonatomic, retain) IBOutlet NSDatePicker*  consultationDate;
@property (nonatomic, retain) IBOutlet NSTextView*    textMotives;
@property (nonatomic, retain) IBOutlet NSTextView*    textTests;
@property (nonatomic, retain) IBOutlet NSTextView*    textTreatments;
@property (nonatomic, retain) IBOutlet NSTextView*    textAdvises;


-(void)loadConsultation:(OPConsultation *)nConsultation;
-(IBAction)saveConsultation:(id)sender;

-(IBAction)showInvoicePanel:(id)sender;
-(IBAction)closeInvoicePanel:(id)sender;

@end

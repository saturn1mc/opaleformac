//
//  OPBillingPanel.h
//  Opale
//
//  Created by Camille on 30/12/12.
//
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class OPMainWindow, OPConsultation, OPBillView;

@interface OPBillingPanel : NSPanel{
    IBOutlet OPMainWindow* parent;
    OPConsultation* consultation;
    
    IBOutlet NSMatrix* rates;
    IBOutlet NSTextField* specialRate;
    IBOutlet NSTextView* comment;
    IBOutlet NSTextField* payer;
    IBOutlet NSComboBox* paymentMethod;
    
    IBOutlet OPBillView* billView;
}

@property (nonatomic, retain) IBOutlet OPMainWindow* parent;
@property (nonatomic, retain) OPConsultation* consultation;

@property (nonatomic, retain) IBOutlet NSMatrix* rates;
@property (nonatomic, retain) IBOutlet NSTextField* specialRate;
@property (nonatomic, retain) IBOutlet NSTextView* comment;
@property (nonatomic, retain) IBOutlet NSTextField* payer;
@property (nonatomic, retain) IBOutlet NSComboBox* paymentMethod;

@property (nonatomic, retain) IBOutlet NSView* billView;

- (IBAction)printBill:(id)sender;
- (void)printOperationDidRun:(NSPrintOperation *)printOperation success:(BOOL)success contextInfo:(void *)contextInfo;

@end

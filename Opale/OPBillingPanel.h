//
//  OPBillingPanel.h
//  Opale
//
//  Created by Camille on 30/12/12.
//
//

#import <Cocoa/Cocoa.h>

@interface OPBillingPanel : NSPanel{
    IBOutlet NSMatrix* rates;
    IBOutlet NSTextField* specialRate;
    IBOutlet NSTextView* comment;
    IBOutlet NSComboBox* paymentMethod;
}

@property (nonatomic, retain) IBOutlet NSMatrix* rates;
@property (nonatomic, retain) IBOutlet NSTextField* specialRate;
@property (nonatomic, retain) IBOutlet NSTextView* comment;
@property (nonatomic, retain) IBOutlet NSComboBox* paymentMethod;

- (IBAction)closeCustomSheet:(id)sender;
- (IBAction)printBill:(id)sender;

@end

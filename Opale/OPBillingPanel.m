//
//  OPBillingPanel.m
//  Opale
//
//  Created by Camille on 30/12/12.
//
//

#import "OPBillingPanel.h"

@implementation OPBillingPanel

@synthesize rates, specialRate, comment, paymentMethod;

- (IBAction)closeCustomSheet:(id)sender{
    [NSApp endSheet:self];
}

- (IBAction)printBill:(id)sender{
    //TODO create bill object + save it + print pdf
}

@end

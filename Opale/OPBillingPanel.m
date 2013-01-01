//
//  OPBillingPanel.m
//  Opale
//
//  Created by Camille on 30/12/12.
//
//

#import "OPBillingPanel.h"
#import "OPMainWindow.h"
#import "OPBillView.h"

#import "OPConsultation.h"
#import "OPPatient.h"

@implementation OPBillingPanel

@synthesize parent, consultation, rates, specialRate, comment, payer, paymentMethod, billView;

- (IBAction)printBill:(id)sender{
    
    //Price
    NSString* priceStr;
    
    switch ([rates selectedRow]){
        case 0: // Adult
            priceStr = [[NSString alloc] initWithFormat:@"50"];
            break;
            
        case 1: // Child/Baby
            priceStr = [[NSString alloc] initWithFormat:@"45"];
            break;
            
        case 2: // Handball;
            priceStr = [[NSString alloc] initWithFormat:@"40"];
            break;
            
        case 3: //Pro bono
            priceStr = [[NSString alloc] initWithFormat:@"0"];
            break;
        
        case 4: //Other
            priceStr = [[NSString alloc] initWithString:[specialRate stringValue]];
            break;
    }
    
    //Payer
    NSString* payerStr = [[NSString alloc] initWithString:[payer stringValue]];
    
    //Patient
    NSString* patientStr = [[NSString alloc] initWithFormat:@"%@ %@", consultation.patient.firstName, consultation.patient.lastName];
    
    //Date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
    NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    [dateFormatter setLocale:frLocale];
    
    NSString* dateStr = [[NSString alloc] initWithString:[dateFormatter stringFromDate:[NSDate date]]];
    
    //Update bill view
    [billView setPrice:priceStr andPayer:payerStr andPatient:patientStr andDate:dateStr];
    
    [NSApp endSheet:self];
    [self orderOut:self];
    
    //Print operation
    NSPrintInfo* printInfo = [NSPrintInfo sharedPrintInfo];
    [printInfo setLeftMargin:0.0];
    [printInfo setRightMargin:0.0];
    [printInfo setBottomMargin:0.0];
    [printInfo setTopMargin:0.0];
    [printInfo setHorizontalPagination:NSFitPagination];
    [printInfo setVerticalPagination:NSFitPagination];
    
    NSPrintOperation* printOp = [NSPrintOperation printOperationWithView:billView printInfo:printInfo];
    [printOp setCanSpawnSeparateThread:YES];
    [printOp runOperationModalForWindow:parent delegate:self didRunSelector:@selector(printOperationDidRun: success: contextInfo:) contextInfo:nil];
}

- (void)printOperationDidRun:(NSPrintOperation *)printOperation success:(BOOL)success contextInfo:(void *)contextInfo{
    
    //TODO create bill object + save it + print pdf
    //TEST : save to pdf
}

@end

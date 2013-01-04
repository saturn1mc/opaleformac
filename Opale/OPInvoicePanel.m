//
//  OPInvoicePanel.m
//  Opale
//
//  Created by Camille on 30/12/12.
//
//

#import "OPInvoicePanel.h"
#import "OPMainWindow.h"
#import "OPAppDelegate.h"
#import "OPInvoiceView.h"

#import "OPConsultation.h"
#import "OPPatient.h"

#import "OPInvoice.h"

@implementation OPInvoicePanel

@synthesize parent, consultation, rates, specialRate, comment, payer, paymentMethod, invoiceView;

- (IBAction)printInvoice:(id)sender{
    
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
    [dateFormatter setDateFormat:@"d MMMM yyyy"];
    [dateFormatter setLocale:frLocale];
    
    NSString* dateStr = [[NSString alloc] initWithString:[dateFormatter stringFromDate:[NSDate date]]];
    
    //Update bill view
    [invoiceView setPrice:priceStr andPayer:payerStr andPatient:patientStr andDate:dateStr];
    
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
    
    NSPrintOperation* printOp = [NSPrintOperation printOperationWithView:invoiceView printInfo:printInfo];
    [printOp setCanSpawnSeparateThread:YES];
    [printOp runOperationModalForWindow:parent delegate:self didRunSelector:@selector(printOperationDidRun: success: contextInfo:) contextInfo:nil];
}

- (void)printOperationDidRun:(NSPrintOperation *)printOperation success:(BOOL)success contextInfo:(void *)contextInfo{
    
    OPAppDelegate* appDelegate = (OPAppDelegate*)parent.delegate;
    NSManagedObjectContext* managedObjectContext = [appDelegate managedObjectContext];
    
    OPInvoice* nInvoice = [NSEntityDescription insertNewObjectForEntityForName:@"Invoice" inManagedObjectContext:managedObjectContext];
    
    nInvoice.consultation = consultation;
    
    nInvoice.comment = [[NSString alloc] initWithString:[comment string]];
    nInvoice.date = [NSDate date];
    
    nInvoice.method = paymentMethod.stringValue;
    
    
    switch ([rates selectedRow]){
        case 0: // Adult
        {
            nInvoice.price = [[NSNumber alloc] initWithFloat:50];
            nInvoice.type = [[NSString alloc] initWithFormat:@"Adultes"];
            break;
        }
            
        case 1: // Child/Baby
        {
            nInvoice.price = [[NSNumber alloc] initWithFloat:45];
            nInvoice.type = [[NSString alloc] initWithFormat:@"Bébés/Enfants"];
            break;
        }
            
        case 2: // Handball;
        {
            nInvoice.price = [[NSNumber alloc] initWithFloat:40];
            nInvoice.type = [[NSString alloc] initWithFormat:@"Handball"];
            break;
        }
            
        case 3: //Pro bono
        {
            nInvoice.price = [[NSNumber alloc] initWithFloat:0];
            nInvoice.type = [[NSString alloc] initWithFormat:@"Acte gratuit"];
            break;
        }
            
        case 4: //Other
        {
            nInvoice.price = [[NSNumber alloc] initWithFloat:[[specialRate stringValue] floatValue]];
            nInvoice.type = [[NSString alloc] initWithFormat:@"Exceptionnel"];
            break;
        }
    }
    
    [appDelegate saveAction:self];
}

@end

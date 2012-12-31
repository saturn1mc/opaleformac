//
//  OPBillView.m
//  Opale
//
//  Created by Camille on 30/12/12.
//
//

#import "OPBillView.h"

@implementation OPBillView

@synthesize textView, initialString;

-(void)awakeFromNib{
    initialString = [[NSString alloc] initWithString:[textView string]];
}

-(void)setPrice:(NSString*)price andPayer:(NSString*)payer andPatient:(NSString*)patient andDate:(NSString*)date{
    NSString *newString = [[NSString alloc] initWithString:initialString];
    newString = [newString stringByReplacingOccurrencesOfString:@"%PRICE%" withString:price];
    newString = [newString stringByReplacingOccurrencesOfString:@"%PAYER%" withString:payer];
    newString = [newString stringByReplacingOccurrencesOfString:@"%PATIENT%" withString:patient];
    newString = [newString stringByReplacingOccurrencesOfString:@"%DATE%" withString:date];
    
    [textView setString:newString];
}

@end

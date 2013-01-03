//
//  OPBillView.m
//  Opale
//
//  Created by Camille on 30/12/12.
//
//

#import "OPBillView.h"

@implementation OPBillView

@synthesize headerTextField, bodyTextField, initialHeaderStr, initialBodyStr;

-(void)awakeFromNib{
    initialHeaderStr = [[NSString alloc] initWithString:[headerTextField stringValue]];
    initialBodyStr = [[NSString alloc] initWithString:[bodyTextField stringValue]];
}

-(void)setPrice:(NSString*)price andPayer:(NSString*)payer andPatient:(NSString*)patient andDate:(NSString*)date{
    
    //Header string
    NSString *newString = [[NSString alloc] initWithString:initialHeaderStr];
    newString = [newString stringByReplacingOccurrencesOfString:@"%DATE%" withString:date];
    
    [headerTextField setStringValue:newString];
    
    //Body string
    newString = [[NSString alloc] initWithString:initialBodyStr];
    newString = [newString stringByReplacingOccurrencesOfString:@"%PRICE%" withString:price];
    newString = [newString stringByReplacingOccurrencesOfString:@"%PAYER%" withString:payer];
    newString = [newString stringByReplacingOccurrencesOfString:@"%PATIENT%" withString:patient];
    newString = [newString stringByReplacingOccurrencesOfString:@"%DATE%" withString:date];
    
    [bodyTextField setStringValue:newString];
}

@end

//
//  OPPhoneNumberFormatter.m
//  Opale
//
//  Created by Camille on 03/01/13.
//
//

#import "OPPhoneNumberFormatter.h"

@implementation OPPhoneNumberFormatter

-(NSString *)stringForObjectValue:(id)obj{
    return (NSString*)obj;
}

-(BOOL)getObjectValue:(out __autoreleasing id *)obj forString:(NSString *)string errorDescription:(out NSString *__autoreleasing *)error{
    
    if(string){
        if([string length] == 0){
            return YES;
        }
        else{
            NSString* trimmedString = [[NSString alloc] initWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
            
            if([trimmedString integerValue] && [trimmedString length] == 10){
                *obj = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", [trimmedString substringWithRange:NSMakeRange(0, 2)], [trimmedString substringWithRange:NSMakeRange(2, 2)], [trimmedString substringWithRange:NSMakeRange(4, 2)], [trimmedString substringWithRange:NSMakeRange(6, 2)], [trimmedString substringWithRange:NSMakeRange(8, 2)]];
                return YES;
            }
        }
    }
    
    return NO;
}

@end

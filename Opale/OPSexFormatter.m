//
//  OPSexFormatter.m
//  Opale
//
//  Created by Camille on 03/01/13.
//
//

#import "OPSexFormatter.h"

@implementation OPSexFormatter

-(NSString *)stringForObjectValue:(id)obj{
    return (NSString*)obj;
}

-(BOOL)getObjectValue:(out __autoreleasing id *)obj forString:(NSString *)string errorDescription:(out NSString *__autoreleasing *)error{
    
    if(string && [string length] > 0){
        if([[string uppercaseString] isEqualToString:@"H"] || [[string uppercaseString] isEqualToString:@"HOMME"]){
            *obj = [[NSString alloc] initWithFormat:@"Homme"];
            return YES;
        }
        else if([[string uppercaseString] isEqualToString:@"F"] || [[string uppercaseString] isEqualToString:@"FEMME"]){
            *obj = [[NSString alloc] initWithFormat:@"Femme"];
            return YES;
        }
    }
    
    return NO;
}

@end

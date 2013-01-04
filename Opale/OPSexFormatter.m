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
        if([[string uppercaseString] isEqualToString:@"M"] || [[string uppercaseString] isEqualToString:@"MASCULIN"]){
            *obj = [[NSString alloc] initWithFormat:@"Masculin"];
            return YES;
        }
        else if([[string uppercaseString] isEqualToString:@"F"] || [[string uppercaseString] isEqualToString:@"FEMININ"]){
            *obj = [[NSString alloc] initWithFormat:@"Féminin"];
            return YES;
        }
    }
    
    return NO;
}

@end

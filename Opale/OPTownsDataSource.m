//
//  OPTownsDataSource.m
//  Opale
//
//  Created by Camille on 09/03/13.
//
//

#import "OPTownsDataSource.h"

@implementation OPTownsDataSource

static OPTownsDataSource* singleton = nil;
static NSString* sourceFile = @"fr_postal_codes";

@synthesize postalCodes, postalCodeTownDict;

+(OPTownsDataSource*)getInstance{
    if(singleton == nil){
        singleton = [[OPTownsDataSource alloc] init];
    }
    
    return singleton;
}

-(id)init{
    self = [super init];
    
    if(self){
        postalCodes = [[NSMutableArray alloc] init];
        postalCodeTownDict = [[NSMutableDictionary alloc] init];
        [self loadReferenceData:sourceFile];
    }
    
    return self;
}

-(void)loadReferenceData:(NSString*)sourceFile{
    NSString* fileStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:sourceFile ofType:@"csv"] encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* lines = [fileStr componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    int i = 0;
    
    for (NSString* line in lines) {
        if(i != 0){ //Skip header
            NSArray* columns = [line componentsSeparatedByString:@";"];
            [postalCodes addObject:[columns objectAtIndex:0]];
            [postalCodeTownDict setObject:[columns objectAtIndex:1] forKey:[columns objectAtIndex:0]];
        }
        
        i++;
    }
}

-(NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox{
    return [postalCodes count];
}

-(id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index{
    NSString* postalCode = [postalCodes objectAtIndex:index];
    return postalCode;
}

-(NSUInteger)comboBox:(NSComboBox *)aComboBox indexOfItemWithStringValue:(NSString *)string{
    return [postalCodes indexOfObject:string];
}

-(NSString *)comboBox:(NSComboBox *)aComboBox completedString:(NSString *)string{
    for(NSString* postalCode in postalCodes){
        if([postalCode hasPrefix:string]){
            return postalCode;
        }
    }
    
    return 0;
}

-(NSString*)getTownForPostalCode:(NSString*)postalCode{
    if(postalCode && [postalCode length] > 0){
        return [postalCodeTownDict valueForKey:postalCode];
    }
    else{
        return  0;
    }
}

@end

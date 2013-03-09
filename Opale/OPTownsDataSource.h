//
//  OPTownsDataSource.h
//  Opale
//
//  Created by Camille on 09/03/13.
//
//

#import <Foundation/Foundation.h>

@interface OPTownsDataSource : NSObject<NSComboBoxDataSource>{
    NSMutableArray* postalCodes;
    NSMutableDictionary* postalCodeTownDict;
}

@property (nonatomic, retain) NSMutableArray* postalCodes;
@property (nonatomic, retain) NSMutableDictionary* postalCodeTownDict;

+(OPTownsDataSource*)getInstance;
-(void)loadReferenceData:(NSString*)sourceFile;
-(NSString*)getTownForPostalCode:(NSString*)postalCode;

@end

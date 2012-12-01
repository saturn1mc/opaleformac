//
//  OPProfessionnal.h
//  Opale
//
//  Created by Camille on 01/12/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPLetter;

@interface OPProfessionnal : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * speciality;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSSet *letters;
@end

@interface OPProfessionnal (CoreDataGeneratedAccessors)

- (void)addLettersObject:(OPLetter *)value;
- (void)removeLettersObject:(OPLetter *)value;
- (void)addLetters:(NSSet *)values;
- (void)removeLetters:(NSSet *)values;
@end

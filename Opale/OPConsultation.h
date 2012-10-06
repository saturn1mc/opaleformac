//
//  OPConsultation.h
//  Opale
//
//  Created by Camille on 22/09/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPLetter, OPMotive, OPPatient;

@interface OPConsultation : NSManagedObject

@property (nonatomic, retain) NSString * advises;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * tests;
@property (nonatomic, retain) NSString * treatments;
@property (nonatomic, retain) NSSet *letters;
@property (nonatomic, retain) NSSet *motives;
@property (nonatomic, retain) OPPatient *patient;

@end

@interface OPConsultation (CoreDataGeneratedAccessors)

- (void)addLettersObject:(OPLetter *)value;
- (void)removeLettersObject:(OPLetter *)value;
- (void)addLetters:(NSSet *)values;
- (void)removeLetters:(NSSet *)values;

- (void)addMotivesObject:(OPMotive *)value;
- (void)removeMotivesObject:(OPMotive *)value;
- (void)addMotives:(NSSet *)values;
- (void)removeMotives:(NSSet *)values;

@end

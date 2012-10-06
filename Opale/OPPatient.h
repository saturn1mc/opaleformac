//
//  OPPatient.h
//  Opale
//
//  Created by Camille on 06/10/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPConsultation, OPGrowth;

@interface OPPatient : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * tel1;
@property (nonatomic, retain) NSString * tel2;
@property (nonatomic, retain) NSSet *consultations;
@property (nonatomic, retain) NSSet *growths;
@end

@interface OPPatient (CoreDataGeneratedAccessors)

- (void)addConsultationsObject:(OPConsultation *)value;
- (void)removeConsultationsObject:(OPConsultation *)value;
- (void)addConsultations:(NSSet *)values;
- (void)removeConsultations:(NSSet *)values;

- (void)addGrowthsObject:(OPGrowth *)value;
- (void)removeGrowthsObject:(OPGrowth *)value;
- (void)addGrowths:(NSSet *)values;
- (void)removeGrowths:(NSSet *)values;

@end

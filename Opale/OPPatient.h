//
//  OPPatient.h
//  Opale
//
//  Created by Camille on 26/12/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPConsultation, OPDocument;

@interface OPPatient : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * tel1;
@property (nonatomic, retain) NSString * tel2;
@property (nonatomic, retain) NSSet *consultations;
@property (nonatomic, retain) NSSet *documents;
@end

@interface OPPatient (CoreDataGeneratedAccessors)

- (void)addConsultationsObject:(OPConsultation *)value;
- (void)removeConsultationsObject:(OPConsultation *)value;
- (void)addConsultations:(NSSet *)values;
- (void)removeConsultations:(NSSet *)values;

- (void)addDocumentsObject:(OPDocument *)value;
- (void)removeDocumentsObject:(OPDocument *)value;
- (void)addDocuments:(NSSet *)values;
- (void)removeDocuments:(NSSet *)values;

@end

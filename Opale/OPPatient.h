//
//  OPPatient.h
//  Opale
//
//  Created by Camille on 03/01/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPConsultation, OPDocument, OPMail;

@interface OPPatient : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * tel1;
@property (nonatomic, retain) NSString * tel2;
@property (nonatomic, retain) NSString * town;
@property (nonatomic, retain) NSSet *consultations;
@property (nonatomic, retain) NSSet *documents;
@property (nonatomic, retain) NSSet *mails;
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

- (void)addMailsObject:(OPMail *)value;
- (void)removeMailsObject:(OPMail *)value;
- (void)addMails:(NSSet *)values;
- (void)removeMails:(NSSet *)values;

@end

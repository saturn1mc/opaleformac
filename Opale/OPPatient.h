//
//  OPPatient.h
//  Opale
//
//  Created by Camille on 06/01/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPConsultation, OPDocument, OPMail;

@interface OPPatient : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * addressedBy;
@property (nonatomic, retain) NSString * afterCare;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSNumber * birthHC;
@property (nonatomic, retain) NSNumber * birthHeight;
@property (nonatomic, retain) NSString * birthPlace;
@property (nonatomic, retain) NSNumber * birthWeight;
@property (nonatomic, retain) NSString * careMode;
@property (nonatomic, retain) NSString * children;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * dentalSphere;
@property (nonatomic, retain) NSString * digestiveSphere;
@property (nonatomic, retain) NSString * entAndOphtalmologicSphere;
@property (nonatomic, retain) NSString * extraActivity;
@property (nonatomic, retain) NSString * familyHistory;
@property (nonatomic, retain) NSString * familyStatus;
@property (nonatomic, retain) NSString * fatherJob;
@property (nonatomic, retain) NSString * feedingAndStoolSphere;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * generalComments;
@property (nonatomic, retain) NSString * gynecologicalHistory;
@property (nonatomic, retain) NSString * gynecologicalSphere;
@property (nonatomic, retain) NSString * job;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * medicalHistory;
@property (nonatomic, retain) NSString * motherJob;
@property (nonatomic, retain) NSString * otherSphere;
@property (nonatomic, retain) NSString * parity;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * pregnancyAndBirthSphere;
@property (nonatomic, retain) NSString * previousHistoryComments;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * sleepSphere;
@property (nonatomic, retain) NSString * surgicalHistory;
@property (nonatomic, retain) NSString * tel1;
@property (nonatomic, retain) NSString * tel2;
@property (nonatomic, retain) NSNumber * termDays;
@property (nonatomic, retain) NSNumber * termWeeks;
@property (nonatomic, retain) NSString * town;
@property (nonatomic, retain) NSString * traumaticHistory;
@property (nonatomic, retain) NSString * urinarySphere;
@property (nonatomic, retain) NSString * riskFactor;
@property (nonatomic, retain) NSString * laterality;
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

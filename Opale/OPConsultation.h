//
//  OPConsultation.h
//  Opale
//
//  Created by Camille on 03/01/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPInvoice, OPPatient;

@interface OPConsultation : NSManagedObject

@property (nonatomic, retain) NSString * advises;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * tests;
@property (nonatomic, retain) NSString * treatments;
@property (nonatomic, retain) NSString * motives;
@property (nonatomic, retain) OPInvoice *invoice;
@property (nonatomic, retain) OPPatient *patient;

@end

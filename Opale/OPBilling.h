//
//  OPBilling.h
//  Opale
//
//  Created by Camille on 31/12/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPConsultation;

@interface OPBilling : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * method;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) OPConsultation *consultation;

@end

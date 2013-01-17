//
//  OPAppointment.h
//  Opale
//
//  Created by Camille on 16/01/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPPatient;

@interface OPAppointment : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) OPPatient *patient;

@end

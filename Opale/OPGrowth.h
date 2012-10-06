//
//  OPGrowth.h
//  Opale
//
//  Created by Camille on 06/10/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPPatient;

@interface OPGrowth : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * weight;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDecimalNumber * hc;
@property (nonatomic, retain) NSDecimalNumber * height;
@property (nonatomic, retain) OPPatient *patient;

@end

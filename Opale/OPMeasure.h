//
//  OPMeasure.h
//  Opale
//
//  Created by Camille on 04/01/2014.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPPatient;

@interface OPMeasure : NSManagedObject

@property (nonatomic, retain) NSNumber * cranianPerimeter;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) OPPatient *patient;

@end

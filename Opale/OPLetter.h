//
//  OPLetter.h
//  Opale
//
//  Created by Camille on 22/09/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPConsultation, OPObject;

@interface OPLetter : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * receiver;
@property (nonatomic, retain) OPConsultation *consultation;
@property (nonatomic, retain) NSSet *objects;

@end

@interface OPLetter (CoreDataGeneratedAccessors)

- (void)addObjectsObject:(OPObject *)value;
- (void)removeObjectsObject:(OPObject *)value;
- (void)addObjects:(NSSet *)values;
- (void)removeObjects:(NSSet *)values;

@end

//
//  OPProfessionnal.h
//  Opale
//
//  Created by Camille on 03/01/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OPProfessionnal : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * speciality;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;

@end

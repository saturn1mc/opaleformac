//
//  OPProfessional.h
//  Opale
//
//  Created by Camille on 31/08/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OPProfessional : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * speciality;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * town;

@end

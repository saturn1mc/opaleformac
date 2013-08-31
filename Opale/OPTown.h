//
//  OPTown.h
//  Opale
//
//  Created by Camille on 31/08/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OPTown : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * postalCode;

@end

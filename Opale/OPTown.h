//
//  OPTown.h
//  Opale
//
//  Created by Camille on 20/01/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OPTown : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * postalCode;

@end

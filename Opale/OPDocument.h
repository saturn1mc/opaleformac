//
//  OPDocument.h
//  Opale
//
//  Created by Camille on 02/12/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPPatient;

@interface OPDocument : NSManagedObject

@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) OPPatient *patient;

@end

//
//  OPMail.h
//  Opale
//
//  Created by Camille on 31/08/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPPatient;

@interface OPMail : NSManagedObject

@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) OPPatient *patient;

@end

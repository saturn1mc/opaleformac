//
//  OPLetter.h
//  Opale
//
//  Created by Camille on 02/11/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPConsultation;

@interface OPLetter : NSManagedObject

@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) OPConsultation *consultation;

@end

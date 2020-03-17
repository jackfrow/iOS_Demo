//
//  Manager.m
//  PotatsoLibrary
//
//  Created by jackfrow on 2020/3/17.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "Manager.h"
#import <KissXML/KissXML.h>


@implementation Manager

+ (Manager *)sharedManager{
    
    static dispatch_once_t onceToken;
    static Manager *interface;
    dispatch_once(&onceToken, ^{
        interface = [Manager new];
    });
    return interface;
    
}

-(void)regenerateConfigFiles{
    
    
    
}

@end

# vibejs-subclassof

[![Build Status](https://travis-ci.org/vibejs/vibejs-subclassof.svg?branch=master)](https://travis-ci.org/vibejs/vibejs-subclassof)

## Introduction

*subclassof* provides you with the ability to test a given constructor function for
being a subclass of another constructor function.

This works with both CoffeeScript and standard Node.js inheritance models and most
provably with any of the available CoffeeScript dialects out there.


### Features

 - support for mixed inheritance models, namely *Node.js* and *CoffeeScript*
 - runs in the browser and supports browserify
 - optional assert.subclassOf macro
 - NPM package
 - Meteor package


### subclassof vs isPrototypeOf

Differently from *isPrototypeOf*, *subclassof* operates solely on constructor functions
and does not require any instances thereof. Similarly, it will traverse the constructor
function's prototype chain by checking for the presence of either *super_* (Node) or
*\__super\__* (Coffee-Script) properties defined on that constructor's prototype.


## LICENSE


    Copyright 2014 Carsten Klein
   
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
   
         http://www.apache.org/licenses/LICENSE-2.0
   
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and 
    limitations under the License.
   

## Installation


### NPM

You can install subclassof using npm.

    npm [-g] install vibejs-subclassof


### Meteor

You can install subclassof using meteor.

    meteor add vibejs:subclassof


## Usage


### subclassof


#### Node - Javascript

    require('vibejs-subclassof');

    console.log(subclassof(TypeError, Error));


#### Node - Coffee-Script

    require 'vibejs-subclassof'

    console.log subclassof TypeError, Error


#### Meteor - Javascript

    if (Meteor.isClient(){
        window.alert(subclassof(TypeError, error));
    }
    else {
        console.log(subclassof(TypeError, Error));
    }

    
#### Meteor - Coffee-Script

    if Meteor.isClient()

        window.alert subclassof TypeError, Error

    else

        console.log subclassof TypeError, Error


### assert.subclassOf

In addition to the subclassof function there is an assert macro that you can
use in your test cases by requiring the macros module explicitly.


#### Javascript

    require('vibejs-subclassof/macros');

    assert.subclassOf(TypeError, Error);


#### Coffee-Script

    require 'vibejs-subclassof/macros'

    assert.subclassOf TypeError, Error


#### Meteor - Javascript

    if (Meteor.isServer()) {
        assert.subclassOf(TypeError, Error)
    }


#### Meteor - Coffee-Script

    if Meteor.isServer()

        assert.subclassOf TypeError, Error


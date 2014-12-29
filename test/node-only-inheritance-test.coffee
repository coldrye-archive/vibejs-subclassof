#
# Copyright 2014 Carsten Klein
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and 
# limitations under the License.
#


vows = require 'vows'
assert = require 'assert'
util = require 'util'

require '../src/index'
require '../src/macros'


vows.describe 'node only inheritance'

    .addBatch

        'shallow inheritance tree' :

            'assert.AssertionError is subclassof Error' : ->

                assert.subclassOf assert.AssertionError, Error

            'assert.AssertionError is also a subclassof Object' : ->

                assert.subclassOf assert.AssertionError, Object

        'deep inheritance tree' :

            topic : ->

                Child1 = ->
                Child2 = ->
                Child3 = ->
                util.inherits Child1, Error
                util.inherits Child2, Child1
                util.inherits Child3, Child2

                {
                    base : Error
                    base1 : Child1
                    base2 : Child2
                    derived : Child3
                }

            'is subclassof Child1' : (topic) ->

                assert.subclassOf topic.derived, topic.base1

            'is subclassof Child2' : (topic) ->

                assert.subclassOf topic.derived, topic.base2

            'is subclassof Super' : (topic) ->

                assert.subclassOf topic.derived, topic.base

            'is also a subclassof Object' : (topic) ->

                assert.subclassOf topic.derived, Object

    .export module


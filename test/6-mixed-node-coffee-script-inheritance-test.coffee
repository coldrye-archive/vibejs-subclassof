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

require '../src/macros'


vows

    .describe 'mixed coffee-script/node inheritance'

    .addBatch

        'monkey patches for Errors work' :

            topic : ->

                result =

                    base : TypeError
                    derived : class Child extends TypeError

            'is subclassof TypeError' : (topic) ->

                assert.equal subclassof(topic.derived, topic.base), true

            'is subclassof Error' : (topic) ->

                assert.equal subclassof(topic.derived, Error), true

        'mixed node-coffee inheritance tree' :

            topic : ->

                class Child1 extends TypeError
                Child2 = ->
                util.inherits(Child2, Child1)
                class Child3 extends Child2

                result =

                    base : TypeError
                    base1 : Child1 
                    base2 : Child2
                    derived : Child3

            'is subclassof Child2' : (topic) ->

                assert.equal subclassof(topic.derived, topic.base2), true

            'is subclassof Child1' : (topic) ->

                assert.equal subclassof(topic.derived, topic.base1), true

            'is subclassof Super' : (topic) ->

                assert.equal subclassof(topic.derived, topic.base), true

    .export module


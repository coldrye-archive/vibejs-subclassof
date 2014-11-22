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

require '../src/macros'


vows

    .describe 'coffee-script only inheritance'

    .addBatch

        'shallow inheritance tree' :

            topic : ->

                result =

                    base : class Super
                    derived : class Child extends Super

            'is subclassof Super' : (topic) ->

                assert.subclassOf topic.derived, topic.base

            'is also a subclass of Object' : (topic) ->

                assert.subclassOf topic.derived, Object

        'deep inheritance tree' :

            topic : ->

                result =

                    base : class Super
                    base1 : class Child1 extends Super
                    base2 : class Child2 extends Child1
                    derived : class Child3 extends Child2

            'is subclassof Child2' : (topic) ->

                assert.subclassOf topic.derived, topic.base2

            'is subclassof Child1' : (topic) ->

                assert.subclassOf topic.derived, topic.base1

            'is subclassof Super' : (topic) ->

                assert.subclassOf topic.derived, topic.base

            'is also a subclass of Object' : (topic) ->

                assert.subclassOf topic.derived, Object

    .export module


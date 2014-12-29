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

require '../src/subclassof'


vows.describe 'subclassof'

    .addBatch

        'tests expected to fail' :

            # unable to test this as monkey patches are being loaded prior to that
            # the test is actually run
            #'TypeError is not a subclassof Error (without monkey patching)' : ->
            #
            #    assert.isFalse subclassof TypeError, Error

            'Error is not a subclassof Number' : ->

                assert.isFalse subclassof Error, Number

            'constructor is not a function' : ->

                cb = ->

                    subclassof null, Function

                assert.throws cb, TypeError

            'base is not a function' : ->

                cb = ->

                    subclassof Function, null

                assert.throws cb, TypeError

    .export module


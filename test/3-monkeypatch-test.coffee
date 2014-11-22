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


vows.describe 'monkey patches'

    .addBatch

        'Standard Errors are subclasses of Error' :

            'EvalError' : ->

                assert.subclassOf EvalError, Error

            'RangeError' : ->

                assert.subclassOf RangeError, Error

            'ReferenceError' : ->

                assert.subclassOf ReferenceError, Error

            'SyntaxError' : ->

                assert.subclassOf SyntaxError, Error

            'TypeError' : ->

                assert.subclassOf TypeError, Error

            'URIError' : ->

                assert.subclassOf URIError, Error

    .export module


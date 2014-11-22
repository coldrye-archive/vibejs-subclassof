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


# are we running on Meteor?
if Npm?

    assert = Npm.require 'assert'

else

    assert = require 'assert'
    require './monkeypatch'
    require './subclassof'


assert.subclassOf = (actual, expected, message) ->

    if not subclassof actual, expected

        actualName = actual?.name || actual
        expectedName = expected?.name || expected

        assert.fail actual, expected, message || "expected #{actualName} to be a subclass of #{expectedName}", "subclassof", assert.subclassOf


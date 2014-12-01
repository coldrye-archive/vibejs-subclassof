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


# we always export globally
exports = window ? global


# guard preventing us from installing twice
unless exports.subclassof?

    _subclassofCoffee = (constructor, base) ->

        result = false

        b = constructor.__super__.constructor
        while true

            if b == base

                result = true
                break

            if b.__super__ is undefined

                break

            b = b.__super__.constructor
     
        if not result && b.super_

            result = _subclassofNode b, base

        result



    _subclassofNode = (constructor, base) ->

        result = false

        b = constructor.super_
        while true

            if b == base

                result = true
                break

            if b.__super__

                break

            if b.super_ is undefined

                break

            b = b.super_

        if not result && b.__super__

            result = _subclassofCoffee b, base

        result


    exports.subclassof = (constructor, base) ->

        result = false

        if 'function' != typeof constructor

            throw new TypeError 'constructor must be a function.'

        if 'function' != typeof base

            throw new TypeError 'base must be a function.'

        if base == Object

            # everything is a subclass of Object
            result = true

        else if constructor.__super__

            result = _subclassofCoffee constructor, base

        else if constructor.super_

            result = _subclassofNode constructor, base

        result


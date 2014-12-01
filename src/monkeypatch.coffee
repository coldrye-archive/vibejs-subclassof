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


# We require some monkey patching to make standard classes
# work with subclassof


# Standard Exceptions

# guard preventing us from installing twice
unless EvalError.super_?

    EvalError.super_ = Error
    RangeError.super_ = Error
    ReferenceError.super_ = Error
    SyntaxError.super_ = Error
    TypeError.super_ = Error
    URIError.super_ = Error


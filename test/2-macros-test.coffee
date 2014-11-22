

# while the existing assert.subclassOf macro was used
# in the other tests, we need to test its behaviour
# more explicitly

vows = require 'vows'
assert = require 'assert'

require '../src/macros'


vows.describe 'assert macros tests'

    .addBatch

        'assert.subclassOf must become available' : ->

            assert.isFunction assert.subclassOf

        'must throw AssertionError on assert fail' : ->

            cb = ->

                assert.subclassOf Error, TypeError

            assert.throws cb, assert.AssertionError

        'must not throw on successful assertion' : ->

            cb = ->

                assert.subclassOf TypeError, Error

            assert.doesNotThrow cb

    .export module


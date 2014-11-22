
In order to be able to package this for both NPM and Meteor and
to browserify this for browser only use, the code layout must
not be changed.


NPM:

 - index.coffee
   requires both subclassof and monkeypatch
 - macros.coffee
   requires subclassof and monkeypatch


Meteor:

 - packages monkeypatch and subclassof
 - macros are server only for now


# Polymer 3 migration

## step by step

Make sure to use npm version of 8.x or 10.x.

Follow upgrade guide at https://polymer-library.polymer-project.org/3.0/docs/upgrade.


Attention:

when Modulizer complains about dirty git repo which actually isn't or you just
want to force to execute use this:

```
modulizer --force --out .
```

## possible solution to resolution issues

according to https://github.com/PolymerElements/app-route/issues/231

the problem with resolving '@' pathes that are located in some Polymer files can be solved
by building.

Hope, that doesn't mean you have to build every time (not acceptable) but may be fine as
the 'problem areas' are in the foreign files (Polymer LegacyElement and the like). If we get those
compiled into a build folder and deploy from there instead from the source files directly. 

Or we wait for a general resolution of the problem and live with 2-3 tiny patches (not nice as we would
would keep on hosting our dependencies).


Issue discussiong the problem:
https://github.com/Polymer/polymer/issues/5238

Another possible solution:
https://github.com/PolymerLabs/empathy/tree/initial-implementation

execute in 'components dir':

```
$ npm i --save-dev @0xcda7a/empathy
$ ./node_modules/@0xcda7a/empathy/bin/empathy install
```






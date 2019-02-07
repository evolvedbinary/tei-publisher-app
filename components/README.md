# Polymer 3 migration

## step by step

Make sure to use npm version of 8.x or 10.x.

Follow upgrade guide at https://polymer-library.polymer-project.org/3.0/docs/upgrade.

Essentially this means to execute these steps:

1. install modulizer with `npm install -g polymer-modulizer`
1. update bower to reflect latest state with `bower cache clean && bower install`
1. cd into `components`dir and call 'modulizer out'. This will create a js version of the respective
`.html` version of the respective component.


Attention:

when Modulizer complains about dirty git repo which actually isn't or you just
want to force to execute use this:

```
modulizer --force --out .
```

NOTE: do NOT use the `--import-style name` argument as this will write import pathes that 
use the npm package name (e.g. '@polymer'). More on that further down.

At this stage you should have all components converted to js modules in the components dir
and below. Furthermore a package.json should have been generated in the `components`dir.


Make sure `components` is your current workdir and execute:

```
npm i
```

This will load all npm dependencies of the app into `node_modules` dir.

## problems with resolving npm 'scoped' packages

Many third-party components use package scopes to import their own dependencies. E.g. in 
the `@polymer` package we find a lot of components that use a plain:

```
import '@polymer/...'

```

`@polymer` is the scope here. A scope is meant to group related packages. However scopes
do not resolve in the browser. So when we deploy 'node_modules' as is this will result
in resolution errors (dependencies cannot be loaded).

For reference see [modulizer readme](https://github.com/Polymer/tools/tree/master/packages/modulizer#conversion-options).
Here it's clearly stated that this won't run in browsers directly.

Also see discussion here:
https://github.com/Polymer/polymer/issues/5238


## possible solutions to resolution issues

### using [Empathy](https://github.com/PolymerLabs/empathy/tree/initial-implementation) tool

There's a little (but still unreleased) tool that rewrites scoped package to path notation.

execute in 'components dir':

```
$ npm i --save-dev @0xcda7a/empathy
$ ./node_modules/@0xcda7a/empathy/bin/empathy install
```

For better integration this could be integrated with an npm postinstall hook. See `package.json`.

After execution the converted files will end up in a directory named 'assets'.

### using Polymer build

Polymer build should also do the trick to convert the imports. It can be executed once
to rewrite the imports. However the app deployment would need to be changed to use
the build output directory with the converted files.

Running the build each time during development is certainly not sensible as the build 
process is much too slow to allow fluent work.






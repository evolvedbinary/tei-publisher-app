# Roadmap

 > Startversion: 4.1

The following milestones have been identified as of telco on 27th March 2019.

## Priorities beyond app development

* improve examples and their exposure on tei-publisher.com (high)
* write blog articles to promote new features
* improve layout of homepage (expose examples more)
* improve screencasts (redo gifs as video)
* port older apps like Shakespeare and EEBO to 4.x


## 1. Polymer 3 migration

First step is to complete the migration to Polymer 3 without further
major functional changes in the UI.

Exceptions may occur in implementation details that evolving at the same
time which can be merged upon poly3 branch manually.

This should include to add more tests (potentially mostly 'alive' tests).

 > This step constitutes a new release e.g. 4.5 (if we would be semver
addicts it would be rather a 5.0 as underlying technology is not
backward compatible).

## 2. Migration to PWA starter kit

This involves:

* adapting the conventions of src tree layout that are established
in starter kit. This involves adapting module import pathes.

* merging in the PWA-generated files from a mint template project. A
`template-responsive-drawer-layout` would be a option of choice. 

* hook the existing component classes into the PWA-generated entry page.

* migrate from PBMixin to redux store-connected components. 

 > This could be another release.
 
## 3. App Configurator

App Configurator (formerly knows as 'App Generator') will be a all new
app separating the construction of an app from the result itself.

App Configurator features:
(not necessarily all of the below - just a list of ideas)

* create new apps from predefined base layouts
* customize the app via CSS
* manage ODD-files including creation, editing and applying them
* customize app metadata 
* manage layout templates
* preview app while you're building it
* exporting ready-made standalone apps for production
* optionally allow to customize deployment


## 4. non-scheduled epics and stories

* customize and aggregate components to individualize views
* configuring components visually (live edit)
* optionally provide simple approval workflow for deployment
* automatic versioning of generated apps
* undo support in editors
* deployment support: create new app and auto-install it on same
instance or remote instance




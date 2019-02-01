@wolfgang if i understand right the problem pops up cause we're encapsulating the view now in shadowDOM. I get the point that this is nice to keep docs separate. However i would nevertheless question this.

pb-view shows content and in my understanding of components content is usually kept in lightDOM thereby allowing to be controlled by global CSS. Of course this means that two completely different document might habe conflicting CSS matchers. 

This can be overcome by scoping the CSS to a certain document e.g. by giving the view an id and add this #[id] to every CSS matcher. This would effectively solve the issue but of course cause some work to establish this scoping. 

So - first question: how sensible is it to encapsulate the pb-view? Of course i see that it is tempting to encapsulate the document with its CSS but i'm not at all sure if this is well-aligned with the components idea (though nobody hinders you from doing so). 

I'd like to get this right and often found myself wondering about architectural question in web component world. From my view of things it doesn't feel right to encapsulate the content of a pb-view completely in shadowDOM. pb-view - for me - is a component that dynamically loads content and displays in a panel. In this respect pb-view doesn't know anything about the contents it renders (which is a good thing in the first place). 

If on the other hand a pb-view also encapsulates the content 



-------
ok, lets assume we want it to encapsulated anyway...

I don't think that your option 1. (import external styles dynamically) is in sync with the ideas of web components. Actually there was something similar in Polymer 1 but has been dropped (i guess for reasons). 

What comes closest to this idea however are style modules but these require wrapping the CSS in

`
<dom-module id="my-styles">
    <template>
        <style>

`

and importing them on the component like this:

`
<dom-module id="pb-view">
    <template>
        <style include="my-styles">

`

The style module itself is loaded just like any other component with <link rel="import" ... or by dynamically loading it via

[importHref](https://www.polymer-project.org/2.0/docs/api/#function-Polymer.importHref)

I'm quite opposed to your option 2 as this mixes 2 very different things inside of the odd. The odd suddenly becomes 'responsible' for the whole page and not just the document which is odd (sorry for the pun ;) Both 'world' should stay separate IMHO. 

Further - doesn't that mean if i got several different odds to render a document on the web i have to redundantly keep global styles in all these odds?




-----------

i need to dissect the problem to sort it out for me....

1. in your second sentence @wolfgang: 'This has many benefits...'. Actually i see just one: the encapsulation of the CSS. This is certainly an interesting one but beyond that i don't see any benefits. The different instances of pb-view are separate entities anyway. Just to get this clear - the problem is about style  encapsulation or scoping right?

2. i still think that our initial recommendation is architecturally right and defines how it should be as this clearly separates these very different scopes: we have one scope that handles the looks of the website and a different (or several different) one which handles the looks of a document (controlled by the ODD editor)

What actually puzzles me is this statement (@wolfgang):

>  is no longer possible and the only means to apply styles is via the ODD.

1. how does the situation changes for global CSS for instance? We still have a global CSS that controls the looks of our website right? So this part stays as is at least (i must somehow miss something)

2. What is meant by 'the only means to apply styles is via the ODD'? 
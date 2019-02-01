/* Deprecated, replace with style module */
/*
  FIXME(polymer-modulizer): the above comments were extracted
  from HTML and may be out of place here. Review them and
  then delete this comment!
*/
import { PolymerElement } from '../@polymer/polymer/polymer-element.js';

const $_documentContainer = document.createElement('template');

$_documentContainer.innerHTML = `<dom-module id="pb-code-highlight">
    <!-- Deprecated, replace with style module -->
    
    <template>
        <style>
            :host {
                display: block;
            }
        </style>
        <pre id="code" class\$="[[lang]]"></pre>
        <slot></slot>
    </template>

    
</dom-module>`;

document.head.appendChild($_documentContainer.content);
/**
 * An element for syntax highlighting code based on `highlight.js`.
 * Mainly used from the ODD for the TEI Publisher documentation.
 *
 * todo: check status of this component - still used in docbook.odd
 *
 * @customElement
 * @polymer
 * @demo demo/pb-code-highlight.html
 */
class PbCodeHighlight extends PolymerElement {
    static get is() {
        return 'pb-code-highlight';
    }

    static get properties() {
        return {
            /**
             * The language to be used for syntax highlighting.
             */
            lang: {
                type: String,
                value: "text"
            }
        };
    }

    connectedCallback() {
        super.connectedCallback();
    }

    ready(){
        super.ready();
        this.$.code.innerHTML = this.innerHTML;
        this.innerHTML = "";
        hljs.highlightBlock(this.$.code);
    }
}

window.customElements.define(PbCodeHighlight.is, PbCodeHighlight);

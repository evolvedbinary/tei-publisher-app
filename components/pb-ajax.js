import { PolymerElement } from './assets/@polymer/polymer/polymer-element.js';
import './pb-mixin.js';
import './assets/@polymer/iron-ajax/iron-ajax';

const $_documentContainer = document.createElement('template');

$_documentContainer.innerHTML = `<dom-module id="pb-ajax">
    <template strip-whitespace="">
        <style>
            :host {
                display: block;
            }

            paper-dialog {
                position: static;
                z-index: 1000;
            }
        </style>

        <a id="button" on-click="_handleClick" title="[[title]]"><slot></slot></a>

        <iron-ajax id="loadContent" url="[[url]]" verbose="" handle-as="text" method="get" on-response="_handleResponse"></iron-ajax>
    </template>

    
</dom-module>`;

document.head.appendChild($_documentContainer.content);
/**
 * Triggers an action on the server and shows a dialog
 * upon completion. Used for the "recompile ODD" and other
 * actions.

 * The parameters sent to the server-side script will be copied
 * from the `pb-view` to which this component subscribes.
 *
 * @customElement
 * @polymer
 * @appliesMixin PbMixin
 */
class PbAjax extends PbMixin(PolymerElement) {
    static get is() {
        return 'pb-ajax';
    }

    static get properties() {
        return {
            /**
             * the URL to send a request to
             */
            url: {
                type: String
            },
            /**
             * title of link that triggers the request
             */
            title: {
                type: String
            },
            /**
             * id of a dialog component used to display the response to the request.
             */
            dialog: {
                type: String
            }
        };
    }

    connectedCallback() {
        super.connectedCallback();
    }

    ready() {
        super.ready();
        this.subscribeTo('pb-update', this._onUpdate.bind(this));
    }

    _handleClick(ev) {
        ev.preventDefault();
        this.emitTo('pb-start-update');
        this.$.loadContent.generateRequest();
    }

    _handleResponse() {
        this.emitTo('pb-end-update');
        const resp = this.$.loadContent.lastResponse;
        const dialog = document.getElementById(this.dialog);
        const body = dialog.querySelector("paper-dialog-scrollable");
        body.innerHTML = resp;
        dialog.open();
    }

    _onUpdate(ev) {
        this.$.loadContent.params = ev.detail.params;
    }
}

window.customElements.define(PbAjax.is, PbAjax);

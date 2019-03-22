import {html, PolymerElement} from './assets/@polymer/polymer/polymer-element.js';

/**
 * `pb-label`
 *
 * outputs a label. Used in conjunction with i18n module to output language-specific labels generated by the host.
 *
 * @customElement
 * @polymer
 * @demo demo/index.html
 */
class PbLabel extends PolymerElement {
    static get template() {
        return html`
      <style>
        :host {
          display: inline-block;
        }
      </style>
      <span>[[label]]</span>
    `;
    }

    static get properties() {
        return {
            label: {
                type: String,
                value: '',
            },
        };
    }
}

window.customElements.define('pb-label', PbLabel);
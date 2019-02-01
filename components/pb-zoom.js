import { PolymerElement } from '../@polymer/polymer/polymer-element.js';
import './pb-mixin.js';
import { html } from '../@polymer/polymer/lib/utils/html-tag.js';
/**
 * Zoom button to enlarge/shrink the font for the views. This component does not
 * implement any functionality itself, but just emits a `pb-zoom` event.
 *
 * @customElement
 * @polymer
 * @appliesMixin PbMixin
 */
class PbZoom extends PbMixin(PolymerElement) {
  static get template() {
    return html`
        <style>
            :host {
                display: block;
            }
        </style>

        <paper-icon-button icon="{{icon}}" on-click="_handleClick"></paper-icon-button>
`;
  }

  static get is() {
      return 'pb-zoom';
  }

  static get properties() {
      return {
          /**
           * The icon to use
           */
          icon: {
              type: String,
              value: "icons:zoom-in"
          },
          /**
           * Either 'in' or 'out'
           */
          direction: {
              type: String,
              value: 'in'
          }
      };
  }

  connectedCallback() {
      super.connectedCallback();
  }

  ready() {
      super.ready();
  }

  _handleClick() {
      this.emitTo('pb-zoom', {direction: this.direction});
  }

  /**
   * Fired when the user clicks the element.
   *
   * @event pb-zoom
   * @param {String} direction: either 'in' or 'out'
   */
}

window.customElements.define(PbZoom.is, PbZoom);

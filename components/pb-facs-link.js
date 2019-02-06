import { PolymerElement } from './assets/@polymer/polymer/polymer-element.js';
import { html } from './assets/@polymer/polymer/lib/utils/html-tag.js';
/**
 * `pb-facs-link`
 *
 * todo: no usage found in project. Still needed?
 *
 * @customElement
 * @polymer
 * @demo demo/pb-facsimile.html
 */
class PbFacsLink extends PbMixin(PolymerElement) {
  static get template() {
    return html`
        <style>
            :host {
            }

            a, a:link {
                text-decoration: none;
                color: inherit;
            }
        </style>

        <a href="#" on-mouseover="_mouseoverListener"><slot></slot></a>
`;
  }

  static get is() {
      return 'pb-facs-link';
  }

  static get properties() {
      return {
          /** URL pointing to the facsimile image to load */
          facs: {
              type: String
          },
          /** An array of coordinates describing a rectangle to highlight */
          coordinates: {
              type: Array
          }
      };
  }

  connectedCallback() {
      super.connectedCallback();
  }

  ready(){
      super.ready();
  }

  _mouseoverListener(ev) {
      ev.preventDefault();
      console.log("facs-link: %s %o", this.facs, this.coordinates);
      this.emitTo('pb-show-annotation', {
          file: this.facs,
          coordinates: this.coordinates
      });
  }

  /**
   * Fires when mouse hovers a pb-facs-link
   *
   * @event pb-show-annotation
   * @param {String} file - reference to facsimile file
   * @param {String} coordinates to highlight
   */
}

window.customElements.define(PbFacsLink.is, PbFacsLink);

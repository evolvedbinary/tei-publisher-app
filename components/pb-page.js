import { html } from '../@polymer/polymer/lib/utils/html-tag.js';
import { afterNextRender } from '../@polymer/polymer/lib/utils/render-status.js';
import { PolymerElement } from '../@polymer/polymer/polymer-element.js';
/**
 * A wrapper element around a TEI Publisher page. Currently mainly used to take care of resizing issues.
 *
 *
 * @customElement
 * @polymer
 */
class PbPage extends PolymerElement {
  static get template() {
    return html`
        <style>
            :host {
                display: block;
            }
        </style>

        <slot></slot>
`;
  }

  static get is() {
      return 'pb-page';
  }

  static get properties() {
      return {
          appRoot: {
              type: String
          },
          template: {
              type: String
          }
      };
  }

  connectedCallback() {
      super.connectedCallback();
  }

  ready() {
      super.ready();
      afterNextRender(this, () => {
          console.log('<pb-page> trigger window resize');
          this.querySelectorAll('app-header').forEach(h => h._notifyLayoutChanged());
      });
  }
}

window.customElements.define(PbPage.is, PbPage);

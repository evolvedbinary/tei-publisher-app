import { PolymerElement } from './assets/@polymer/polymer/polymer-element.js';
import { html } from './assets/@polymer/polymer/lib/utils/html-tag.js';
import { afterNextRender } from './assets/@polymer/polymer/lib/utils/render-status.js';
import './assets/@polymer/polymer/lib/utils/render-status.js';
import './assets/@polymer/app-layout/app-drawer-layout/app-drawer-layout.js';
import './assets/@polymer/app-layout/app-drawer/app-drawer.js';
import './assets/@polymer/app-layout/app-header-layout/app-header-layout.js';
import './assets/@polymer/app-layout/app-header/app-header.js';
import './assets/@polymer/app-layout/app-toolbar/app-toolbar.js';
import './assets/@polymer/paper-dialog/paper-dialog.js';

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

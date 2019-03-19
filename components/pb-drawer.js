import { PolymerElement } from './assets/@polymer/polymer/polymer-element.js';
import { html } from './assets/@polymer/polymer/lib/utils/html-tag.js';
import { PbMixin} from './pb-mixin.js';
import './assets/@polymer/iron-form/iron-form.js';
import './pb-select-odd.js';
import './assets/@polymer/paper-input/paper-input.js';
import './assets/@polymer/paper-dropdown-menu/paper-dropdown-menu.js';
import './assets/@polymer/paper-listbox/paper-listbox.js';
import './assets/@polymer/paper-item/paper-item.js';
import './assets/@polymer/paper-button/paper-button.js';
import './assets/@polymer/iron-ajax/iron-ajax.js';


/**
 * `pb-drawer`
 *
 * A drawer component used e.g. for table-of-contents
 *
 *
 * @customElement
 * @polymer
 */
class PbDrawer extends PbMixin(PolymerElement) {
  static get template() {
    return html`
        <style>
            :host {
                position: fixed;
                width: 0;
                left: -448px;
                bottom: 0;
                height: 100vh;
                z-index: 1000;
                overflow: auto;
                display: block;
                transition: .5s;
            }

            :host([opened]) {
                left: 0;
                width: 448px;
                transition: .5s;
            }

            .drawer-content {
                padding: 10px 10px;
            }
        </style>

        <div class="drawer-content"><slot></slot></div>
`;
  }

  static get is() {
      return 'pb-drawer';
  }

  static get properties() {
      return {
          /**
           * optional id reference to a component that allows opening/closing the drawer
           */
          toggle: {
              type: String
          },
          /**
           * Boolean reflecting the opened/closed state of the drawer
           */
          opened: {
              type: Boolean,
              reflectToAttribute: true,
              value: false
          }
      };
  }

  connectedCallback() {
      super.connectedCallback();
      const toggle = document.getElementById(this.toggle);
      if (toggle) {
          toggle.addEventListener('click', this._toggle.bind(this));
      }

      document.body.addEventListener('click', (ev) => {
          if (ev.target !== toggle && this.opened) {
              this.className = '';
              this.opened = false;
          }
      });

      this.addEventListener('click', (ev) => ev.stopPropagation());

      this.subscribeTo('pb-refresh', this._close.bind(this));
  }

  _toggle(ev) {
      ev.preventDefault();
      if (this.opened) {
          this.className = '';
          this.opened = false;
      } else {
          this.className = 'open';
          this.opened = true;
          this.emitTo('pb-load');
      }
  }

  _close() {
      this.className = '';
      this.opened = false;
  }
}

window.customElements.define(PbDrawer.is, PbDrawer);

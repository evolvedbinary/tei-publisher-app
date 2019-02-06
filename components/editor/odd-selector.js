import { PolymerElement } from '../assets/@polymer/polymer/polymer-element.js';
import { html } from '../assets/@polymer/polymer/lib/utils/html-tag.js';
import '../assets/@polymer/paper-dropdown-menu/paper-dropdown-menu';
import '../assets/@polymer/paper-listbox/paper-listbox';
import '../assets/@polymer/paper-item/paper-item';

/**
 * `odd-selector`
 *
 *
 * @customElement
 * @polymer
 */
class OddSelector extends PolymerElement {
  static get template() {
    return html`
        <style>
            :host {
                display: block;
                width: 100%;
            }

            paper-dropdown-menu{
                width:100%;
            }

            ::slotted(paper-item){
                width:100%;
            }
        </style>

        <paper-dropdown-menu label="Editing ODD:">
            <paper-listbox id="select" name="odd" slot="dropdown-content" attr-for-selected="value" on-iron-select="_selectOdd" selected="{{selected}}">
                <slot></slot>
            </paper-listbox>
        </paper-dropdown-menu>
`;
  }

  static get is() {
      return 'odd-selector';
  }

  static get properties() {
      return {
          selected:{
              type: String
          }
      };
  }

  _selectOdd() {
      this.dispatchEvent(new CustomEvent('odd-selected', {detail: {odd: this.$.select.selected}}))
  }

  connectedCallback() {
      super.connectedCallback();
  }
}

window.customElements.define(OddSelector.is, OddSelector);
